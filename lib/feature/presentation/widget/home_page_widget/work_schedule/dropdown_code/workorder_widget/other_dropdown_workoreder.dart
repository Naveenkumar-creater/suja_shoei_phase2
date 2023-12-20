import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/theme_providers.dart';


class OtherDropdownMenuWorkOrder extends StatefulWidget {
  final Widget Open;
  final Widget inProgress;
  final Widget complete;
  final Widget overdue;

  final List<SheetInfo> bottomSheetInfo;

  const OtherDropdownMenuWorkOrder({
    Key? key,
    required this.Open,
    required this.inProgress,
    required this.complete,
    required this.overdue,
    required this.bottomSheetInfo,
  }) : super(key: key);

  @override
  _OtherDropdownMenu createState() => _OtherDropdownMenu();
}

class _OtherDropdownMenu extends State<OtherDropdownMenuWorkOrder> {
  int selectedValueIndex = 0;

  List<String> dropdownOptions = [
    'Open',
    'In Progress',
    'Complete',
    'Overdue',
  ];

  List<Color> valueColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
  ];

  List<int> statusCounts = [0, 0, 0, 0]; // Initialize counts for each status

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

class SheetInfo {
  final String text;
  final Widget content;

  SheetInfo({required this.text, required this.content});
}

class CustomBottomSheet extends StatelessWidget {
  final String text;
  final Widget content;

  const CustomBottomSheet({super.key, 
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
                  icon: const Icon(color: Colors.black54,
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
 