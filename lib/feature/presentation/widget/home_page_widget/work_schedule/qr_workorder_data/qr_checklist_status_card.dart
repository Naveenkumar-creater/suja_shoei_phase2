import 'package:flutter/material.dart';

import '../../../../../../constant/utils/theme_styles.dart';
import '../../../../pages/captureimage.dart';
import '../../../../pages/cheklist_details_page.dart';
import '../assetlist_workschedule/asset_list_workschedule.dart';

class QrChecklistCard extends StatelessWidget {
  final Color statusColor;
  final String checklistName;
  final String statusText;
  final String inspectionDate;
  final int checklistStatus;
  final int planId;
  final String barcode;

  

  const QrChecklistCard({super.key, 
    required this.statusColor,
    required this.checklistName,
    required this.statusText,
    required this.inspectionDate,
    required this.checklistStatus,
    required this.planId,
    required this.barcode,
 
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Parse the inspection string into a DateTime object
    DateTime inspection = DateTime.parse(inspectionDate);

    // Extract the date part as a string in "yyyy-MM-dd" format
    String inspectionDateStr =
        "${inspection.year}-${inspection.month.toString().padLeft(2, '0')}-${inspection.day.toString().padLeft(2, '0')}";
    String nowDateStr =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(
              color: statusColor,
              width: 10,
            ),
            top: BorderSide(
              width: 2,
              color: statusColor,
            ),
            right: BorderSide(
              width: 2,
              color: statusColor,
            ),
            bottom: BorderSide(
              width: 2,
              color: statusColor,
            ),
          ),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                checklistName,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "Status: $statusText",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "Inspection date: ${inspectionDate.substring(0, 10)}",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    checklistStatus == 3|| checklistStatus == 4
                        ?  CheckPointDetails(planId:planId,acrpinspectionstatus: checklistStatus,)
                        : CaptureImage(context,planId,scannerPage,checklistStatus,0)
              ),
            );
          },
        ),
      ),
    );
  }
}







