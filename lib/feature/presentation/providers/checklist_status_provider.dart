// import 'dart:convert';

// import 'package:flutter/material.dart';

// import '../../../models/checklist_staatus_model.dart';

// class CheckListStatusProvider extends ChangeNotifier {
//   ChecklistStatus? data;

//   Future<void> getStatus(BuildContext context) async {
//     try {
//       // Load the JSON data from an asset file or API (You can modify this part accordingly)
//       String jsonData = await DefaultAssetBundle.of(context)
//           .loadString('assets/raw/checklist_status_count.json');
//       // ignore: avoid_print
//       print(jsonData);

//       // Decode the JSON data
//       Map<String, dynamic> jsonDataMap = jsonDecode(jsonData);

//       // Create the checklistStatus object from JSON data
//       data = ChecklistStatus.fromJson(jsonDataMap);
//       print(data);

//       // Verify if the data is fetched correctly
//       print("Checklist Status Count: ${data?.checklistStatusCount}");

//       // Notify listeners that the data has been updated
//       notifyListeners();
//     } catch (e) {
//       print("Error loading checklist status: $e");
//     }
//   }
// }
