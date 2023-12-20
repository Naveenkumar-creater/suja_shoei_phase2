// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../api_services/checklist_status_count_service.dart';
import '../../../../../providers/checklist_status_count_provider.dart';
import '../../../../../providers/theme_providers.dart';
import '../../workorder_widget/checklist_dropdown.dart';

class DropdownMenuWorkOrder extends StatefulWidget {
  final Widget pending;
  final Widget open;
  final Widget inProgress;
  final Widget complete;
  final Widget overdue;
  final Widget reject;

  // final Future<dynamic> Function(int) fetchDataFunction;
  // final void Function(dynamic) updateProviderFunction;
  final List<SheetInfo> bottomSheetInfo;

  const DropdownMenuWorkOrder({
    Key? key,
    required this.pending,
    required this.open,
    required this.inProgress,
    required this.complete,
    required this.overdue,
    required this.reject,
    required this.bottomSheetInfo,
  }) : super(key: key);

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuWorkOrder> {
  int selectedValueIndex = 0;

  List<String> dropdownOptions = [
    'Pending',
    'Open',
    'In Progress',
    'Complete',
    'Overdue',
    'Reject'
  ];

  List<Color> valueColors = [
    Colors.indigo,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.black,
  ];

  List<int> statusCounts = [
    0,
    0,
    0,
    0,
    0,
    0
  ]; // Initialize counts for each status

  @override
  void initState() {
    super.initState();
    // Load initial status count for the selected index
    _loadStatusCount(selectedValueIndex);
  }

  void _loadStatusCount(int index) {
    bool isLoading = true;
    int count = index;
    if (count == 0) {
      count = 101;
    }

    if (count == 4) {
      count = 100;
    }

    ChecklistStatusService()
        .getStatusCount(
      context: context,
      count: count,
    )
        .then((_) {
      final checklistStatusCountProvider =
          Provider.of<CheckListStatusCountProvider>(context, listen: false);

      int loadedCount = checklistStatusCountProvider.user!.count;

      setState(() {
        statusCounts[index] = loadedCount;
        isLoading = false; // Set isLoading to false when data is fetched
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 110,
            height: 30,
            child: DropdownButton<int>(
              isExpanded: true,
              elevation: 5,
              underline: Container(),
              value: selectedValueIndex,
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
                  selectedValueIndex = newValueIndex!;
                  _loadStatusCount(
                      newValueIndex); // Load status count for the new index
                });
              },
              items: List.generate(
                dropdownOptions.length,
                (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Row(
                    children: [
                      Text(dropdownOptions[index]),
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
                text: '${statusCounts[selectedValueIndex]}',
                style: TextStyle(
                  fontSize: 43,
                  color: valueColors[selectedValueIndex],
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          text: widget.bottomSheetInfo[selectedValueIndex].text,
          content: widget.bottomSheetInfo[selectedValueIndex].content,
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
