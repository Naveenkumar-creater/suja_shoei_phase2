// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:suja_shoie_app/constant/utils/theme_styles.dart';
// import 'package:suja_shoie_app/feature/presentation/api_services/datapoint_service.dart';
// import 'package:suja_shoie_app/feature/presentation/api_services/get_checklist_details_service.dart';
// import 'package:suja_shoie_app/feature/presentation/providers/datapoint_provider.dart';
// import 'package:suja_shoie_app/feature/presentation/providers/get_checklist_details_provider.dart';
// import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';

// import '../../../models/chepoint_request.model.dart';
// import '../../data/core/api_constant.dart';
// import '../api_services/operator_service.dart';
// import '../providers/operator_provider.dart';
// import 'dart:async';

// import '../widget/checklist_details/take_photo.dart';

// class PreviewPage extends StatefulWidget {
//   final int? planid;

//   PreviewPage({this.planid, required int planId});

//   @override
//   // ignore: library_private_types_in_public_api
//   _PreviewState createState() => _PreviewState();
// }

// class _PreviewState extends State<PreviewPage> {
//   final GetChecklistService _checkListService = GetChecklistService();
//   bool isLoading = true;
//   bool isCleared = false;

//   // Store the entered data for each popup
//   Map<int, Map<String, dynamic>> popupData = {};
//   List<List<String>> selectedDropdownValues = [];

//   // Step 2: Create a map to store the fetched "Data Points" data
//   Map<int, List<String>> dataPointValuesMap = {};
//   Map<int, List<String>> userEnteredDataPoints = {};

//   bool showDataPointsButton = false;

//   String getStatusIcon(int method) {
//     if (method == 1) {
//       return 'assets/images/eye.png';
//     } else if (method == 2) {
//       return 'assets/images/hand.png';
//     } else if (method == 3) {
//       return 'assets/images/ear.png';
//     } else {
//       return "unKnown";
//     }
//   }

//   String responsibilityRole(int method) {
//     if (method == 1) {
//       return 'Operator';
//     } else {
//       return 'Maintenance Engineer';
//     }
//   }

//   late int dataPointsIndex;
//   late int dropdownValuesIndex;
//   void clearDropdownResult(dropdownValuesIndex, dataPointsIndex) {
//     if (isCleared == true) {
//       selectedDropdownValues[dropdownValuesIndex] = ['Select Answer'];
//       userEnteredDataPoints[dataPointsIndex] = List<String>.filled(
//         selectedDropdownValues.length,
//         "", // Clear the text field value
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchCheckList();

//     // Initialize selectedDropdownValues here
//   }

//   Future<void> _fetchCheckList() async {
//     try {
//       final responseData = await _checkListService.getCheckListDetails(
//         context: context,
//         planId: widget.planid ?? 0,
//       );
//       final response =
//           Provider.of<GetCheckListDetailsProvider>(context, listen: false)
//               .user
//               ?.responseData;

//       if (response != null) {
//         final checklist = response?.getChecklistDetails ?? [];

//         setState(() {
//           selectedDropdownValues = List.generate(
//             checklist.length,
//             (index) => ["Select Answer"],
//           );
//         });
//       }
//     } catch (e) {
//       print('Error fetching checklist: $e');
//     }
//   }

//   void _handleDropdownChange(int index, String newValue) {
//     setState(() {
//       final String previousValue = selectedDropdownValues[index].first;

//       if (previousValue != newValue) {
//         // Clear all fields when the previous value is different from the new value
//         userEnteredDataPoints[index] = List<String>.filled(
//           selectedDropdownValues.length,
//           "", // Clear the text field value
//           growable: true,
//         );
//       }

//       while (selectedDropdownValues.length <= index) {
//         selectedDropdownValues.add(["Select Answer"]);
//       }
//       selectedDropdownValues[index] = [newValue]; // Update the selected value

