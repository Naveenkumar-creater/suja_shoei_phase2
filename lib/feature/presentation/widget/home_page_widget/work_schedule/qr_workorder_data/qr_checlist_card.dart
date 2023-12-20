// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/lottieLoadingAnimation.dart';

import 'package:suja_shoie_app/feature/presentation/api_services/qrscanner_service.dart';
import 'package:suja_shoie_app/feature/presentation/providers/qrscanner_provider.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/qr_workorder_data/qr_checklist_expand.dart';

import '../../../../../../constant/utils/theme_styles.dart';
import '../../../../pages/main_page.dart';
import '../../../../providers/theme_providers.dart';

// ignore: duplicate_ignore
class QrCheklistCard extends StatefulWidget {
  final String barcode;

  const QrCheklistCard(
    this.barcode,
  );

  @override
  // ignore: library_private_types_in_public_api
  _CheckListCardViewState createState() => _CheckListCardViewState();
}

class _CheckListCardViewState extends State<QrCheklistCard> {
  final QrScannerService _qrScannerService = QrScannerService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCheckList();
  }

  Future<void> _fetchCheckList() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _qrScannerService.getCheckList(
        context: context,
        barcode: widget.barcode,
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching checklist: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to MainPage and replace the current page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
        return true; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
           automaticallyImplyLeading: true,
                       iconTheme: const IconThemeData(
    color: Colors.white, 
  ),
          toolbarHeight: 90,
          title: Consumer<QrScannerProvider>(
            builder: (context, qrScannerProvider, _) {
              final responseData = qrScannerProvider.user?.responseData;
              final checklist = responseData?.checklist ?? [];
              String firstChecklistItem = '';
    
              if (checklist.isNotEmpty) {
                firstChecklistItem = checklist[0].assetname;
              }
    
              return PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: Container(
                  color: themeProvider.isDarkTheme
                      ? const Color(0xFF212121)
                      : const Color(0xFF25476A),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 115,
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                      firstChecklistItem  ,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Other properties of the AppBar
        ),
        body: Consumer<QrScannerProvider>(
          builder: (context, qrScannerProvider, _) {
            final responseData = qrScannerProvider.user?.responseData;
            final checklist = responseData?.checklist ?? [];
    
            return isLoading
                ? Center(
                    child: LottieLoadingAnimation(),
                  )
                : checklist.isEmpty
                    ? const Center(
                        child: Text("Unknown Asset", style: TextStyle(fontSize: 30.0)),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QrChecklistWidget(
                              checklist: checklist,
                              title: 'CheckList',
                            ),
                            
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: defaultPadding * 5),
                                  child: const Text(
                                    "Work Order",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: defaultPadding * 5),
                                  child: const Text(
                                    "Support Ticket",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                                Expanded(
                                flex: 1,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: defaultPadding * 5),
                                  child: const Text(
                                    "Other Task",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          ],
                        ),
                      );
          },
        ),
      ),
    );
  }
}
