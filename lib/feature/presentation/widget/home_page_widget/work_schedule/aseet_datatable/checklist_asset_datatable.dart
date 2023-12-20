import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/lottieLoadingAnimation.dart';
import 'package:suja_shoie_app/feature/presentation/api_services/asset_list_service.dart';
import 'package:suja_shoie_app/feature/presentation/providers/asset_list_provider.dart';
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/assetlist_workschedule/asset_list_workschedule.dart';

class AssetListDataTable extends StatefulWidget {
  final int statuscount;

  const AssetListDataTable(
    BuildContext context, {
    Key? key,
    required this.statuscount,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AssetListDataTableState createState() => _AssetListDataTableState();
}

class _AssetListDataTableState extends State<AssetListDataTable> {
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
        count: widget.statuscount,
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
            ? Center(
                child: LottieLoadingAnimation(),
              )
            : assetList.isEmpty
                ? const Center(
                    child: Text("No Records Found",
                        style: TextStyle(fontSize: 18)),
                  )
                : Expanded(
                    child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      DataTable(
                        showCheckboxColumn: false,
                        headingTextStyle: const TextStyle(color: Colors.white),
                        dataTextStyle: const TextStyle(color: Colors.black),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFF1a1f3c)),
                        dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey.shade100),
                        columns: const [
                          DataColumn(
                            label: Text(
                              "S.No",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            tooltip: "Serial Number",
                          ),
                          DataColumn(
                            label: Text(
                              "Asset Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            tooltip: "represent Asset",
                          ),
                          DataColumn(
                            label: Text(
                              "AssetId",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            tooltip: "represent Asset Tag ID",
                          ),
                          DataColumn(
                            label: Text(
                              "Asset Location",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            tooltip: "represent Asset Location",
                          ),
                        ],
                        rows: assetList.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final asset = entry.value;
                          return DataRow(
                            color: MaterialStateColor.resolveWith((states) =>
                                index % 2 == 0
                                    ? Colors.white
                                    : Colors.grey.shade200),
                            cells: [
                              DataCell(Text(index.toString())),
                              DataCell(Text(asset.assetName)),
                              DataCell(Text("${asset.assetId}")),
                              DataCell(Text(asset.locName)),
                            ],
                            onSelectChanged: (_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckListCardView(
                                    asset.assetId,
                                    // asset.assetName,
                                    // asset.locName,
                                    // asset.assetBarCode),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ));
      },
    );
  }
}
