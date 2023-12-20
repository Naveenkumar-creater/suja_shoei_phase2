import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/lottieLoadingAnimation.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';
import 'package:suja_shoie_app/feature/presentation/api_services/datapoint_service.dart';
import 'package:suja_shoie_app/feature/presentation/api_services/get_checklist_details_service.dart';
import 'package:suja_shoie_app/feature/presentation/providers/additional_datapoint_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/checklist_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/datapoint_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/get_checklist_details_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/qrscanner_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';
import 'package:suja_shoie_app/feature/presentation/widget/checklist_details/additional_datapoint.dart';

import '../../../constant/utils/image_base64.dart';
import '../../../constant/utils/show_snakbar.dart';
import '../../../models/chepoint_request.model.dart';
import '../../data/core/api_constant.dart';
import '../api_services/initate_pause_service.dart';
import '../api_services/operator_service.dart';
import '../providers/operator_provider.dart';
import '../widget/checklist_details/take_photo.dart';
import '../widget/home_page_widget/work_schedule/assetlist_workschedule/asset_list_workschedule.dart';
import '../widget/home_page_widget/work_schedule/qr_workorder_data/qr_checlist_card.dart';

class CheckPointDetails extends StatefulWidget {
  final int planId;
  final List<File?>? capturedImages;
  final int? pageId;
  final int? acrpinspectionstatus;
  final int? assetId;

  const CheckPointDetails(
      {super.key,
      required this.planId,
      this.assetId,
      this.capturedImages,
      this.pageId,
      this.acrpinspectionstatus});

  @override
  _CheckPointDetailsState createState() => _CheckPointDetailsState();
}

class _CheckPointDetailsState extends State<CheckPointDetails> {
  final GetChecklistService _checkListService = GetChecklistService();
  final TextEditingController numberController = TextEditingController();
  final InitiatePauseService initiatePauseService = InitiatePauseService();
  final ImageBase64 imageBase64 =ImageBase64();

  String personName = ''; // State variable to store the personName

  bool isLoading = true;
  bool isTextFieldVisible = true;
  bool isOperatorIdEntered = false;
  bool showDataPointsButton = false;
  // Store the entered data for each popup
  Map<int, Map<String, dynamic>> popupData = {};
  List<List<String>> selectedDropdownValues = [];

  // Step 2: Create a map to store the fetched "Data Points" data
  Map<int, List<String>> dataPointValuesMap = {};
  Map<int, List<String>> userEnteredDataPoints = {};
  Map<int, List<DataEntry>> myStatefulWidgetDataMap = {};
  final GlobalKey<FormState> operatorFormKey = GlobalKey<FormState>();

  void pauseStatus() {
    initiatePauseService.initiatePause(context: context, id: widget.planId);
  }

  String getStatusIcon(int method) {
    if (method == 1) {
      return 'assets/images/eye.png';
    } else if (method == 2) {
      return 'assets/images/hand.png';
    } else if (method == 3) {
      return 'assets/images/ear.png';
    } else {
      return 'assets/images/Eye hand Images.png';
    }
  }

  String responsibilityRole(int method) {
    if (method == 1) {
      return 'Operator';
    } else {
      return 'Maintenance Engineer';
    }
  }

  int setStatusValue(String status) {
    switch (status) {
      case "Passed":
        return 1;
      case "Failed":
        return 2;
      case "Conditionally Passed":
        return 3;
      case "Not Applicable":
        return 4;
      default:
        return 0; // Handle unknown status here
    }
  }

