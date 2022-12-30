import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/refactor/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BargraphPage extends StatelessWidget {
  final int amount;
  final String text1;
  final String text2;
  const BargraphPage(
      {super.key,
      required this.amount,
      required this.text1,
      required this.text2});

  @override
  Widget build(BuildContext context) {
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
              minimum: 0, maximum: amount + 500,
              interval: 2000,
              majorGridLines: const MajorGridLines(width: 0),
              //Hide the axis line of x-axis
              axisLine: const AxisLine(width: 0),
            ),
            plotAreaBorderWidth: 0,
            legend: Legend(isVisible: false),
            series: <ChartSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                  borderRadius: BorderRadius.circular(10),
                  dataSource: [
                    ChartData(text1, 0),
                    ChartData(text2, amount.toDouble()),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: const Color.fromARGB(255, 215, 81, 71))
            ]),
      ),
    );
  }
}
