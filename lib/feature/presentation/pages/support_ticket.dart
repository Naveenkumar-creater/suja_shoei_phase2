import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_form_entity.dart';
import 'package:suja_shoie_app/feature/presentation/providers/st_dd_pd_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';

import '../../../constant/utils/image_base64.dart';
import '../api_services/st_dd_assetdetail_service.dart';
import '../api_services/st_dd_pd_service.dart';
import '../api_services/st_form_detail_service.dart';
import '../api_services/st_submit_api_service.dart';
import '../providers/loginprovider.dart';
import '../providers/st_dd_assetsetail_provider.dart';
import '../providers/st_form_detail_provider.dart';
import '../widget/checklist_details/take_photo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
class SupportTicketForm extends StatefulWidget {
  const SupportTicketForm({super.key});

  @override
  State<SupportTicketForm> createState() => _SupportTicketFormState();
}

class _SupportTicketFormState extends State<SupportTicketForm> {
    final ImageBase64 imageBase64 =ImageBase64();
    final SupportTicketFormService supportTicketFormService=SupportTicketFormService();
     final SupportTicketSubmitService supportTicketSubmitService=SupportTicketSubmitService();
  
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final FocusNode assetFocusNode = FocusNode();
  final FocusNode assetnameFoucusNode = FocusNode();
  final FocusNode decriptionFocusNode = FocusNode();
  final TextEditingController assetEditingController = TextEditingController();
  final TextEditingController assetNameEditingController =
      TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();


  List<bool> isSelect = [true, false, false, false];
  List<bool> isCrticality = [
    true,
    false,
    false
  ]; // Initialize the isSelected list with the same length as children
  final StAssetDetailService stAssetDetailService = StAssetDetailService();
  final StProblemDescriptionService stProblemDescriptionService = StProblemDescriptionService();

  String dropdownValue = "Select Value";
  String problemDrodownValue = "Select Value";
  // var problemIdentify = ["Select Value", "it's not working ", "Oil Leakgage"];

  var Items = ["Select Value", "Break Down", "Working"];

  Map<int, Map<String, dynamic>> imagesData = {};
    int selectedProblemId = 0;
  int selectedCriticality = 0;
  int selectedPriority = 0;


    TextEditingController searchController =TextEditingController();
  String selectedAssetName = "";
  int selectedAssetId = 0;


  int sendAssetcondition(String status) {
    switch (status) {
      case "Break Down":
        return 1;
      case "Working":
        return 2;
      default:
        return 0;
    }
  }


  @override
  void initState() {
    super.initState(); // Call super.initState() before using context.
   getFormIntiate();
   supportTicketFormService.getFormDetails(context: context, id:1);
 

  }

Future getFormIntiate()async{
   await Future.delayed(const Duration(seconds: 1));
 stAssetDetailService.getAssetList(context: context);
    stProblemDescriptionService.getproblemDescription(context: context);
}



// store images

// List<File?> capturedImg = []; // Initialize capturedImg with an empty list

//     Map<String, dynamic> initialData = 
//         {
//           'images': capturedImg
//         };

    List<File?> capturedImages = [];
 
    // for (String imageUrl in imageUrls) {
    //   final uniqueUrl = Uri.parse(imageUrl)
    //       .replace(
    //           query:
    //               'timestamp=${DateTime.now().millisecondsSinceEpoch}-${UniqueKey().toString()}')
    //       .toString();

    //   // Download the image and convert it to a file
    //   final response = await http.get(Uri.parse(uniqueUrl));
    //   final List<int> bytes = response.bodyBytes;

    //   // Get the app's document directory to store the files
    //   final appDocumentDirectory = await getApplicationDocumentsDirectory();
    //   final String filePath =
    //       '${appDocumentDirectory.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    //   // Write the bytes to a file
    //   File file = File(filePath);
    //   await file.writeAsBytes(bytes);

