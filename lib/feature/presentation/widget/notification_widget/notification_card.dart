import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/lottieLoadingAnimation.dart';

import '../../api_services/overdue_notification_service.dart';
import '../../providers/overdue_notification_provider.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
    BuildContext context, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationCard createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  final OverdueNotificationService _notificationService =
      OverdueNotificationService();
  bool isLoading = true; // Added isLoading flag

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is created
    _fetchAssetList();
  }

  Future<void> _fetchAssetList() async {
    try {
      await _notificationService.getOverdueNotification(
        context: context,
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
    return Consumer<OverdueNotificationProvider>(
      builder: (context, assetListProvider, _) {
        final responseData = assetListProvider.user?.responseData;

        final assetList = responseData?.overdueNotificationDataEntity ?? [];

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
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            shadowColor: Colors.black,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 8, right: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: SizedBox(
                                          width: 20,
                                          child: Image.asset(
                                              'assets/images/warning.jpeg')),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          asset.alndescription,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          asset.alndate,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          asset.alndescription,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          asset.alndate,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        const Text(
                                          'Overdue',
                                          style: TextStyle(
                                              color: Colors.red,
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
                        );
                      }).toList(),
                    ),
                  );
      },
    );
  }
}
