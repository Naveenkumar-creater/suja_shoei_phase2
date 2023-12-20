import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:suja_shoie_app/feature/presentation/widget/home_page_widget/work_schedule/qr_workorder_data/scan_barcode.dart';

import 'package:suja_shoie_app/constant/utils/responsive.dart';

import '../../providers/theme_providers.dart';
import '../../../../constant/utils/theme_styles.dart';
import 'work_schedule/chart/bar_chart.dart';
import 'work_schedule/chart/progress_bar.dart';
import '../notification_widget/notifications.dart';
import 'work_schedule/chart/chart.dart';
import 'work_schedule/workorder_widget/work_order.dart';

// ignore: use_key_in_widget_constructors
class WorkSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    final themeState = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Responsive(
                    mobile: WorkOrder(crossAxisCount: 4, childAspectRatio: 1.1),
                    tablet: WorkOrder(crossAxisCount: 4, childAspectRatio: 1.2),
                    desktop: WorkOrder(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                    )),
              ),
              if (Responsive.isDesktop(context))
                const SizedBox(
                  width: defaultPadding / 2,
                ),
              if (Responsive.isDesktop(context))
                Expanded(flex: 1, child: ProgressBar(themeState: themeState)),
              const SizedBox(
                width: defaultPadding / 2,
              ),
              if (Responsive.isDesktop(context))
                Expanded(flex: 1, child: Notifications(themeState: themeState)),
            ],
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),

          // Second row
          Row(
            children: [
              if (!Responsive.isDesktop(context))
                Expanded(flex: 1, child: ProgressBar(themeState: themeState)),
              if (!Responsive.isDesktop(context))
                const SizedBox(
                  width: defaultPadding / 2,
                ),
              if (Responsive.isDesktop(context))
                Expanded(flex: 1, child: BarChart(themeState: themeState)),
              if (Responsive.isMobile(context))
                Expanded(flex: 1, child: Notifications(themeState: themeState)),
              if (!Responsive.isDesktop(context))
                const SizedBox(
                  width: defaultPadding / 2,
                ),
              if (Responsive.isMobile(context))
                Expanded(
                  flex: 1,
                  child: Chart(themeState: themeState),
                ),
              if (!Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: BarChart(themeState: themeState),
                ),

              // show in desktop
              if (Responsive.isDesktop(context))
                const SizedBox(
                  width: defaultPadding / 2,
                ),
              if (Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: Chart(themeState: themeState),
                ),
              if (Responsive.isDesktop(context))
                const SizedBox(
                  width: defaultPadding / 2,
                ),
              if (Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: ScanBarcode(themeState: themeState),
                ),
            ],
          ),
          if (!Responsive.isDesktop(context))
            const SizedBox(
              height: defaultPadding / 2,
            ),
          // second row for mobile view
          Row(
            children: [
              if (!Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: Notifications(themeState: themeState),
                ),
              if (!Responsive.isDesktop(context))
                const SizedBox(
                  width: defaultPadding / 2,
                ),
              if (!Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: Chart(themeState: themeState),
                ),
              if (!Responsive.isDesktop(context))
                const SizedBox(
                  width: defaultPadding / 2,
                ),
              if (!Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: ScanBarcode(themeState: themeState),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(
    this.category,
    this.value,
  );
}

class BarChartExample extends StatelessWidget {
  const BarChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    final List<ChartData> chartData = [
      ChartData('Category 1', 20),
      ChartData('Category 2', 35),
      ChartData('Category 3', 10),
      ChartData('Category 4', 25),
    ];

    // Define a map that associates category names with colors
    final categoryColors = {
      'Category 1': Colors.red,
      'Category 2': Colors.blue,
      'Category 3': Colors.green,
      'Category 4': Colors.orange,
    };

    // Determine the text color based on themeState
    final textColor =
        themeState.isDarkTheme ? Colors.white : const Color(0xFF424242);

    List<charts.Series<ChartData, String>> series = [
      charts.Series(
        id: 'chartData',
        data: chartData,
        domainFn: (ChartData data, _) => data.category,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (ChartData data, _) => charts.ColorUtil.fromDartColor(
            categoryColors[data.category] ?? Colors.blue),
      ),
    ];

    return Scaffold(
      backgroundColor:
          themeState.isDarkTheme ? const Color(0xFF424242) : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: charts.BarChart(
          series,
          animate: true,
          domainAxis: charts.OrdinalAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(
              labelStyle: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(
                    textColor), // Use the determined text color here
              ),
            ),
          ),
        ),
      ),
    );
  }
}