    //   capturedImg.add(file);
    // }
 

Future<void> intialFormData() async {
  // Delay for simulation purposes (you can remove this in the actual implementation)
  await Future.delayed(const Duration(seconds: 1));

  // Retrieve the initial data from the provider
  final intialData =
      Provider.of<StFormDetailProvider>(context, listen: false).user?.responseData.supportTicket;
         final assetList = Provider.of<StAssetDetailProvider>(context, listen: false)
        .user
        ?.responseData
        ?.assetMaster;

  // Set the initial values for the form fields
  if (intialData != null) {
    setState(() {
      // Set the initial values for the asset related fields
      selectedAssetId = intialData.amSupTicketAssetId ?? 0;  
        if (selectedAssetId != 0) {
      // Find the asset with the selectedAssetId
       var selectedAsset = assetList?.firstWhere(
        (asset) => asset.assetId == selectedAssetId,
      );

      // Set the default assetName in the searchController
      if (selectedAsset != null) {
        setState(() {
          selectedAssetName = selectedAsset.assetName ?? "";
          searchController.text = selectedAssetName;
        });

      }
      // Set the initial value for the asset condition dropdown
      dropdownValue = intialData.amSupTicketAssetCondition == 1
          ? "Break Down"
          : (intialData.amSupTicketAssetCondition == 2 ? "Working" : "Select Value");

          selectedCriticality=(intialData.amSupTicketCriticality == 1
          ? "None"
          : (intialData.amSupTicketAssetCondition == 2 ? "Normal" : "High")) as int;
               selectedPriority=(intialData.amSupTicketCriticality == 1
          ? "None"
          : intialData.amSupTicketAssetCondition == 2 ? "Normal" :(intialData.amSupTicketAssetCondition == 3 ? "High":"Low" )) as int;

      // Set the initial value for other fields based on intialData
      // ... (similarly for other fields)

      // For example, you might want to set the initial value for the description field
      descriptionEditingController.text = intialData.amSupTicketProblemDescription ?? "";
        }
    });
  }
}



