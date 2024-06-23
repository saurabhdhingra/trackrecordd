import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:trackrecordd/widgets/dayTileGraph.dart';

import '../utils/constants.dart';

class BarGraphView extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String exerciseName;
  final double maxValue;
  const BarGraphView(
      {super.key,
      required this.exerciseName,
      required this.data,
      required this.maxValue});

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(exerciseName),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.23,
              child: MyBarGraph(maxValue: maxValue, values: data),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return DayTileGraph(
                  index: index + 1,
                  day: data[index]["date"],
                  value: data[index]["value"],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06, vertical: height * 0.02),
              child: Text(
                "CTS stands for Consolidated Training Score which is a metric to self evaluate the work done or the effort put during an exercise. \n\nIt is calculated by summing up of the products of repitions and weight in each set.",
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                ),
              ),
            )
          ],
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.getWidth(context);
    return BarChart(
      BarChartData(
        maxY: widget.maxValue,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups: List.generate(
          widget.values.length,
          (index) => BarChartGroupData(
            x: index + 1,
            barRods: [
              BarChartRodData(
                toY: widget.values[index]["value"],
                color: Colors.grey[800],
                width: 25,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  color: Colors.grey[200],
                  show: true,
                  toY: widget.maxValue + 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        widget.values[value.toInt()]["date"],
        style: const TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.541),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