//       if (newValue == "Failed" || newValue == "Conditionally Passed") {
//         _showPopup(context, index);
//       } else if (newValue == "Passed") {
//         showDataPointsButton = true;
//       } else if (newValue == "Select Answer" || newValue == "Not Applicable") {
//         showDataPointsButton = true;
//       } else {
//         showDataPointsButton = false;
//       }
//     });
//   }

//   final TextEditingController numberController = TextEditingController();
//   String personName = ''; // State variable to store the personName
//   bool isTextFieldVisible = true;
//   bool isOperatorIdEntered = false;

//   void handleSubmit() {
//     String personId = numberController.text;

//     if (personId.isEmpty) {
//       setState(() {
//         personName =
//             'Person ID is required'; // Set an appropriate error message
//         isTextFieldVisible = true;
//       });
//     } else {
//       OperatorService operatorService = OperatorService();
//       operatorService
//           .getOperatorName(personId: personId, context: context)
//           .then((result) {
//         var operator =
//             Provider.of<OperatorProvider>(context, listen: false).user;

//         if (operator != null) {
//           setState(() {
//             personName = operator.personfname ?? 'Operator name not found';
//             isTextFieldVisible = false;
//           });
//         } else {
//           // Handle the case where operator is null
//           setState(() {
//             personName = 'Operator not found';
//             isTextFieldVisible = true;
//           });
//         }
//       }).catchError((error) {
//         // Handle any errors that occurred during the API call
//         setState(() {
//           personName = 'Error: $error';
//           isTextFieldVisible = true;
//         });
//       });
//     }
//   }

//   Future<void> _fetchDataPoints(int index) async {
//     DataPointService dataPointService = DataPointService();

//     final responseData =
//         Provider.of<GetCheckListDetailsProvider>(context, listen: false)
//             .user
//             ?.responseData;
//     final checklist = responseData?.getChecklistDetails ?? [];

//     if (checklist.isNotEmpty && index < checklist.length) {
//       final acrdId = checklist[index].acrdid;

//       // Fetch "Data Points" data using dataPointService.getDatapoints
//       final dataPoints = await dataPointService.getDatapoints(
//         context: context,
//         acrdId: acrdId,
//       );

//       dataPointValuesMap[index] = dataPoints ?? [];

//       // Initialize user-entered data points if not already done
//       if (!userEnteredDataPoints.containsKey(index)) {
//         userEnteredDataPoints[index] = List<String>.filled(
//           dataPointValuesMap[index]!.length,
//           "", // Initialize with empty strings
//           growable: true,
//         );
//       }
//     }
//   }

//   int getStatusValue(String status) {
//     switch (status) {
//       case "Passed":
//         return 0;
//       case "Failed":
//         return 1;
//       case "Conditionally Passed":
//         return 2;
//       case "Not Applicable":
//         return 3;
//       default:
//         return -1; // Handle unknown status here
//     }
//   }

//   Future submitChecklist(BuildContext context) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String token = pref.getString("client_token") ?? "";

//     final responseData =
//         Provider.of<GetCheckListDetailsProvider>(context, listen: false)
//             .user
//             ?.responseData;
//     final checklist = responseData?.getChecklistDetails ?? [];

//     final checklistRequest = ChecklistRequest(
//       clientAuthToken: token,
//       apiFor: "submit_checklist",
//       clientId: "vijay",
//       acrhAcmphId: checklist.first.acrhacmphid,
//       operatorId: 4,
//       checkPoints: [],
//     );

//     // Populate checkPoints list with your checkpoint data
//     for (int index = 0; index < checklist.length; index++) {
//       final asset = checklist[index];

//       final responseData =
//           Provider.of<DataPointProvider>(context, listen: false)
//               .user
//               ?.responseData;
//       final datapointDescriptions = responseData?.checklistdatapointslist
//               ?.map((e) => e?.amdpDatapointDescription)
//               ?.toList() ??
//           [];

//       final dataPoints = userEnteredDataPoints[index] ?? [];

