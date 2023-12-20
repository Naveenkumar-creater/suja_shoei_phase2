import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/presentation/pages/asset_page.dart';
import 'package:suja_shoie_app/feature/presentation/pages/message_page.dart';
import 'package:suja_shoie_app/feature/presentation/pages/more_page.dart';
import 'package:suja_shoie_app/feature/presentation/pages/home_page.dart';
import 'package:suja_shoie_app/feature/presentation/widget/main_page_widget/user_details.dart';

import '../providers/bottom_tap_provider.dart';
import '../providers/theme_providers.dart';
import '../../../constant/utils/theme_styles.dart';

class MainPage extends StatefulWidget {
  // ignore: prefer_final_fields
  static List<Widget> _bottomWidgets = <Widget>[
    const HomePage(),
    const AssetPage(),
    const MessagePage (),
    const MorePage(),
  ];

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final tabProvider = Provider.of<TabProvider>(context);

    return WillPopScope(
    onWillPop: () async {
        return false;
      
    },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            color: themeProvider.isDarkTheme
                ? const Color(0xFF212121)
                : const Color(0xFF25476A),
            padding:const EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 115,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                  const  SizedBox( 
                      height: defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Smart Maintenance',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        UserDetails(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: MainPage._bottomWidgets[tabProvider.selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Assets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'More',
            ),
          ],
          currentIndex: tabProvider.selectedIndex,
          selectedItemColor:
              themeProvider.isDarkTheme ? Colors.white : const Color(0xFF25476A),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) => tabProvider.setSelectedIndex(index),
        ),
      ),
    );
  }
}
