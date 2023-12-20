import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../constant/utils/font_styles.dart';
import '../../../../providers/theme_providers.dart';
import '../dropdown_code/workorder_widget/other_dropdown_workoreder.dart';



class OtherDropDown extends StatefulWidget {
  final String title;

  const OtherDropDown({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<OtherDropDown> createState() => _OtherDropDown();
}

class _OtherDropDown extends State<OtherDropDown> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    
final sheetInfoList = [
  SheetInfo(text: 'Open', content: const Text("No Records Found", style: TextStyle(fontSize:18 ),)),
  SheetInfo(text: 'In Progress', content:  const Text("No Records Found", style: TextStyle(fontSize:18 ),)),
  SheetInfo(text: 'Complete', content:  const Text("No Records Found", style: TextStyle(fontSize:18 ),)),
  SheetInfo(text: 'Overdue', content:  const Text("No Records Found", style: TextStyle(fontSize:18 ),))
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
             OtherDropdownMenuWorkOrder (
              Open: const Column(
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
              ),   bottomSheetInfo: sheetInfoList, 
      
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
