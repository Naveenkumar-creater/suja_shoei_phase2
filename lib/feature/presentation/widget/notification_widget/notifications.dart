import 'package:flutter/material.dart';
import 'package:suja_shoie_app/constant/utils/font_styles.dart';
import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';
import 'package:suja_shoie_app/feature/presentation/widget/notification_widget/notification_card.dart';


class Notifications extends StatelessWidget {
  const Notifications({
    super.key,
    required this.themeState,
  });
  final ThemeProvider themeState;

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 5,
    shadowColor: Colors.black,
      child: Container(
        height: 248,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: themeState.isDarkTheme ? const Color(0xFF424242) : Colors.white,
          
        ),
        child:  SizedBox(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
                NotificationCard(context),
                const Headings(text:'Notifications'),
                const SizedBox(height:6)
              ]),
        ),
      ),
    );
  }
}