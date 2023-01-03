import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/refactor/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BargraphPage extends StatelessWidget {
  final int lastmonthamount;
  final int thismonthamount;
  final String text1;
  final String text2;
  const BargraphPage({
    super.key,
    required this.thismonthamount,
    required this.text1,
    required this.text2,
    required this.lastmonthamount,
  });

  @override
  Widget build(BuildContext context) {
    log(lastmonthamount.toString());
    log(thismonthamount.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 170,
        child: SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
                labelStyle: GoogleFonts.kreon(fontSize: 16),
                majorGridLines: const MajorGridLines(width: 0),
                //Hide the axis line of x-axis
                axisLine: const AxisLine(width: 0),
                interval: 1),
            primaryYAxis: NumericAxis(
              labelStyle: GoogleFonts.kreon(),
              numberFormat: NumberFormat.compact(),
              minimum: 0,
              maximum: thismonthamount > lastmonthamount
                  ? thismonthamount + 500
                  : lastmonthamount + 500,
              interval: 2000,
              majorGridLines: const MajorGridLines(width: 0),
              //Hide the axis line of x-axis
              axisLine: const AxisLine(width: 0),
            ),
            plotAreaBorderWidth: 0,
            legend: Legend(isVisible: false),
            series: <ChartSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                enableTooltip: true,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                dataSource: [
                  ChartData(text1, lastmonthamount.toDouble(), Colors.red),
                  ChartData(text2, thismonthamount.toDouble(), Colors.blue),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                pointColorMapper: (ChartData data, _) => data.color,
              )
            ]),
      ),
    );
  }
}
