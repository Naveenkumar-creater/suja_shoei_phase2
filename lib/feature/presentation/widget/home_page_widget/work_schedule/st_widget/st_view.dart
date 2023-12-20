import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';

import 'package:suja_shoie_app/feature/presentation/providers/checklist_provider.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/st_widget/support_ticket_assesment.dart';

import '../../../../../../constant/utils/show_snakbar.dart';
import '../../../../../data/core/api_constant.dart';
import '../../../../api_services/st_form_detail_service.dart';
import '../../../../providers/st_form_detail_provider.dart';

import 'package:http/http.dart' as http;

import '../../../../providers/theme_providers.dart';

class SupportTicketview extends StatefulWidget {
  final int supportTicketId;
  const SupportTicketview({Key? key, required this.supportTicketId})
      : super(key: key);

  @override
  State<SupportTicketview> createState() => _SupportTicketviewState();
}

class _SupportTicketviewState extends State<SupportTicketview> {
  final SupportTicketFormService supportTicketFormService =
      SupportTicketFormService();
  bool showDetails = false;
  final GlobalKey<FormState> formkey = GlobalKey();

  final TextEditingController descriptionEditingController =
      TextEditingController();
  final FocusNode decriptionFocusNode = FocusNode();
  final TextEditingController sollutionEditingController =
      TextEditingController();
  final FocusNode sollutionFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    supportTicketFormService.getFormDetails(
        context: context, id: widget.supportTicketId);
  }

  String getCriticalityString(int index) {
    switch (index) {
      case 0:
        return 'None';
      case 1:
        return 'Normal';
      case 2:
        return 'High';
      default:
        return 'None';
    }
  }

  getPriorityString(int index) {
    switch (index) {
      case 0:
        return 'None';
      case 1:
        return 'Normal';
      case 2:
        return 'High';
      default:
        return 'None';
    }
  }

  getassetCondition(int index) {
    switch (index) {
      case 0:
        return 'Break Down';
      case 1:
        return 'Working';
      default:
        return 'Break Down';
    }
  }

  final description = "";

  Future submitAssesmentTicket() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("client_token") ?? "";

    // final personDetails =
    //     Provider.of<LoginProvider>(context, listen: false).user;

    DateTime now = DateTime.now();
    // String toDate = DateFormat('yyyy""-MM-dd HH:mm:ss').format(now);
    final requestBody = {
      "api_for": "solution",
      "assessment_description": descriptionEditingController.text,
      "solution_description": sollutionEditingController.text
    };
    var timeoutDuration = Duration(seconds: 30);
    try {
      http.Response response = await http
          .post(
            Uri.parse(ApiConstant.baseUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(requestBody),
          )
          .timeout(timeoutDuration);

      // ignore: avoid_print
      print(response.body);

      if (response.statusCode == 200) {
        try {
          final responseJson = jsonDecode(response.body);
          print(responseJson);
          return responseJson;
        } catch (e) {
          // Handle the case where the response body is not a valid JSON object
          throw ("Invalid JSON response from the server");
        }
      } else {
        throw ("Server responded with status code ${response.statusCode}");
      }
    } on TimeoutException {
      throw ('Connection timed out. Please check your internet connection.');
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final intialData = Provider.of<StFormDetailProvider>(context, listen: false)
        .user
        ?.responseData
        .supportTicket;
    var themeProvider = Provider.of<ThemeProvider>(context);
    final priorityData = intialData?.amSupTicketPriority;
    final crticalityData = intialData?.amSupTicketCriticality;
    final assetCondition = intialData?.amSupTicketAssetCondition;
    final TextEditingController assetnamecontroller =
        TextEditingController(text: intialData?.assetName);
    final TextEditingController assetConditioncontroller =
        TextEditingController(text: getassetCondition(assetCondition ?? 0));
    final TextEditingController problemDescriptioncontroller =
        TextEditingController(text: intialData?.amSupTicketProblemDescription);
    final TextEditingController descriptioncontroller =
        TextEditingController(text: intialData?.amSupTicketProblemDescription);
    final TextEditingController prioritycontroller =
        TextEditingController(text: getPriorityString(priorityData ?? 0));
    final TextEditingController criticalitycontroller =
        TextEditingController(text: getCriticalityString(crticalityData ?? 0));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 90,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            color: themeProvider.isDarkTheme
                ? const Color(0xFF212121)
                : const Color(0xFF25476A),
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 115,
            child: const SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Support Ticket View",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            bottom: defaultPadding * 4,
            top: defaultPadding,
            right: defaultPadding * 4,
            left: defaultPadding),
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          child: SafeArea(
            child: SingleChildScrollView(
                child: Form(
              key: formkey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: assetnamecontroller,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 10)),
                              labelText: 'Asset Name',
                              contentPadding: EdgeInsets.only(top: 5, left: 20),
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 100,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: assetConditioncontroller,
                          readOnly: true,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5, left: 20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 10)),
                              labelText: 'Asset Condition',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: descriptioncontroller,
                          readOnly: true,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5, left: 20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 10)),
                              labelText: 'Description',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 100,
                      ),
                      Expanded(
                        child: TextField(
                          controller: problemDescriptioncontroller,
                          readOnly: true,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5, left: 20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 10)),
                              labelText: 'ProblemDescription',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: prioritycontroller,
                          readOnly: true,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5, left: 20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 10)),
                              labelText: 'Priority',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 100,
                      ),
                      Expanded(
                        child: TextField(
                          controller: criticalitycontroller,
                          readOnly: true,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5, left: 20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 10)),
                              labelText: 'criticality',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      // decoration: BoxDecoration(color: Colors.grey),
                      child: Column(children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            showDetails = !showDetails;
                          });
                        },
                        child: const Text("Click for Assesment")),
                    const SizedBox(height: 50),
                    if (showDetails)
                      Column(children: [
                        const Row(
                          children: [
                            Text("Description"),
                          ],
                        ),
                        TextFormField(
                          maxLines: 5,
                          focusNode: decriptionFocusNode,
                          controller: descriptionEditingController,
                          // onEditingComplete: () {
                          //   FocusScope.of(context).requestFocus(assetnameFoucusNode);
                          // },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Value';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Description",
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle:
                                  const TextStyle(color: Colors.black12),
                              hintStyle: const TextStyle(color: Colors.black45),
                              contentPadding:
                                  const EdgeInsets.all(defaultPadding * 2),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Row(
                          children: [
                            Text("Sollution"),
                          ],
                        ),
                        TextFormField(
                          maxLines: 5,
                          focusNode: sollutionFocusNode,
                          controller: sollutionEditingController,
                          // onEditingComplete: () {
                          //   FocusScope.of(context).requestFocus(assetnameFoucusNode);
                          // },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Value';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Sollution",
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle:
                                  const TextStyle(color: Colors.black12),
                              hintStyle: const TextStyle(color: Colors.black45),
                              contentPadding:
                                  const EdgeInsets.all(defaultPadding * 2),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate())
                                  //if (formkey.currentState?.validate()==true)
                                  {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        submitAssesmentTicket();
                                        return SupportTicketAssesmentForm();
                                      },
                                    ));
                                  }
                                },
                                child: const Text("Submit")),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: const Text("Go Back"))
                          ],
                        )
                      ]),
                  ]))
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
