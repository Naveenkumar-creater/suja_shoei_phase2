import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api_services/additional_datapoint_service.dart';
import '../../providers/additional_datapoint_provider.dart';

class AdditionalDataPoint extends StatefulWidget {
  final List<DataEntry>? initialData;
  final Function(DataEntry) onEntryAdded;

  const AdditionalDataPoint(
      {super.key, this.initialData, required this.onEntryAdded});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class DataEntry {
  String option;
  String dataPoints;
  int amdpId;

  DataEntry(
      {required this.option, required this.dataPoints, required this.amdpId});
}

class _MyStatefulWidgetState extends State<AdditionalDataPoint> {
  String selectedOption = "Add info";
  TextEditingController dataPointsController = TextEditingController();
  List<DataEntry> dataEntries = [];
  List<DataEntry> deletedEntries = [];
  AdditionalDataPointService additionalDataPointService =
      AdditionalDataPointService();

  bool isLoading = true; // Add this line

  @override
  void initState() {
    super.initState();

    dataEntries = widget.initialData ?? [];

    additionalDataPointService
        .getAdditionalDatapoint(context: context)
        .then((_) {
      setState(() {
        isLoading = false; // Data loaded, set isLoading to false
      });
    });
  }

  List<String> options = ["Add info"];

  void updateDropdownOptions() {
    final additionalDataPointValue =
        Provider.of<AdditionalDataPointProvider>(context, listen: false);

    final assetIds = additionalDataPointValue
        .user?.responseData.additionaldatapointslist
        .map((data) => data.amdpDatapointDescription.toString())
        .toSet()
        .toList();

    if (assetIds != null) {
      setState(() {
        options = ["Add info"];
        options.addAll(assetIds);
      });
    }
  }

  void showRow(String option, int amdpId) {
    if (option != "Add info" &&
        !dataEntries.any((entry) => entry.option == option)) {
      setState(() {
        DataEntry newEntry =
            DataEntry(option: option, dataPoints: "", amdpId: amdpId);
        options.remove(option);

        widget.onEntryAdded(newEntry);
      });
    }
  }

  void deleteRow(String option) {
    setState(() {
      // Move the entry to deletedEntries instead of removing it
      DataEntry deletedEntry = dataEntries.firstWhere(
          (entry) => entry.option == option,
          orElse: () => DataEntry(option: "", dataPoints: "", amdpId: 0));
      deletedEntries.add(deletedEntry);

      dataEntries.removeWhere((entry) => entry.option == option);
      options.add(option);
      options.sort();
    });
  }

  int getAmdpIdForOption(String option) {
    final additionalDataPointValue =
        Provider.of<AdditionalDataPointProvider>(context, listen: false);

    final responseData = additionalDataPointValue.user?.responseData;

    if (responseData != null) {
      final dataPintsMstr = responseData.additionaldatapointslist;

      final selectedAmdp = dataPintsMstr.firstWhere(
        (data) => data.amdpDatapointDescription == option,
      );

      return selectedAmdp.amdpDatapointId;
    }

    return 0; // Default to 0 if no matching element is found
  }

  @override
  Widget build(BuildContext context) {
    updateDropdownOptions();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 4, right: 4),
          width: 130,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (isLoading) // Show loading indicator while loading
                const CircularProgressIndicator(),
              if (!isLoading)
                DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      final selectedAmdpId = getAmdpIdForOption(newValue);
                      showRow(newValue, selectedAmdpId);
                    }
                  },
                  items: options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (selectedOption != "Add info")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  SizedBox(width: 135, child: Text(selectedOption)),
                  const Text(':'),
                  const SizedBox(width: 8),
                  Container(
                    width: 275,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: dataPointsController,
                      onChanged: (text) {
                        setState(() {
                          final int amdpId = getAmdpIdForOption(selectedOption);
                          dataEntries.removeWhere(
                              (entry) => entry.option == selectedOption);
                          dataEntries.add(DataEntry(
                              option: selectedOption,
                              dataPoints: text,
                              amdpId: amdpId));
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Value',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.yellow,
                            width: 1.0,
                          ),
                        ),
                        hintText: '',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a value'; // Error message when empty
                        }
                        return null; // Return null when valid
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteRow(selectedOption);
                      dataPointsController.clear(); // Clear the text field
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dataEntries.map((entry) {
            final TextEditingController entryController =
                TextEditingController(text: entry.dataPoints);

            return Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(width: 135, child: Text(' ${entry.option} ')),
                    const Text(':'),
                    const SizedBox(width: 8),
                    Container(
                      width: 275,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: entryController,
                        onChanged: (text) {
                          entry.dataPoints = text;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter Value',
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow,
                              width: 1.0,
                            ),
                          ),
                          hintText: '',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a value'; // Error message when empty
                          }
                          return null; // Return null when valid
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteRow(entry.option);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
