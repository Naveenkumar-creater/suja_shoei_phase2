import 'package:flutter/cupertino.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/assetlist_workschedule/support_ticket_status_card.dart';

import '../../../../../../constant/utils/theme_styles.dart';
import 'asset_staus_color.dart';
import 'checklist_status_card.dart';

// Pass the instance of your AssetStatusColor
class ChecklistWidget extends StatelessWidget {
  final List checklist; // Replace with your data model
  final String title;
  final int assetId; // The dynamic title you want to show

  const ChecklistWidget({
    super.key,
    required this.checklist,
    required this.title,
    required this.assetId,
  });

  @override
  Widget build(BuildContext context) {
    AssetStatusColor assetStatusColor = AssetStatusColor();

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: checklist.length,
              itemBuilder: (context, index) {
                final asset = checklist[index];
                final statusText = assetStatusColor.getStatusText(
                    asset.checkliststatus, asset.inspectiondate);
                final statusColor = assetStatusColor.getStatusColor(
                    asset.checkliststatus, asset.inspectiondate);

                return ChecklistCard(
                  statusColor: statusColor,
                  checklistName: asset.checklistname,
                  statusText: statusText,
                  inspectionDate: asset.inspectiondate,
                  checklistStatus: asset.checkliststatus,
                  planId: asset.planid,
                  barcode: asset.assetbarcode,
                  assetId: assetId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SupportticketWidget extends StatelessWidget {
  final List supportticket; // Replace with your data model
  final String title;
  final int assetId; // The dynamic title you want to show

  const SupportticketWidget(
      {super.key,
      required this.title,
      required this.assetId,
      required this.supportticket});

  @override
  Widget build(BuildContext context) {
    SupportTicketStatusColor supportticketStatusColor =
        SupportTicketStatusColor();

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: supportticket.length,
              itemBuilder: (context, index) {
                final asset = supportticket[index];
                final statusText =
                    supportticketStatusColor.getsupportticketStatusText(
                        asset.amSupTicketStatus, asset.amSupTicketDate);
                final statusColor =
                    supportticketStatusColor.getsupportticketStatusColor(
                        asset.amSupTicketStatus, asset.amSupTicketDate);

                return SupportTicketcard(
                  statusColor: statusColor,
                  // checklistName: asset.checklistname,
                  statusText: statusText,

                  checklistStatus: asset.amSupTicketStatus,
                  //planId: asset.planid,
                  //barcode: asset.assetbarcode,
                  assetId: assetId,
                  amsupticketdate: asset.amSupTicketDate,
                  amsupticketid: asset.amSupTicketId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
