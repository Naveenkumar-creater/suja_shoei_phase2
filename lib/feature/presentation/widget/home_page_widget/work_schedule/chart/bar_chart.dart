import 'package:flutter/material.dart';

import '../../../../providers/theme_providers.dart';
import '../../work_schedule.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.themeState,
  });

  final ThemeProvider themeState;

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 5,shadowColor: Colors.black,
      child: Container(
        height: 248,
        decoration: BoxDecoration( 
          color: themeState.isDarkTheme
              ?  const Color(0xFF424242):Colors.white
              
        ),
        child: const BarChartExample(),
      ),
    );
  }
}

