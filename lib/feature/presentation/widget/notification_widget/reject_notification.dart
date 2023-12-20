import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/lottieLoadingAnimation.dart';
import 'package:suja_shoie_app/feature/presentation/api_services/asset_list_service.dart';
import 'package:suja_shoie_app/feature/presentation/providers/asset_list_provider.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/assetlist_workschedule/asset_list_workschedule.dart';

class RejectNotification extends StatefulWidget {
  const RejectNotification(
    BuildContext context, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RejectNotification createState() => _RejectNotification();
}

class _RejectNotification extends State<RejectNotification> {
  final AssetListService _assetListService = AssetListService();
  bool isLoading = true; // Added isLoading flag

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is created
    _fetchAssetList();
  }

  Future<void> _fetchAssetList() async {
    try {
      await _assetListService.getAssetList(
        context: context,
        count: 5,
      );
      setState(() {
        isLoading = false; // Set isLoading to false when data is fetched
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching asset list: $e');
      setState(() {
        isLoading = false; // Set isLoading to false even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssetListProvider>(
      builder: (context, assetListProvider, _) {
        final responseData = assetListProvider.user?.responseData;

        final assetList = responseData?.assetListForChecklistStatus ?? [];

        return isLoading
            ? Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: LottieLoadingAnimation(),
              )
            : assetList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Text("No Notifications Found"),
                  )
                : Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: assetList.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final asset = entry.value;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckListCardView(
                                  asset.assetId,
                                ),
                              ), 
                              
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Card(
                              elevation: 2,
                              shadowColor: Colors.black,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 8, right: 8),
                                child: Row(
                                  children: [Expanded(flex: 1,
                                      child: Center(child: SizedBox(width: 20
                                      , child: Image.asset('assets/images/warning.jpeg')),),
                                    ),
                                    Expanded(flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            asset.assetName,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            asset.acmphtemplatename,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            asset.locName,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            asset.acrpinspectiondate.substring(0, asset.acrpinspectiondate.length - 8),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          const Text(
                                            'Overdue',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
      },
    );
  }
}








