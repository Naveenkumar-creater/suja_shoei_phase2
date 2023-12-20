import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/font_styles.dart';
import 'package:suja_shoie_app/feature/presentation/api_services/get_machine_count_service.dart';
import 'package:suja_shoie_app/feature/presentation/providers/get_machine_count_provider.dart';

import '../../../../../../constant/utils/theme_styles.dart';
import '../../../../providers/theme_providers.dart';
import 'progress_bar/circular_progress_bar.dart';
import '../dropdown_code/workorder_widget/dropdown_circularbar.dart';


class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key? key,
    required this.themeState,
  }) : super(key: key);

  final ThemeProvider themeState;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  int selectedValueIndex = 0;

  // Define the onDropdownChanged callback function
  void onDropdownChanged(int index) {
    setState(() {
      selectedValueIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          color: widget.themeState.isDarkTheme
              ? const Color(0xFF424242)
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        height: 248,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              DropdownMenuCircular(
                option: const Text('ALL Widget'),
                inProgress: const Text('Open Widget'),
                complete: const Text('In Progress Widget'),
                overdue: const Text('Overdue Widget'),
                widgetOptions: [
                  _buildProgressBar(300), // Complete
                  _buildProgressBar(400), // InProgress
                  _buildProgressBar(500),
                  _buildProgressBar(600), 
                  _buildProgressBar(700),// Overdue
                ],
                onDropdownChanged: onDropdownChanged,
              ),
              const SizedBox(height: 74),
              const Headings(text: "Machine"),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _loadStatusCount(int machineStatus) async {
    GetmachineCountService getMachineCountService = GetmachineCountService();

    try {
      final _ = await getMachineCountService.getMachineCount(
        context: context,
        machineStatus: machineStatus,
      );

      final getmachineStatusCountProvider =
          Provider.of<GetMachineCountProvider>(context, listen: false);
      final statusCount =
          getmachineStatusCountProvider.user!.acrpInspectionStatusCount;
      final assetIdCount = getmachineStatusCountProvider.user!.acrpAssetIdCount;

      return {
        'acrpInspectionStatusCount': statusCount,
        'acrpAssetIdCount': assetIdCount
      };
    } catch (e) {
      // Handle errors
      return {'acrpInspectionStatusCount': 0, 'acrpAssetIdCount': 0};
    }
  }

  Widget _buildProgressBar(int machineStatus) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadStatusCount(machineStatus),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final statusCount =
              snapshot.data?['acrpInspectionStatusCount'] as int? ?? 0;
          final assetIdCount = snapshot.data?['acrpAssetIdCount'] as int? ?? 0;
          var percentage = statusCount/assetIdCount*100;
          var percentageString = percentage.toStringAsFixed(0);

          return CustomPaint(
            foregroundPainter: CircularProgressBar(
              acrpAssetIdCount: assetIdCount,
              acrpInspectionStatusCount: statusCount,
            ),
            child: Column(
              children: [
                const SizedBox(height: defaultPadding / 2),
                Column(
                  children: [
                    Center(
                      child: Text(
                        '$statusCount/$assetIdCount',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    
                    Center(
                      child: Text(
                        '$percentageString%',
                        style: const TextStyle(fontSize: 15)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          // Handle error state
          return const Text('Error loading data');
        }
      },
    );
  }
}



// class ProgressBar extends StatelessWidget {
//   const ProgressBar({
//     super.key,
//     required this.themeState,
//   });

//   final ThemeProvider themeState;

//   @override
//   Widget build(BuildContext context) {
//     return Card(elevation: 5,
//     shadowColor: Colors.black,
//       child: Container(
//         decoration: BoxDecoration(
           
//           color: themeState.isDarkTheme
//               ? const Color(0xFF424242)
//               : Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//         ),
//         height: 248,
    
//         child:const SizedBox(width: double.infinity,
//           child:  Column(children: [
//             DropdownMenuCircular(
//               option: Text('Option Widget'),
//               inProgress: Text('In Progress Widget'),
//               complete: Text('Complete Widget'),
//               overdue: Text('Overdue Widget'),
//               widgetOptions: [
//                 CompleteProgressBar(),
//                 Text('Overdue Widget'),
//                 CompleteProgressBar(),
//                 Text('Overdue Widget'),
        
//               ],
    
//             ),SizedBox(height: 74),
//             Headings(text: "Machine",)
          
//           ]),
//         ), // Include DropdownMenuExample widget here
//       ),
//     );
//   }
// }


// class CompleteProgressBar extends StatefulWidget {
//   const CompleteProgressBar({
//     super.key,
//   });

//   @override
//   State<CompleteProgressBar> createState() => _CompleteProgressBarState();
// }

// class _CompleteProgressBarState extends State<CompleteProgressBar>
//     with SingleTickerProviderStateMixin {

//       GetmachineCountService getmachineCountService=  GetmachineCountService();
//   @override
//   void initState() {
//     super.initState();
//     getmachineCount();
//   }

//   void getmachineCount(){
//     getmachineCountService.getMachineCount(context: context, machineStatus: 3);
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     final machinecount= Provider.of<GetMachineCountProvider>(context,listen:false).user;
//     var  acrpAssetIdCount =machinecount?.acrpAssetIdCount ??0;
//     var  acrpInspectionStatusCount=machinecount?.acrpInspectionStatusCount ?? 0;
//     return CustomPaint(
//         foregroundPainter: CircularProgressBar( 
//   acrpAssetIdCount:acrpAssetIdCount,acrpInspectionStatusCount: acrpInspectionStatusCount,),
//         child:  Column(
//           children: [const SizedBox(height: defaultPadding/2,),
//             Center(
//                 child: Text(
//               '$acrpInspectionStatusCount/$acrpAssetIdCount',
//               style: const TextStyle(fontSize: 30),
//             )),
//           ],
//         ));
//   }
// }