//       // Filter out empty datapoints
//       final filteredDataPoints = dataPoints
//           .asMap()
//           .entries
//           .where((entry) =>
//               entry.value != null &&
//               entry.value.isNotEmpty &&
//               entry.key < datapointDescriptions.length &&
//               datapointDescriptions[entry.key]?.isNotEmpty == true)
//           .toList();

//       final checkpoint = ChecklistCheckpoint(
//         acrdId: asset.acrdid,
//         acrdCheckpointStatus:
//             getStatusValue(selectedDropdownValues[index].first),
//         acrdCheckpointNotes: popupData[index]?['note'] ?? "",
//         datapoints: [], // Initialize the datapoints list for this checkpoint
//       );

//       for (final entry in filteredDataPoints) {
//         final i = entry.key;
//         final datapoint = ChecklistDataPoint(
//           amdpDatapointId: i + 1,
//           acrdpId: asset.acrdid,
//           amdpDatapointDescription: datapointDescriptions[i] ?? "",
//           acrdpDatapointValue: int.tryParse(entry.value) ?? 0,
//         );

//         checkpoint.datapoints
//             .add(datapoint); // Add this datapoint to the current checkpoint
//       }

//       checklistRequest.checkPoints
//           .add(checkpoint); // Add the checkpoint to the checklist
//     }

//     // Convert the ChecklistRequest to JSON
//     final requestBody = jsonEncode(checklistRequest.toJson());

//     // Send the API request using your preferred HTTP client (e.g., Dio, http package)
//     const timeoutDuration = Duration(seconds: 10);
//     final response = await http
//         .post(
//           Uri.parse(ApiConstant.baseUrl),
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           body: requestBody,
//         )
//         .timeout(timeoutDuration);

//     print(response.body);

//     if (response.statusCode == 200) {
//       final responseJson = jsonDecode(response.body);

//       return responseJson;
//     } else {
//       throw Exception(
//           "Failed to submit checklist. Status Code: ${response.statusCode}");
//     }
//   }

//   void _showPopup(BuildContext context, int index) {
//     List<TextEditingController> descriptionControllers = [];
//     Map<String, dynamic> initialData = popupData[index] ??
//         {
//           'note': "",
//           'description': "",
//         };

//     // Variables to store the entered values
//     String noteValue = "";
//     List<String> dataPointValues = userEnteredDataPoints[index] ??
//         List<String>.filled(
//           selectedDropdownValues.length,
//           "", // Initialize with empty strings
//           growable: true,
//         );

//     // Trigger the dataPointService.getDatapoints here before showing the dialog.
//     _fetchDataPoints(index);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         TextEditingController noteController = TextEditingController();
//         TextEditingController descriptionController = TextEditingController();

//         // Pre-fill the input fields with initial data
//         noteController.text = initialData['note'];
//         descriptionController.text = initialData['description'];

//         return SingleChildScrollView(
//           child: WillPopScope(
//             onWillPop: () async {
//               return true;
//             },
//             child: AlertDialog(
//               backgroundColor: Colors.white,
//               content: Container(
//                 width: 500,
//                 height: 700,
//                 color: Colors.white,
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text('Add Images       :'),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         CameraIconWithClick(),
//                         SizedBox(
//                           width: defaultPadding,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       children: [
//                         Text('Add Notes          :'),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Container(
//                           width: 300,
//                           height: 50,
//                           child: TextField(
//                             controller: noteController,
//                             onChanged: (value) {
//                               // Save the note value as it changes
//                               noteValue = value;
//                             },
//                             decoration: const InputDecoration(
//                               labelText: 'Enter Notes',
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.yellow,
//                                   width: 1.0,
//                                 ),
//                               ),
//                               hintText: '',
//                               labelStyle: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     Container(
//                       child: Consumer<DataPointProvider>(
//                         builder: (context, DetailsProvider, _) {
//                           final response = DetailsProvider.user?.responseData;
//                           final datapoint = response?.checklistdatapointslist;
//                           descriptionControllers = List.generate(
//                             datapoint?.length ?? 0,
//                             (index) => TextEditingController(
//                               text: dataPointValues[index],
//                             ),
//                           );

