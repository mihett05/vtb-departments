import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front/models/statistic.dart';

class BarChartWidget extends StatelessWidget {
  final List<Statistic> stats;

  const BarChartWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) => BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 5,
          minY: 0,
          groupsSpace: 1,
          barGroups: stats
              .map(
                (data) => BarChartGroupData(
                  x: data.dateTime.hour,
                  barRods: [
                    BarChartRodData(
                      toY: data.load,
                      width: 2,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
}
