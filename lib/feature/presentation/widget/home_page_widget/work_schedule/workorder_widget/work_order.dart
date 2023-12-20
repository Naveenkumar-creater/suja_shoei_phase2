import 'package:flutter/material.dart';

import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/workorder_widget/other_dropdown.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/workorder_widget/support_ticket_dropdown.dart';

import '../../../../../../constant/utils/theme_styles.dart';
import 'checklist_dropdown.dart';

class WorkOrder extends StatelessWidget {
  const WorkOrder(
      {super.key, this.childAspectRatio = 1, this.crossAxisCount = 2});
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding / 2,
        mainAxisSpacing: defaultPadding / 2,
        childAspectRatio: childAspectRatio,
        mainAxisExtent: 120,
      ),
      itemBuilder: (context, index) {
        // Customize content based on the container index
        if (index == 0) {
          return const CheklistDropDown(
            title: 'Checklists',
          );
        } else if (index == 1) {
          return const OtherDropDown(
            title: 'Work Orders',
          );
        } else if (index == 2) {
          return const SupportTicketDropdown(
            title: 'Support Tickets',
          );
        } else if (index == 3) {
          return const OtherDropDown(
            title: 'Other Tasks',
          );
        } else {
          // return Container(
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(20)),
          //   ),
          //   child: Center(
          //     child: Text('Container ${index + 1}'),
          //   ),
          // );
        }
        return null;
      },
    );
  }
}
