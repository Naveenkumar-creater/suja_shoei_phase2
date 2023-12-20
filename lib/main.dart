import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/presentation/pages/spalsh_page.dart';
import 'package:suja_shoie_app/feature/presentation/providers/additional_datapoint_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/asset_list_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/bottom_tap_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/checklist_status_count_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/get_checklist_details_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/loginprovider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/operator_provider.dart';
import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';
import 'feature/data/core/api_constant.dart';
import 'feature/presentation/pages/support_ticket.dart';
import 'feature/presentation/providers/checklist_provider.dart';
import 'feature/presentation/providers/datapoint_provider.dart';
import 'feature/presentation/providers/get_machine_count_provider.dart';
import 'feature/presentation/providers/initiate_pause_provider.dart';
import 'feature/presentation/providers/notification_provider.dart';
import 'feature/presentation/providers/overdue_notification_provider.dart';
import 'feature/presentation/providers/qrscanner_provider.dart';
import 'feature/presentation/providers/st_assetlist_provider.dart';
import 'feature/presentation/providers/st_dd_assetsetail_provider.dart';
import 'feature/presentation/providers/st_dd_pd_provider.dart';
import 'feature/presentation/providers/st_form_detail_provider.dart';
import 'feature/presentation/providers/st_status_count_provider.dart';
import 'feature/presentation/providers/st_submit_provider.dart';
import 'feature/presentation/widget/st_assetlist.dart';
// Make sure you have this import if you are using the 'image' package

void main() async {
  // Ensure Flutter framework is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await ApiConstant.initialize();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
        providers: [
          
          ChangeNotifierProvider<StFormDetailProvider>(
            create: (_) =>   StFormDetailProvider(),
          ),
           ChangeNotifierProvider<StSubmitProvider>(
            create: (_) =>   StSubmitProvider(),
          ),
          ChangeNotifierProvider<SupportTicketStatusCountProvider>(
            create: (_) =>   SupportTicketStatusCountProvider(),
          ),
         ChangeNotifierProvider<StProblemDescriptionProvider>(
            create: (_) =>   StProblemDescriptionProvider(),
          ),
        ChangeNotifierProvider<StAssetListProvider>(
            create: (_) =>   StAssetListProvider(),
          ),
          ChangeNotifierProvider<StAssetDetailProvider>(
            create: (_) =>   StAssetDetailProvider(),
          ),
          ChangeNotifierProvider<LoginProvider>(
            create: (_) => LoginProvider(),
          ),
          ChangeNotifierProvider<GetMachineCountProvider>(
            create: (_) => GetMachineCountProvider(),
          ),
          ChangeNotifierProvider<InitiateProvider>(
            create: (_) => InitiateProvider(),
          ),
          ChangeNotifierProvider<OverdueNotificationProvider>(
            create: (_) => OverdueNotificationProvider(),
          ),
          ChangeNotifierProvider<NotificationProvider>(
            create: (_) => NotificationProvider(),
          ),
          ChangeNotifierProvider<AdditionalDataPointProvider>(
            create: (_) => AdditionalDataPointProvider(),
          ),
          ChangeNotifierProvider<DataPointProvider>(
            create: (_) => DataPointProvider(),
          ),
          ChangeNotifierProvider<OperatorProvider>(
            create: (_) => OperatorProvider(),
          ),
          ChangeNotifierProvider<GetCheckListDetailsProvider>(
            create: (_) => GetCheckListDetailsProvider(),
          ),
          ChangeNotifierProvider<QrScannerProvider>(
            create: (_) => QrScannerProvider(),
          ),
          ChangeNotifierProvider<CheckListProvider>(
            create: (_) => CheckListProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<TabProvider>(
            create: (_) => TabProvider(),
          ),
          ChangeNotifierProvider<CheckListStatusCountProvider>(
            create: (_) => CheckListStatusCountProvider(),
          ),
          ChangeNotifierProvider<AssetListProvider>(
            create: (_) => AssetListProvider(),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: "Suja_Shoei",
              theme: themeData(context, themeProvider.isDarkTheme),
              debugShowCheckedModeBanner: false,
              // ignore: prefer_const_constructors
              home: Scaffold(
                body: const SplashPage(),
              ),
            );
          },
        ));
  }
}
















// class DefaultScreen extends StatefulWidget {
//   const DefaultScreen({Key? key}) : super(key: key);

//   @override
//   _DefaultScreenScreenState createState() => _DefaultScreenScreenState();
// }

// class _DefaultScreenScreenState extends State<DefaultScreen> {
//   final Login_auth_Screen authService = Login_auth_Screen();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       authService.getUserData(context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     final user = userProvider.user;
//     final userToken = user?.token;

//     return Scaffold(
//       body: Builder(
//         builder: (BuildContext context) {
//           return userToken != null && userToken.isNotEmpty
//               ? const MainPage()
//               : const Loginpage();
//         },
//       ),
//     );
//   }
// }


