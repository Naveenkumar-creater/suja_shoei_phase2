import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../constant/utils/font_styles.dart';
import '../../../../../../constant/utils/theme_styles.dart';
import '../../../../providers/theme_providers.dart';
import '../aseet_datatable/checklist_asset_datatable.dart';
import '../dropdown_code/workorder_widget/dropdown_button.dart';


class CheklistDropDown extends StatefulWidget {
  final String title;

  const CheklistDropDown({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CheklistDropDown> createState() => _CheklistDropDown();
}

class _CheklistDropDown extends State<CheklistDropDown> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    
final sheetInfoList = [
   SheetInfo(text: 'Pending', content: AssetListDataTable(context, statuscount: 101)),
  SheetInfo(text: 'Open', content: AssetListDataTable(context, statuscount: 1)),
  SheetInfo(text: 'In Progress', content: AssetListDataTable(context, statuscount: 2)),
  SheetInfo(text: 'Complete', content: AssetListDataTable(context, statuscount: 3)),
  SheetInfo(text: 'Overdue', content: AssetListDataTable(context, statuscount: 100)),
  SheetInfo(text: 'Reject', content: AssetListDataTable(context, statuscount: 5)),
];

    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          color: themeState.isDarkTheme ? const Color(0xFF424242) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        
        ),
        child: Column(
          children: [
             DropdownMenuWorkOrder(
              pending:const Column(
                children: [
                  Text('Content for Pending'),
                  // Add additional widgets specific to the 'option' option
                ],
              ),
              open: const Column(
                children: [
                  Text('Content for Option'),
                  // Add additional widgets specific to the 'option' option
                ],
              ),
              inProgress: const Column(
                children: [
                  Text('Content for In Progress'),
                  // Add additional widgets specific to the 'inProgress' option
                ],
              ),
              complete: const Column(
                children: [
                  Text('Content for Complete'),
                  // Add additional widgets specific to the 'complete' option
                ],
              ),
              overdue: const Column(
                children: [
                  Text('Content for Overdue'),
                  // Add additional widgets specific to the 'overdue' option
                ],
              ),
              reject: const Column(
                children: [
                  Text('Content for Overdue'),
                  // Add additional widgets specific to the 'overdue' option
                ],
              ),
      
              bottomSheetInfo: sheetInfoList, 
            ),
            const SizedBox(
              height: 10,
            ),
            Headings(
              text: widget.title,
            ),
          ],
        ),
      ),
    );
  }
}


class SheetInfo {
  final String text;
  final Widget content;

  SheetInfo({required this.text, required this.content});
}