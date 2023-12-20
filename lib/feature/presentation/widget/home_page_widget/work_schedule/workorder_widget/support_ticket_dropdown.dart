import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/workorder_widget/support_ticket_list.dart';

import '../../../../../../constant/utils/font_styles.dart';
import '../../../../api_services/st_status_service.dart';
import '../../../../providers/st_status_count_provider.dart';
import '../../../../providers/theme_providers.dart';
import '../aseet_datatable/checklist_asset_datatable.dart';
import '../aseet_datatable/st_asset_datatable.dart';
import '../dropdown_code/workorder_widget/other_dropdown_workoreder.dart';

class SupportTicketDropdown extends StatefulWidget {
  final String title;
  const SupportTicketDropdown({super.key, required this.title});
  
  @override
  State<SupportTicketDropdown> createState() =>
      SupportTicketDropdownState();
}

class SupportTicketDropdownState
    extends State<SupportTicketDropdown> {
      var isLoading=true;
  int selectedIndexValue = 0;
  List<String> dropdownValues = [
    'Open',
    'In Progress',
    'Complete',
    'Overdue',
  ];

    List<Color> colorsValues = [
   
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    
  ];
  List<int> selectedStatusCount = [0, 0, 0, 0];

  @override
  void initState() {
    loadStatusCount(selectedIndexValue);
    super.initState();
  }

  void loadStatusCount(int selectedIndexValue) {
    int count = selectedIndexValue;
    // if (count == 0) {
    //   count = 101;
    // }
    // if (count == 4) {
    //   count = 100;
    // }
    
    SupportTicketStatusService()
        .getStatusCount(
      context: context,
      count: count+1,
    )
        .then((_) {
      final supportTicketStatusCountProvider =
          Provider.of<SupportTicketStatusCountProvider>(context, listen: false);

      int loadedCount = supportTicketStatusCountProvider.user!.count;

      setState(() {
        selectedStatusCount[selectedIndexValue] = loadedCount;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
        final themeState = Provider.of<ThemeProvider>(context);

    return Card(elevation: 5,shadowColor: Colors.black,
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 110,
                  height: 30,
                  child: DropdownButton<int>(
                    isExpanded: true,
                    elevation: 5,
                    underline: Container(),
                    value: selectedIndexValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconEnabledColor:
                        themeState.isDarkTheme ? Colors.blue : Colors.blue,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      color: themeState.isDarkTheme ? Colors.white : Colors.black,
                    ),
                    dropdownColor: themeState.isDarkTheme
                        ? const Color(0xFF424242)
                        : Colors.white,
                    onChanged: (newValueIndex) {
                      setState(() {
                        selectedIndexValue = newValueIndex!;
                        loadStatusCount(
                            newValueIndex); // Load status count for the new index
                      });
                    },
                    items: List.generate(
                      dropdownValues.length,
                      (index) => DropdownMenuItem<int>(
                        value: index,
                        child: Row(
                          children: [
                            Text(dropdownValues[index]),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '${selectedStatusCount[selectedIndexValue]}',
                      style: TextStyle(
                        fontSize: 43,
                        color: colorsValues[selectedIndexValue],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ), const SizedBox(
              height: 10,
            ),
            Headings(
              text: widget.title,
            ),
        ],
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {

          final List<SheetInfo> bottomSheetInfo = [
  SheetInfo(text: 'Open', content: StAssetListDataTable(context, statuscount: 1)),
  SheetInfo(text: 'In Progress', content: StAssetListDataTable(context, statuscount: 2)),
  SheetInfo(text: 'Complete', content: StAssetListDataTable(context, statuscount: 3)),
  SheetInfo(text: 'Overdue', content: StAssetListDataTable(context, statuscount: 4)),
];


        // final List<SheetInfo> bottomSheetInfo = [
         
        //   SheetInfo(
        //       text: 'Open',
        //       // ignore: prefer_const_constructors
        //       content:  SupportTicketList()),
        //   SheetInfo(
        //       text: 'In Progress',
        //       content: const SupportTicketList()),
        //   SheetInfo(
        //       text: 'Complete',
        //       content: AssetListDataTable(context, statuscount: 3)),
        //   SheetInfo(
        //       text: 'Overdue',
        //       content: AssetListDataTable(context, statuscount: 100)),
         
        // ];
        return CustomBottomSheet(
          text: bottomSheetInfo[selectedIndexValue].text,
          content: bottomSheetInfo[selectedIndexValue].content,
        );
      },
    );
  }
}

 
class CustomBottomSheet extends StatelessWidget {
  final String text;
  final Widget content;

  const CustomBottomSheet({
    super.key,
    required this.text,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    color: Colors.black54,
                    Icons.close,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }
}
 

