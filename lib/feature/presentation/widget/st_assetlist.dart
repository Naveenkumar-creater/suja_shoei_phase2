import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';
import 'package:suja_shoie_app/feature/presentation/providers/st_dd_assetsetail_provider.dart';

import '../api_services/st_assetlist_service.dart';
import '../api_services/st_dd_assetdetail_service.dart';
import '../providers/st_assetlist_provider.dart';



class SuppoortTicketAssetList extends StatefulWidget {
  const SuppoortTicketAssetList({super.key});

  @override
  State<SuppoortTicketAssetList> createState() => _SuppoortTicketAssetListState();
}

class _SuppoortTicketAssetListState extends State<SuppoortTicketAssetList> {

  final StAssetListService stAssetDetailService =StAssetListService();
  

  @override
  void initState() {
stAssetDetailService.getAssetList(context: context, count: 1);
  }
  
  @override
  Widget build(BuildContext context) {
    final assetList= Provider.of<StAssetListProvider>(context, listen: false).user?.responseData?.assetListForSupportTicket;
    return Scaffold(
      appBar: AppBar(
        title: Text("Asset List"),
      ),
      body: Padding(padding: EdgeInsets.all(defaultPadding),
      child: ListView.builder(
        itemCount:assetList?.length ,
        itemBuilder:(context, index) {
          return Card(
            child: ListTile(title: Text(assetList?[index].assetName ?? ""),),
          );
        },
      ),
      )
    );
  }
}