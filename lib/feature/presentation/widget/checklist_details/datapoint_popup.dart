import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/utils/theme_styles.dart';
import '../../providers/datapoint_provider.dart';

import 'package:flutter/material.dart';

class DataPointsPopup extends StatefulWidget {
  String initialNote;
  final String initialDescription;
  final List<String> initialDataPointValues;
  final void Function(String note, String description, List<String> dataPoints)
      onSubmit;

  DataPointsPopup({super.key, 
    required this.initialNote,
    required this.initialDescription,
    required this.initialDataPointValues,
    required this.onSubmit,
  });

  @override
  _DataPointsPopupState createState() => _DataPointsPopupState();
}

class _DataPointsPopupState extends State<DataPointsPopup> {
  TextEditingController noteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> descriptionControllers = [];
  List<String> dataPointValues = [];

  @override
  void initState() {
    super.initState();
    noteController.text = widget.initialNote;
    descriptionController.text = widget.initialDescription;
    descriptionControllers = List.generate(
      widget.initialDataPointValues.length,
      (index) =>
          TextEditingController(text: widget.initialDataPointValues[index]),
    );
    dataPointValues = List.from(widget.initialDataPointValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        width: 500,
        height: 700,
        color: Colors.white,
        child: Column(
          children: [
            const Row(
              children: [
                Text('Add Images       :'),
                SizedBox(
                  width: 8,
                ),
                // Add your CameraIconWithClick widget here
                SizedBox(
                  width: defaultPadding,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text('Add Notes          :'),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: noteController,
                    onChanged: (value) {
                      // Save the note value as it changes
                      widget.initialNote = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Notes',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 1.0,
                        ),
                      ),
                      hintText: '',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              child: Consumer<DataPointProvider>(
                builder: (context, DetailsProvider, _) {
                  final response = DetailsProvider.user?.responseData;
                  final datapoint = response?.checklistDatapointsList;

                  return Column(
                    children: [
                      Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: datapoint?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = datapoint?[index];

                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                              "${item?.amdpDatapointDescription}"),
                                          const SizedBox(
                                            width: 28,
                                          ),
                                          const Text(":"),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          SizedBox(
                                            width: 300,
                                            height: 50,
                                            child: TextField(
                                              controller:
                                                  descriptionControllers[index],
                                              onChanged: (value) {
                                                // Save the data point value as it changes
                                                dataPointValues[index] = value;
                                              },
                                              decoration: const InputDecoration(
                                                labelText: 'Data Points',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.yellow,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                hintText: '',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: defaultPadding * 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Call the onSubmit callback with the updated values
                    widget.onSubmit(noteController.text,
                        descriptionController.text, dataPointValues);

                    // Close the dialog
                  },
                  child: const Text(
                    "Okay",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the "Cancel" button click here
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