//                           return Column(
//                             children: [
//                               Card(
//                                 elevation: 5,
//                                 shadowColor: Colors.black,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ListView.builder(
//                                     physics:
//                                         ClampingScrollPhysics(), // Limit the height of the ListView
//                                     shrinkWrap: true,
//                                     itemCount: datapoint?.length ?? 0,
//                                     itemBuilder: (context, index) {
//                                       final item = datapoint?[index];

//                                       return SingleChildScrollView(
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 8.0),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: 8,
//                                                   ),
//                                                   Text(
//                                                       "${item?.amdpDatapointDescription}"),
//                                                   SizedBox(
//                                                     width: 28,
//                                                   ),
//                                                   Text(":"),
//                                                   SizedBox(
//                                                     width: 8,
//                                                   ),
//                                                   Container(
//                                                     width: 300,
//                                                     height: 50,
//                                                     child: TextField(
//                                                       controller:
//                                                           descriptionControllers[
//                                                               index],
//                                                       onChanged: (value) {
//                                                         // Save the data point value as it changes
//                                                         dataPointValues[index] =
//                                                             value;
//                                                       },
//                                                       decoration:
//                                                           const InputDecoration(
//                                                         labelText:
//                                                             'Data Points',
//                                                         border:
//                                                             OutlineInputBorder(
//                                                           borderSide:
//                                                               BorderSide(
//                                                             color:
//                                                                 Colors.yellow,
//                                                             width: 1.0,
//                                                           ),
//                                                         ),
//                                                         hintText: '',
//                                                         labelStyle: TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding * 3,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Store the data in a map
//                             final Map<String, dynamic> data = {
//                               'note': noteController.text,
//                               'description': descriptionController.text ?? "",
//                               'dataPoints': dataPointValues,
//                             };

//                             // Do something with the data (e.g., store it in a list or perform other actions)
//                             // For now, print the data for demonstration
//                             popupData[index] = data;
//                             userEnteredDataPoints[index] = dataPointValues;

//                             // Clear the text fields and captured image
//                             // noteController.clear();
//                             // descriptionController.clear();
//                             // capturedImage = null;

//                             Navigator.of(context).pop(); // Close the dialog
//                           },
//                           child: Text(
//                             "Okay",
//                             style: TextStyle(
//                               fontSize: 13,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Handle the "Cancel" button click here
//                             Navigator.of(context).pop(); // Close the dialog
//                           },
//                           child: Text(
//                             "Cancel",
//                             style: TextStyle(
//                               fontSize: 13,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 90,
//         title: Consumer<GetCheckListDetailsProvider>(
//           builder: (context, qrScannerProvider, _) {
//             final responseData = qrScannerProvider.user?.responseData;
//             final checklist = responseData?.getChecklistDetails ?? [];
//             String firstChecklistItem = '';
//             String chekListname = '';

//             if (checklist.isNotEmpty) {
//               chekListname = checklist.first.checklistName;
//             }

//             return PreferredSize(
//               preferredSize: const Size.fromHeight(90),
//               child: Container(
//                 color: themeProvider.isDarkTheme
//                     ? const Color(0xFF212121)
//                     : const Color(0xFF25476A),
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 height: 115,
//                 child: SafeArea(
//                   child: Center(
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               chekListname,
//                               style: const TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             if (isTextFieldVisible)
//                               // Show TextField conditionally
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     // TextField
//                                     Expanded(
//                                       child: Container(
//                                         margin: EdgeInsets.only(
//                                             left: defaultPadding * 12),
//                                         decoration: BoxDecoration(
//                                             color: Color.fromARGB(
//                                                 93, 189, 189, 189),
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(5))),
//                                         child: TextField(
//                                           style: TextStyle(color: Colors.white),
//                                           controller: numberController,
//                                           textAlign: TextAlign.center,
//                                           decoration: InputDecoration(
//                                             hintText: '     Enter operator id ',
//                                             hintStyle:
//                                                 TextStyle(color: Colors.white),
//                                             border: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // Submit Button
//                                     TextButton(
//                                       onPressed: handleSubmit,
//                                       child: Text(
//                                         'OK',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             if (!isTextFieldVisible)
//                               Text(
//                                 personName, // Show personName
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(defaultPadding),
//               child: Consumer<GetCheckListDetailsProvider>(
//                 builder: (context, getCheckListDetailsProvider, _) {
//                   final responseData =
//                       getCheckListDetailsProvider.user?.responseData;
//                   final checklist = responseData?.getChecklistDetails ?? [];

