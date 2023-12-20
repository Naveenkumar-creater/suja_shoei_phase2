import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_providers.dart';
import '../../../constant/utils/font_styles.dart';
import '../../../constant/utils/theme_styles.dart';
import '../widget/home_page_widget/work_schedule.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final themeState = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(defaultPadding/2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: defaultPadding/2),
              child: Headings(
                heading: 'Work Schedule',
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            WorkSchedule(),
            const SizedBox(
              height: defaultPadding,
            )
          ],
        ),
      ),
    );
  }
}
