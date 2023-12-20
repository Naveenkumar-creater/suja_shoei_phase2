import 'package:flutter/material.dart';
import '../../../../pages/cheklist_details_page.dart';
import 'checklist_qrcode_scanner.dart';

class ChecklistCard extends StatelessWidget {
  final Color statusColor;
  final String checklistName;
  final String statusText;
  final String inspectionDate;
  final int checklistStatus;
  final int planId;
  final String barcode;
  final int assetId;

  const ChecklistCard({
    super.key,
    required this.statusColor,
    required this.checklistName,
    required this.statusText,
    required this.inspectionDate,
    required this.checklistStatus,
    required this.planId,
    required this.barcode,
    required this.assetId,
  });

  @override
  Widget build(BuildContext context) {
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
                    checklistStatus == 3 || checklistStatus == 4
                        ? CheckPointDetails(
                            planId: planId,
                            acrpinspectionstatus: checklistStatus,
                          )
                        : QRCodeScannerPage(
                            barcode, planId, checklistStatus, assetId),
              ),
            );
          },
        ),
      ),
    );
  }
}
