import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/st_widget/st_view.dart';
import '../../../../pages/cheklist_details_page.dart';
import 'checklist_qrcode_scanner.dart';

class SupportTicketcard extends StatelessWidget {
  final Color statusColor;
  //final String checklistName;
  final String statusText;

  final int checklistStatus;
  // final int planId;
  // final String barcode;
  final int assetId;
  final int amsupticketid;
  final String amsupticketdate;

  const SupportTicketcard({
    super.key,
    required this.statusColor,
    // required this.checklistName,
    required this.statusText,
    required this.checklistStatus,
    // required this.planId,
    // required this.barcode,
    required this.assetId,
    required this.amsupticketdate,
    required this.amsupticketid,
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
                "amsupticketid:$amsupticketid",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "Status: $statusText",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "amsupticket date: $amsupticketdate",
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
SupportTicketview(supportTicketId: amsupticketid,)
         
            
              )
              );
          },
        ),
      ),
    );
  }
}
