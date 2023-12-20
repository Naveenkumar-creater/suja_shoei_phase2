import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';
import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';

class SupportTicketAssesmentForm extends StatefulWidget {
  const SupportTicketAssesmentForm({super.key});

  @override
  State<SupportTicketAssesmentForm> createState() =>
      _SupportTicketAssesmentFormState();
}

class _SupportTicketAssesmentFormState
    extends State<SupportTicketAssesmentForm> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final FocusNode solutionFocusNode = FocusNode();
  final TextEditingController assesMentEditingEditingController =
      TextEditingController();
  final TextEditingController solutionEditingController =
      TextEditingController();


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 90,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(90),
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
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Support Ticket Assesment",
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
      body: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(
            defaultPadding *2,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const Text("Assessment"),
                      const SizedBox(height: 5),
                      TextFormField(
                        maxLines: 5,
                  
                        controller: assesMentEditingEditingController,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(solutionFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Value';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "AssessMent",
                            fillColor: Colors.black,
                            labelStyle: const TextStyle(color: Colors.black12),
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
                    height: 20,
                  ),
                  const Text("Assessment"),
                      const SizedBox(height: 5),
                      TextFormField(
                        maxLines: 5,
                        focusNode: solutionFocusNode,
                        controller: solutionEditingController,
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
                            hintText: "Solution",
                            fillColor: Colors.black,
                            labelStyle: const TextStyle(color: Colors.black12),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Submit")),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Go Back"))
                    ],
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
