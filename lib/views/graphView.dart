import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../utils/constants.dart';

class BarGraphView extends StatelessWidget {
  const BarGraphView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class MyBarGraph extends StatefulWidget {
  final double maxValue;
  final List<Map<String, dynamic>> values;

  const MyBarGraph({
    super.key,
    required this.maxValue,
    required this.values,
  });

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: widget.maxValue,
        minY: 0,
        barGroups: widget.values.map((e) {
          return BarChartGroupData(
            x: e["date"],
            barRods: [BarChartRodData(toY: e["value"])],
          );
        }).toList(),
      ),
    );
  }
}
