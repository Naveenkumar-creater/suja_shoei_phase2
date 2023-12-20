// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../models/chepoint_request.model.dart';
// import '../providers/datapoint_provider.dart';
// import '../providers/get_checklist_details_provider.dart';
// import '../providers/operator_provider.dart';

// class ChecklistService {
//   final String baseUrl; // Set your API base URL here

//   ChecklistService(this.baseUrl);

//   Future<Map<String, dynamic>> submitChecklist({
//     required List<File?> capturedImages,
//     required String apifor,
//     required List<YourDataPointType> userEnteredDataPoints,
//     required List<Map<String, dynamic>> popupData,
//   }) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String token = pref.getString("client_token") ?? "";

//     var operator = OperatorProvider.instance.user!.personid; // Replace with your operator retrieval logic

//     final responseData = GetCheckListDetailsProvider.instance.user?.responseData;
//     final checklist = responseData?.getChecklistDetails ?? [];
//     List<String> headerImagesPaths = capturedImages
//         .map((file) => file != null ? file.path : '')
//         .toList();

//     final checklistRequest = ChecklistRequest(
//       clientAuthToken: token,
//       apiFor: apifor,
//       clientId: "vijay",
//       acrhAcmphId: checklist.first.acrhacmphid,
//       operatorId: operator!,
//       headerimage: headerImagesPaths,
//       checkPoints: [],
//     );

//     // Populate checkPoints list with your checkpoint data
//     for (int index = 0; index < checklist.length; index++) {
//       final asset = checklist[index];

//       final responseData =
//           DataPointProvider.user?.responseData;
//       final datapointDescriptions =
//           responseData?.checklistdatapointslist
//                   ?.map((e) => e?.amdpDatapointDescription)
//                   ?.toList() ??
//               [];

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

//       final imagesList =
//           (popupData[index]?['images'] as List<File?>?)
//                   ?.map((image) => image?.path ?? "")
//                   .toList() ??
//               [];
//       final checkpoint = ChecklistCheckpoint(
//         acrdId: asset.acrdid,
//         acrdCheckpointStatus:
//             getStatusValue(selectedDropdownValues[index].first),
//         acrdCheckpointNotes: popupData[index]?['note'] ?? "",
//         datapoints: [],
//         images: [], // Initialize the datapoints list for this checkpoint
//       );

//       checkpoint.images.addAll(imagesList ?? []);

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

//     // Send the API request using the http package
//     const timeoutDuration = Duration(seconds: 10);
//     final response = await http
//         .post(
//           Uri.parse(baseUrl), // Replace with your API endpoint
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
// }