//                   return checklist.isEmpty
//                       ? const Center(
//                           child: Text("No checklist data"),
//                         )
//                       : ListView.builder(
//                           itemCount: checklist.length,
//                           itemBuilder: (context, index) {
//                             final asset = checklist[index];
//                             String decodedTamilText = utf8.decode(
//                                 asset.checkpoint.runes.toList(),
//                                 allowMalformed: true);
//                             final statusIcon = getStatusIcon(asset.methods);
//                             final role =
//                                 responsibilityRole(asset.responsibility);

//                             return Card(
//                               elevation: 5,
//                               shadowColor: Colors.black,
//                               child: Container(
//                                   height: 175,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         width: 60,
//                                         child: ListTile(
//                                           title: Text("${asset.seqNo}."),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 3,
//                                         child: ListTile(
//                                           title: Text(decodedTamilText),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           height: 60,
//                                           child: Image.asset(statusIcon),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           height: 60,
//                                           child: Text(role),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.all(30),
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.grey.shade300,
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                 ),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         DropdownButton<String>(
//                                                           underline:
//                                                               Container(),
//                                                           value: selectedDropdownValues[
//                                                                       index]
//                                                                   .isNotEmpty
//                                                               ? selectedDropdownValues[
//                                                                       index]
//                                                                   .first
//                                                               : "Select Answer",
//                                                           onChanged:
//                                                               (newValue) {
//                                                             setState(() {
//                                                               dropdownValuesIndex =
//                                                                   index;
//                                                             });
//                                                             _handleDropdownChange(
//                                                                 index,
//                                                                 newValue!);
//                                                           },
//                                                           items: <String>[
//                                                             "Select Answer",
//                                                             "Passed",
//                                                             "Failed",
//                                                             "Conditionally Passed",
//                                                             "Not Applicable"
//                                                             // Add more options as needed
//                                                           ].map<
//                                                               DropdownMenuItem<
//                                                                   String>>((String
//                                                               value) {
//                                                             return DropdownMenuItem<
//                                                                 String>(
//                                                               value: value,
//                                                               child:
//                                                                   Text(value),
//                                                             );
//                                                           }).toList(),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     if (showDataPointsButton &&
//                                                         selectedDropdownValues[
//                                                                     index]
//                                                                 .first ==
//                                                             "Passed")
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           ElevatedButton(
//                                                             onPressed: () {
//                                                               _showPopup(
//                                                                   context,
//                                                                   index);
//                                                             },
//                                                             child: Text(
//                                                               "Add Inputs",
//                                                               style: TextStyle(
//                                                                 fontSize: 13,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             );
//                           },
//                         );
//                 },
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Navigate back to the previous page
//                 },
//                 child: Text("Save"),
//               ),
//               SizedBox(width: defaultPadding),
//               ElevatedButton(
//                 onPressed: numberController.text.isNotEmpty
//                     ? () {
//                         submitChecklist;
//                       }
//                     : null, // Disable the button when numberController.text is empty
//                 child: Text("submit"),
//               ),
//               SizedBox(width: defaultPadding),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle button click, e.g., submit values
//                   clearDropdownResult(dropdownValuesIndex, dropdownValuesIndex);
//                 },
//                 child: Text("Cancel"),
//               ),
//             ],
//           ),
//           SizedBox(height: defaultPadding / 2),
//         ],
//       ),
//     );
//   }
// }