  Future submitSupportTicket() async{
    
     SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("client_token") ?? "";

    final personDetails=Provider.of<LoginProvider>(context, listen: false).user;
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
   

    final SupportTicket supportTicket = SupportTicket(
        amSupTicketRaisedBy: personDetails?.personId,
        amSupTicketAssetCondition: sendAssetcondition(dropdownValue),
        amSupTicketAssetId:selectedAssetId,
        amSupTicketCriticality: selectedCriticality,
        amSupTicketDate: toDate,
        amSupTicketDeptId: personDetails?.deptId,
        amSupTicketOrgId: personDetails?.orgId,
        amSupTicketPriority: selectedPriority,
        amSupTicketProblemDescription: descriptionEditingController.text,
        amsupticketproblemid:selectedProblemId,
        images: []);

   final imagesList = (capturedImages as List<File?>?)
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
      supportTicket.images?.addAll(listOfImage ?? []);

// ignore: use_build_context_synchronously
supportTicketSubmitService.submitSuportTicket(context: context, token: token, supportTicket: supportTicket.toJson());
        // final requestBody=
        
  // const timeoutDuration = Duration(seconds: 30);
  //   try {
  //     http.Response response = await http
  //         .post(
  //           Uri.parse(ApiConstant.baseUrl),
  //           headers: {
  //             'Content-Type': 'application/json',
  //           },
  //           body:    jsonEncode(requestBody),
  //         )
  //         .timeout(timeoutDuration);

  //     // ignore: avoid_print
  //     print(response.body);

  //     if (response.statusCode == 200) {
  //       try {
  //         final responseJson = jsonDecode(response.body);
  //         print(responseJson);
  //         return responseJson;
  //       } catch (e) {
  //         // Handle the case where the response body is not a valid JSON object
  //         throw ("Invalid JSON response from the server");
  //       }
  //     } else {
  //       throw ("Server responded with status code ${response.statusCode}");
  //     }
  //   } on TimeoutException {
  //     throw ('Connection timed out. Please check your internet connection.');
  //   } catch (e) {
  //     ShowError.showAlert(context, e.toString());
  //   }


  }

  


  

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    
     final  intialData = Provider.of<StFormDetailProvider>(context, listen: false).user;
    final assetList = Provider.of<StAssetDetailProvider>(context, listen: false)
        .user
        ?.responseData
        ?.assetMaster;
    final problemDescription =
        Provider.of<StProblemDescriptionProvider>(context, listen: false)
            .user
            ?.responseData
            ?.problemMstr;
    List<String> problemIdentify = [
      "Select Value"
    ]; // Start with a default value
    problemIdentify.addAll(
        problemDescription?.map((item) => item.amReasonDescription as String) ??
            []);

            

    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 115,
            child: const SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create Support Ticket",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: defaultPadding,
            left: defaultPadding * 4,
            right: defaultPadding * 4,
            bottom: defaultPadding),
        child: Container(
          color: Colors.grey[50],
          child: Padding(
            padding: const EdgeInsets.all(
              defaultPadding * 4,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: ImageCapture(
                        capturedImages: capturedImages,
                        onImagesCaptured: (updatedImages) {
                          setState(() {
                            capturedImages = updatedImages.cast<File?>();
                      
                          });
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

         TypeAheadFormField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: searchController,
            decoration: InputDecoration(labelText: 'Search Asset'),
          ),
          suggestionsCallback: (String pattern) async {
            // Return the list of asset names that match the entered text
            return assetList!
                .where((asset) =>
                    asset.assetName!
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                .map<String>((asset) => asset.assetName!)
                .toList();
          },
          itemBuilder: (context, String suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (String suggestion) {
            // Handle the selected suggestion
            setState(() {
              selectedAssetName = suggestion;
              // Find the corresponding assetId for the selected assetName
              selectedAssetId = assetList!
                  .firstWhere((asset) => asset.assetName == suggestion)
                  .assetId!;
            });

            // Set the text field value immediately when a suggestion is selected
            searchController.text = suggestion;
          },
        ),
      
                 ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Asset Condition"),
                            const SizedBox(
                              height: 8,
                            ),
                            DropdownButtonFormField(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_circle,
                                  color: Colors.blue),
                              items: Items.map((dropdownItem) {
                                return DropdownMenuItem(
                                  value: dropdownItem,
                                  child: Text(dropdownItem),
                                );
                              }).toList(),
                              onChanged: (String? newvalue) {
                                setState(() {
                                  dropdownValue = newvalue!;
                                });
                                // Call the function to send the selected value to the server
                                sendAssetcondition(dropdownValue);
                              },
                              validator: (value) {
                                if (value == "Select Value") {
                                  return 'Please select a valid asset condition';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle:
                                    const TextStyle(color: Colors.black12),
                                hintStyle:
                                    const TextStyle(color: Colors.black45),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.blueGrey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.blue.withOpacity(0.5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Problem"),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                        value: problemDrodownValue,
                        icon: const Icon(Icons.arrow_drop_down_circle,
                            color: Colors.blue),
                        items: problemIdentify.map((String dropdownItem) {
                          return DropdownMenuItem(
                            value: dropdownItem,
                            child: Text(dropdownItem),
                          );
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            problemDrodownValue = newvalue!;
                            // Update the selected Problem ID based on the selected description
                            selectedProblemId = problemDescription!
                                .firstWhere((item) =>
                                    item.amReasonDescription == newvalue)
                                .amProblemCodeId!;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Problem Description",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.black12),
                          hintStyle: const TextStyle(color: Colors.black45),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                width: 1, color: Colors.blueGrey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                width: 2, color: Colors.blue.withOpacity(0.5)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description"),
                      const SizedBox(height: 5),
                      TextFormField(
                        maxLines: 5,
                        focusNode: decriptionFocusNode,
                        controller: descriptionEditingController,
                        // onEditingComplete: () {
                        //   FocusScope.of(context).requestFocus(assetnameFoucusNode);
                        // },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Value';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Description",
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: const TextStyle(color: Colors.black12),
                            hintStyle: const TextStyle(color: Colors.black45),
                            contentPadding:
                                const EdgeInsets.all(defaultPadding * 2),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Priority"),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 60,
                            child: ToggleButtons(
                              isSelected: isSelect,
                              children: const [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "None",
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "High",
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "Medium",
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "Low",
                                      style: TextStyle(fontSize: 15),
                                    )),
                              ],
                              onPressed: (int newValue) {
                                setState(() {
                                  for (int index = 0;
                                      index < isSelect.length;
                                      index++) {
                                    if (index == newValue) {
                                      isSelect[index] = true;
                                    } else {
                                      isSelect[index] = false;
                                    }
                                  }
                                  selectedPriority = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Criticality"),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 60,
                            child: ToggleButtons(
                              isSelected: isCrticality,
                              children: const [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "None",
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "Normal",
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "High",
                                      style: TextStyle(fontSize: 15),
                                    )),
                              ],
                              onPressed: (int newValue) {
                                setState(() {
                                  for (int index = 0;
                                      index < isCrticality.length;
                                      index++) {
                                    if (index == newValue) {
                                      isCrticality[index] = true;
                                    } else {
                                      isCrticality[index] = false;
                                    }
                                    selectedCriticality = newValue;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState?.validate() == true) {
                              submitSupportTicket();
                            }
                          },
                          child: const Text("Submit")),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Go Back"))
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