  String getStatusValue(int status) {
    switch (status) {
      case 1:
        return "Passed";
      case 2:
        return "Failed";
      case 3:
        return "Conditionally Passed";
      case 4:
        return "Not Applicable";
      default:
        return "Select Answer"; // Handle unknown status here
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCheckList();
  }

  Future<void> _fetchCheckList() async {
    try {
      final responseData = await _checkListService.getCheckListDetails(
          context: context,
          planId: widget.planId ?? 0,
          acrpinspectionstatus: widget.acrpinspectionstatus ?? 0);
      setState(() {
        isLoading = false;
      });
      final response =
          Provider.of<GetCheckListDetailsProvider>(context, listen: false)
              .user
              ?.responseData;

      if (response != null) {
        final checklist = response.getChecklistDetails ?? [];

        selectedDropdownValues = List.generate(
          checklist.length,
          (index) =>
              [getStatusValue(checklist[index].acrdcheckpointinspectionresult)],
        );

        // Set the initial dropdown values based on checklist data here
        for (int index = 0; index < checklist.length; index++) {
          var newValue =
              getStatusValue(checklist[index].acrdcheckpointinspectionresult);
          selectedDropdownValues[index] = [newValue];

          if (newValue == "Failed" || newValue == "Conditionally Passed") {
            showDataPointsButton = true;
          } else if (newValue == "Passed") {
            showDataPointsButton = true;
          } else if (newValue == "Select Answer" ||
              newValue == "Not Applicable") {
            showDataPointsButton = true;
          } else {
            showDataPointsButton = false;
          }
        }
      }
    } catch (e) {
      print('Error fetching checklist: $e');
      isLoading = false;
    }
  }

  void _handleDropdownChange(int index, String newValue) {
    setState(() {
      final String previousValue = selectedDropdownValues[index].first;

      if (previousValue != newValue) {
        // Clear all fields when the previous value is different from the new value
        userEnteredDataPoints[index] = List<String>.filled(
          selectedDropdownValues.length,
          "", // Clear the text field value
          growable: true,
        );
      }

      while (selectedDropdownValues.length <= index) {
        selectedDropdownValues.add(["Select Answer"]);
      }
      selectedDropdownValues[index] = [newValue]; // Update the selected value

      if (newValue == "Failed" || newValue == "Conditionally Passed") {
        _showPopup(context, index);
        showDataPointsButton = true;
      } else if (newValue == "Passed") {
        showDataPointsButton = true;
      } else if (newValue == "Select Answer" || newValue == "Not Applicable") {
        showDataPointsButton = true;
      } else {
        showDataPointsButton = false;
      }
    });
  }

  bool isSnackbarShown = false;
  bool isHandlingSubmit = false; // Add this flag

  void handleSubmit() {
    if (isHandlingSubmit) {
      return; // Return early if already handling a submission
    }

    isHandlingSubmit = true;

    String personId = numberController.text;

    if (personId.isEmpty) {
      setState(() {
        personName = 'Person ID is required';
        isTextFieldVisible = true;
      });

      isHandlingSubmit = false; // Reset the flag
    } else {
      OperatorService operatorService = OperatorService();
      operatorService
          .getOperatorName(personId: personId, context: context)
          .then((result) {
        var operator =
            Provider.of<OperatorProvider>(context, listen: false).user;

        if (operator != null && operator.employeeNumber == personId) {
          setState(() {
            personName = operator.personfname ?? 'Operator name not found';
            isTextFieldVisible = false;
          });
        } else {
          setState(() {
            isTextFieldVisible = true;
            personName = '';
          });

          // Show the Snackbar only if it hasn't been shown yet
          if (!isSnackbarShown) {
            isSnackbarShown =
                true; // Set the flag to true after showing the Snackbar
          }
        }

        isHandlingSubmit = false; // Reset the flag
      }).catchError((error) {
        setState(() {
          personName = 'Error: $error';
          isTextFieldVisible = false;
        });

        isHandlingSubmit = false; // Reset the flag
      });
    }
  }

  Future<void> _fetchDataPoints(int index) async {
    DataPointService dataPointService = DataPointService();

    final responseData =
        Provider.of<GetCheckListDetailsProvider>(context, listen: false)
            .user
            ?.responseData;
    final checklist = responseData?.getChecklistDetails ?? [];

    if (checklist.isNotEmpty && index < checklist.length) {
      final acrdId = checklist[index].acrdid;

      // Fetch "Data Points" data using dataPointService.getDatapoints
      final dataPoints = await dataPointService.getDatapoints(
        context: context,
        acrdId: acrdId,
      );

      dataPointValuesMap[index] = dataPoints ?? [];

      // Initialize user-entered data points if not already done
      if (!userEnteredDataPoints.containsKey(index)) {
        userEnteredDataPoints[index] = List<String>.filled(
          dataPointValuesMap[index]!.length,
          "", // Initialize with empty strings
          growable: true,
        );
      }
    }
  }

  // Future<List<String>> convertFilePathsToBase64(List<String> filePaths) async {
  //   List<String> base64Images = [];

  //   for (var filePath in filePaths) {
  //     if (filePath.isNotEmpty) {
  //       final file = File(filePath);
  //       if (await file.exists()) {
  //         final image = img.decodeImage(await file.readAsBytes());

  //         if (image != null) {
  //           // Resize the image to a smaller dimension
  //           final resizedImage = img.copyResize(image, width: 600, height: 400);
  //           final resizedImageBytes = img.encodeJpg(resizedImage, quality: 20);

  //           String base64String = base64Encode(resizedImageBytes);

  //           base64Images.add(base64String);
  //         } else {
  //           // Handle the case where image decoding fails
  //           base64Images.add(''); // Add an empty string or another placeholder
  //         }
  //       } else {
  //         // Handle the case where the file doesn't exist (if needed)
  //         base64Images.add(''); // Add an empty string or another placeholder
  //       }
  //     } else {
  //       // Handle the case where the file path is empty (if needed)
  //       base64Images.add(''); // Add an empty string or another placeholder
  //     }
  //   }

  //   return base64Images;
  // }

  Future submitChecklist(BuildContext context, apifor, statusName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("client_token") ?? "";
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    var operator =
        Provider.of<OperatorProvider>(context, listen: false).user?.personid;

    final responseData =
        Provider.of<GetCheckListDetailsProvider>(context, listen: false)
            .user
            ?.responseData;
    final checklist = responseData?.getChecklistDetails ?? [];

    List<String>? headerImagesPaths = widget.capturedImages
        ?.map((file) => file != null ? file.path : '')
        .toList();

    List<String> base64HeaderImages =
        await imageBase64.convertFilePathsToBase64(headerImagesPaths!);

    final checklistRequest = ChecklistRequest(
      clientAuthToken: token,
      apiFor: apifor,
      fromDateTime: ApiConstant.fromDate,
      toDateTime: toDate,
      clientId: "vijay",
      acrhAcmphId: checklist.first.acrhacmphid,
      acrhid: checklist.first.acrhid,
      planid: checklist.first.planid,
      operatorId: operator ?? 0,
      headerimage: base64HeaderImages,
      checkPoints: [],
      statusId: statusName,
    );

    // Populate checkPoints list with your checkpoint data
    for (int index = 0; index < checklist.length; index++) {
      final asset = checklist[index];

      final responseData =
          Provider.of<DataPointProvider>(context, listen: false)
              .user
              ?.responseData;

      final datapointDescriptions = responseData?.checklistDatapointsList
              .map((e) => e.amdpDatapointDescription)
              .toList() ??
          [];

      final dataAcrdp = responseData?.checklistDatapointsList
              .map((e) => e.acrdpId)
              .toList() ??
          [];

      final dataPoints = userEnteredDataPoints[index] ?? [];

      // Filter out empty datapoints
      final filteredDataPoints = dataPoints
          .asMap()
          .entries
          .where((entry) =>
              entry.value.isNotEmpty &&
              entry.key < datapointDescriptions.length &&
              datapointDescriptions[entry.key].isNotEmpty == true)
          .toList();

      // List<String> assetImages = await convertFilePathsToBase64(imagesList);
      final responseAddData =
          Provider.of<AdditionalDataPointProvider>(context, listen: false)
              .user
              ?.responseData;

      final addDatapointDescription = responseAddData?.additionaldatapointslist
              .map((e) => e.amdpDatapointDescription)
              .toList() ??
          [];

      final adddata = myStatefulWidgetDataMap[index] ?? [];

// Filter out empty datapoints
      final filteredAdditionalData = adddata
          .asMap()
          .entries
          .where((entry) =>
              entry.key < addDatapointDescription.length &&
              addDatapointDescription[entry.key].isNotEmpty == true)
          .toList();

      final checkpoint = ChecklistCheckpoint(
        acrdId: asset.acrdid,
        acrdCheckpointStatus:
            setStatusValue(selectedDropdownValues[index].first),
        acrdCheckpointNotes: popupData[index]?['note'] ?? "",

        datapoints: [],
        images: [], // Initialize the datapoints list for this checkpoint
      );

      final imagesList = (popupData[index]?['images'] as List<File?>?)
          ?.where((image) {
            if (image != null) {
              final imagePath = image.path.toLowerCase();

              // Check if it's a local file path (not starting with "http://" or "https://")
              // and matches the allowed format
              if (!Uri.parse(imagePath).isAbsolute &&
                  imagePath.startsWith(
                      "/data/user/0/com.example.suja_shoie_app/cache/")) {
                return true; // Include the local file path
              }
            }
            return false;
          })
          .map((image) => image?.path ?? "")
          .toList();

      List<String> listOfImage =
          await imageBase64.convertFilePathsToBase64(imagesList ?? []);
      checkpoint.images?.addAll(listOfImage ?? []);

      for (final entry in filteredAdditionalData) {
        final i = entry.key;
        final dataEntry =
            entry.value; // Assuming entry.value is a DataEntry object
        final addDatapoint = ChecklistDataPoint(
          amdpDatapointId: dataEntry.amdpId,
          acrdpId: 0,
          amdpDatapointDescription: dataEntry.option, // Use entry.option here
          acrdpDatapointValue:
              dataEntry.dataPoints, // Access the value property
        );

        checkpoint.datapoints
            ?.add(addDatapoint); // Add this datapoint to the current checkpoint
      }

      for (final entry in filteredDataPoints) {
        final i = entry.key;
        final datapoint = ChecklistDataPoint(
          amdpDatapointId: i + 1,
          acrdpId: dataAcrdp[i] ?? 0,
          amdpDatapointDescription: datapointDescriptions[i] ?? "",
          acrdpDatapointValue: entry.value ?? "",
        );

        checkpoint.datapoints
            ?.add(datapoint); // Add this datapoint to the current checkpoint
      }

      checklistRequest.checkPoints
          ?.add(checkpoint); // Add the checkpoint to the checklist
    }

    final requestBody = jsonEncode(checklistRequest.toJson());

    print(requestBody);

    const timeoutDuration = Duration(seconds: 30);
    try {
      http.Response response = await http
          .post(
            Uri.parse(ApiConstant.baseUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: requestBody,
          )
          .timeout(timeoutDuration);

      // ignore: avoid_print
      print(response.body);

      if (response.statusCode == 200) {
        try {
          final responseJson = jsonDecode(response.body);
          print(responseJson);
          return responseJson;
        } catch (e) {
          // Handle the case where the response body is not a valid JSON object
          throw ("Invalid JSON response from the server");
        }
      } else {
        throw ("Server responded with status code ${response.statusCode}");
      }
    } on TimeoutException {
      throw ('Connection timed out. Please check your internet connection.');
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }

  void _navigateBack() {
    final response = Provider.of<CheckListProvider>(context, listen: false)
        .user
        ?.responseData;
    final asset = response?.checklist ?? [];

    final qrresponse = Provider.of<QrScannerProvider>(context, listen: false)
        .user
        ?.responseData;
    final qrasset = qrresponse?.checklist ?? [];
    if (widget.pageId == 1) {
      // Access the flag from the widget
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QrCheklistCard(qrasset.first.assetbarcode),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CheckListCardView(
              //  widget.assetId,
              asset.first.acrpassetId),
        ),
      );
    }
  }

  void _submitPop(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Container(
                width: 200,
                height: 150,
                color: Colors.white,
                child: Column(children: [
                  const Text("Confirm you submission"),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (personName.isNotEmpty && !isTextFieldVisible) {
                              try {
                                final response = await submitChecklist(
                                    context, "submit_checklist", 3);
                                if (response['response_code'] == 4 ||
                                    response['response_code'] == 5 ||
                                    response['response_code'] == 6) {
                                  ShowError.showAlert(
                                      context, response['response_msg']);
                                } else {
                                  // If response_code is not 4, 5, or 6, proceed to _navigateBack()
                                  _navigateBack();
                                  popupData.clear();
                                  userEnteredDataPoints.clear();
                                  myStatefulWidgetDataMap.clear();
                                  numberController.clear();
                                }
                              } catch (error) {
                                // Handle and show the error message here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error.toString()),
                                    backgroundColor: Colors.amber,
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text("Submit"),
                        ),

                        // ElevatedButton(
                        //     onPressed: () {
                        //       submitChecklist(context, "submit_checklist", 3);
                        //       _navigateBack();

                        //       popupData.clear();
                        //       userEnteredDataPoints.clear();
                        //       myStatefulWidgetDataMap.clear();
                        //       numberController.clear();
                        //     },
                        //     child: const Text("Submit")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Go back")),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }

  Future<void> _showPopup(BuildContext context, int index) async {
    await _fetchDataPoints(index);
    final responseData =
        Provider.of<GetCheckListDetailsProvider>(context, listen: false)
            .user
            ?.responseData;
    final checklist = responseData?.getChecklistDetails ?? [];

    List<TextEditingController> datapointControllers = [];

    // List imageFiles = [];

    final serverImage = Provider.of<DataPointProvider>(context, listen: false)
        .user
        ?.responseData;

    final imageUrls = serverImage?.detailImageUrl ?? [];

    List<File?> capturedImg = []; // Initialize capturedImg with an empty list

    Map<String, dynamic> initialData = popupData[index] ??
        {
          'note': checklist[index].notes,
          'images': capturedImg,
        };

    List<File?> capturedImages =
        (initialData['images'] as List?)?.cast<File?>() ?? [];

    List<String> dataPointValues = userEnteredDataPoints[index] ??
        List<String>.filled(
          selectedDropdownValues.length,
          "",
          growable: true,
        );

    for (String imageUrl in imageUrls) {
      final uniqueUrl = Uri.parse(imageUrl)
          .replace(
              query:
                  'timestamp=${DateTime.now().millisecondsSinceEpoch}-${UniqueKey().toString()}')
          .toString();

      // Download the image and convert it to a file
      final response = await http.get(Uri.parse(uniqueUrl));
      final List<int> bytes = response.bodyBytes;

      // Get the app's document directory to store the files
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      final String filePath =
          '${appDocumentDirectory.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Write the bytes to a file
      File file = File(filePath);
      await file.writeAsBytes(bytes);

      capturedImg.add(file);
    }
    // Load previously captured images

    // Access notes, provide a default value if null

    // TextEditingController descriptionController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Pre-fill the input fields with initial data
    var noteValue = "";

    TextEditingController noteController = TextEditingController();

    noteController.text = initialData['note'];

    // descriptionController.text = initialData['description'];

    List<DataEntry> localDataEntries = myStatefulWidgetDataMap[index] ?? [];

    void onMyStatefulWidgetDataChanged(int index, List<DataEntry> newData) {
      setState(() {
        myStatefulWidgetDataMap[index] = newData;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: AlertDialog(
                backgroundColor: Colors.white,
                content: Container(
                  width: 500,
                  height: 700,
                  color: Colors.white,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Add Images        :'),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: ImageCapture(
                                capturedImages: capturedImages,
                                onImagesCaptured: (updatedImages) {
                                  setState(() {
                                    capturedImages = updatedImages;
                                    popupData[index]?['images'] =
                                        capturedImages;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Text('Add Notes           :'),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: noteController,
                                onChanged: (value) {
                                  noteValue = value;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Enter Notes',
                                  contentPadding:
                                      EdgeInsets.all(defaultPadding * 3),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.yellow,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: '',
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                                validator: (value) {
                                  if (selectedDropdownValues[index].first !=
                                      "Passed") {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter the Notes';
                                    }
                                    //                                 if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                    //   return 'Cannot contain special symbols';
                                    // }
                                    if (value.startsWith(' ')) {
                                      return 'Notes cannot start with a space';
                                    }
                                  }
                                  return null; // Return null when "Passed" is selected
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Consumer<DataPointProvider>(
                          builder: (context, DetailsProvider, _) {
                            final response = DetailsProvider.user?.responseData;
                            final datapoint = response?.checklistDatapointsList;
                            // Ensure that datapointValues has at least as many elements as datapoint
                            datapointControllers = List.generate(
                              datapoint?.length ?? 0,
                              (index) {
                                if (index < datapoint!.length) {
                                  final initialValue = datapoint[index]
                                      .datapointValue
                                      .toString();
                                  return TextEditingController(
                                    text: initialValue,
                                  );
                                } else {
                                  // Handle the case where dataPointValues is shorter than datapoint
                                  return TextEditingController();
                                }
                              },
                            );
                            // Update the TextEditingController objects with locally stored values
                            if (userEnteredDataPoints.containsKey(index)) {
                              final List<String> storedValues =
                                  userEnteredDataPoints[index]!;
                              for (int i = 0; i < storedValues.length; i++) {
                                if (i < datapointControllers.length) {
                                  // Update existing TextEditingController
                                  datapointControllers[i].text =
                                      storedValues[i];
                                } else {
                                  // Create and add a new TextEditingController for missing values
                                  datapointControllers.add(
                                      TextEditingController(
                                          text: storedValues[i]));
                                }
                              }
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Data Point:"),
                                Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        AdditionalDataPoint(
                                          initialData: localDataEntries,
                                          onEntryAdded: (entry) {
                                            setState(() {
                                              localDataEntries.add(entry);
                                              onMyStatefulWidgetDataChanged(
                                                  index, localDataEntries);
                                            });
                                          },
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: datapoint?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            final item = datapoint?[index];

                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: defaultPadding,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: defaultPadding,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 135,
                                                      child: Text(
                                                          "${item?.amdpDatapointDescription}"),
                                                    ),
                                                    const Text(":"),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    SizedBox(
                                                      width: 275,
                                                      height:
                                                          60, // Set the desired height here
                                                      child: TextFormField(
                                                        controller:
                                                            datapointControllers[
                                                                index],
                                                        onChanged: (value) {
                                                          if (index >= 0 &&
                                                              index <
                                                                  dataPointValues
                                                                      .length) {
                                                            // Check if the index is within the valid range
                                                            dataPointValues[
                                                                index] = value;
                                                          }
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Enter Value',
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  defaultPadding),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.yellow,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          hintText: '',
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        validator: (value) {
                                                          if (selectedDropdownValues[
                                                                          index]
                                                                      .first !=
                                                                  "Passed" &&
                                                              (value == null ||
                                                                  value
                                                                      .isEmpty)) {
                                                            return 'Required Field';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Store the data in a map
                                  if (formKey.currentState!.validate()) {
                                    final Map<String, dynamic> data = {
                                      'note': noteController.text,
                                      // 'description':
                                      //     descriptionController.text ?? "",
                                      // 'dataPoints': dataPointValues,
                                      'images':
                                          capturedImages, // Store captured images
                                    };

                                    popupData[index] = data;
                                    final List<String> editedValues =
                                        datapointControllers
                                            .map(
                                                (controller) => controller.text)
                                            .toList();

                                    userEnteredDataPoints[index] = editedValues;

                                    myStatefulWidgetDataMap[index] =
                                        localDataEntries;

                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text(
                                  "Okay",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    // popupData.clear();
                                    // userEnteredDataPoints.clear();
                                    // myStatefulWidgetDataMap.clear();

                                    if (selectedDropdownValues[index].first !=
                                        "Passed") if (!formKey.currentState!.validate()) {
                                      selectedDropdownValues[index] = [
                                        "Select Answer"
                                      ];
                                    }
                                  });

                                  final Map<String, dynamic> data = {
                                    'note': noteController.text,
                                    // 'description':
                                    //     descriptionController.text ?? "",
                                    // 'dataPoints': dataPointValues,
                                    'images':
                                        capturedImages, // Store captured images
                                  };

                                  popupData[index] = data;
                                  final List<String> editedValues =
                                      datapointControllers
                                          .map((controller) => controller.text)
                                          .toList();

                                  userEnteredDataPoints[index] = editedValues;

                                  myStatefulWidgetDataMap[index] =
                                      localDataEntries;

                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isAnySelectAnswer =
        selectedDropdownValues.any((value) => value.first == "Select Answer");
    return Consumer<GetCheckListDetailsProvider>(
      builder: (context, getCheckListDetailsProvider, _) {
        final responseData = getCheckListDetailsProvider.user?.responseData;
        final checklist = responseData?.getChecklistDetails ?? [];

        String chekListname = '';

        if (checklist.isNotEmpty) {
          chekListname = checklist.first.checklistName;
        }

        String headerImage = '';
        if (checklist.isNotEmpty) {
          headerImage = checklist.first.headerimageurl;
        }

        return isLoading
            ? Scaffold(
                body: Center(
                  child: LottieLoadingAnimation(),
                ),
              )
            : checklist.isEmpty
                ? const Scaffold(
                    body: Center(
                      child: Text(
                        "No checklist data",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: true,
                      iconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                      toolbarHeight: 90,
                      title: PreferredSize(
                        preferredSize: const Size.fromHeight(90),
                        child: Container(
                          color: themeProvider.isDarkTheme
                              ? const Color(0xFF212121)
                              : const Color(0xFF25476A),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 140,
                          child: SafeArea(
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        chekListname,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (isTextFieldVisible)
                                        // Show TextField conditionally
                                        if (widget.acrpinspectionstatus == 3 ||
                                            widget.acrpinspectionstatus == 4)
                                          Text(
                                            checklist.first.personfname,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                        else
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Form(
                                                    key: operatorFormKey,
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .only(
                                                          left: defaultPadding *
                                                              12),
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: TextFormField(
                                                        controller:
                                                            numberController,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter Operator Id';
                                                          }
                                                          if (value.contains(RegExp(
                                                              r'[!@#$%^&*(),.?":{}|<>]'))) {
                                                            return 'Operator Id cannot contain special symbols';
                                                          }
                                                          if (value
                                                              .contains(' ')) {
                                                            return 'Operator Id cannot contain spaces';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Enter Operator Id',
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black45),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          labelStyle:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 30),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade50),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade50),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    if (operatorFormKey
                                                            .currentState
                                                            ?.validate() ==
                                                        true) {
                                                      handleSubmit();
                                                    }
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      if (!isTextFieldVisible)
                                        Text(
                                          personName, // Show personName
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        if (widget.acrpinspectionstatus == 3 ||
                            widget.acrpinspectionstatus == 4)
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipOval(
                              child: headerImage != null
                                  ? Image.network(
                                      checklist.first.headerimageurl,
                                      width: 50, // Set the width as needed
                                      height: 30, // Set the height as needed
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/Suji shoie1.jpg', // Replace with the path to your placeholder image
                                          width: 50, // Set the width as needed
                                          height:
                                              30, // Set the height as needed
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/images/Suji shoie1.jpg', // Replace with the path to your placeholder image
                                      width: 50, // Set the width as needed
                                      height: 30, // Set the height as needed
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )
                        else
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.capturedImages?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final imageFile = widget.capturedImages?[index];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipOval(
                                    child: Image.file(
                                      imageFile!,
                                      width: 80, // Set the width as needed
                                      height: 50, // Set the height as needed
                                      fit: BoxFit
                                          .cover, // Adjust the fit as needed
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: ListView.builder(
                              itemCount: checklist.length,
                              itemBuilder: (context, index) {
                                final asset = checklist[index];
                                String decodedTamilText = utf8.decode(
                                    asset.checkpoint.runes.toList(),
                                    allowMalformed: true);
                                final statusIcon = getStatusIcon(asset.methods);
                                final role =
                                    responsibilityRole(asset.responsibility);

                                return Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            child: ListTile(
                                              title: Text("${asset.seqNo}."),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: ListTile(
                                              title: Text(
                                                decodedTamilText,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 60,
                                              child: Image.asset(statusIcon),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 60,
                                              child: Text(role),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(30),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            DropdownButton<
                                                                String>(
                                                              underline:
                                                                  Container(),
                                                              value: selectedDropdownValues[
                                                                          index]
                                                                      .isNotEmpty
                                                                  ? selectedDropdownValues[
                                                                          index]
                                                                      .first
                                                                  : "Select Answer",
                                                              onChanged:
                                                                  (newValue) {
                                                                _handleDropdownChange(
                                                                    index,
                                                                    newValue!);
                                                              },
                                                              items: <String>[
                                                                "Select Answer",
                                                                "Passed",
                                                                "Failed",
                                                                "Conditionally Passed",
                                                                "Not Applicable"
                                                               
                                                              ].map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                if (showDataPointsButton &&
                                                    selectedDropdownValues[
                                                                index]
                                                            .first !=
                                                        "Not Applicable" &&
                                                    selectedDropdownValues[
                                                                index]
                                                            .first !=
                                                        "Select Answer")
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          _showPopup(
                                                              context, index);
                                                        },
                                                        child: const Text(
                                                          "Add Inputs",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ),
                        ),
                        if (widget.acrpinspectionstatus != 3 &&
                            widget.acrpinspectionstatus != 4)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (personName.isNotEmpty &&
                                      !isTextFieldVisible) {
                                    try {
                                      final response = await submitChecklist(
                                          context, "submit_checklist", 2);
                                      if (response['response_code'] == 4 ||
                                          response['response_code'] == 5 ||
                                          response['response_code'] == 6) {
                                        ShowError.showAlert(
                                            context, response['response_msg']);
                                      } else {
                                        // If response_code is not 4, 5, or 6, proceed to _navigateBack()
                                        _navigateBack();
                                      }
                                    } catch (error) {
                                      // Handle and show the error message here
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error.toString()),
                                          backgroundColor: Colors.amber,
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: personName.isNotEmpty
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                child: const Text("Save"),
                              ),
                              const SizedBox(width: defaultPadding),
                              ElevatedButton(
                                onPressed: () {
                                  if (!isAnySelectAnswer &&
                                      personName.isNotEmpty) {
                                    _submitPop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: !isAnySelectAnswer &&
                                          personName.isNotEmpty
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                child: const Text("Submit"),
                              ),
                              const SizedBox(
                                width: defaultPadding,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  pauseStatus();
                                  _navigateBack();
                                  popupData.clear();
                                  userEnteredDataPoints.clear();
                                  myStatefulWidgetDataMap.clear();
                                  numberController.clear();
                                },
                                child: const Text("Go Back"),
                              ),
                            ],
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _navigateBack();
                                },
                                child: const Text("Go Back"),
                              ),
                            ],
                          ),
                      ],
                    ));
      },
    );
  }
}
