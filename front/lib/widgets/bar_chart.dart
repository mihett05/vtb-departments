import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/models/statistic.dart';

class ChartContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Widget chart;

  const ChartContainer({
    Key? key,
    required this.title,
    required this.color,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95 * 0.65,
        padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: chart,
          ),
        ),
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final List<Statistic> stats;

  const BarChartWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) => BarChart(
        BarChartData(
          maxY: 1,
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(
              axisNameWidget: Text("Часы работы"),
            ),
            leftTitles: AxisTitles(
              axisNameWidget: Text("Загруженность"),
            ),
            rightTitles: AxisTitles(
              drawBelowEverything: false,
            ),
          ),
          barGroups: stats
              .map(
                (data) => BarChartGroupData(
                  x: data.dateTime.hour,
                  barRods: [
                    BarChartRodData(
                      toY: data.load,
                      width: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
}
