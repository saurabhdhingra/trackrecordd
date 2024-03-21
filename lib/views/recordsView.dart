// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'package:trackrecordd/widgets/day_tile.dart';

class RecordsView extends StatefulWidget {
  const RecordsView({Key? key}) : super(key: key);

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  late List<Map<String, dynamic>> data = [];
  // late List<FlSpot> spots = [];
  late List<double> points = [];
  late double y = 100;
  bool isLoading = false;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  // Future graph() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   List<Map<String, dynamic>> check = await DatabaseHelper.instance.queryAll();

  //   List<double> outputs = List.generate(check.length, (i) {
  //     double reps1;
  //     double reps2;
  //     double reps3;
  //     double weight1;
  //     double weight2;
  //     double weight3;
  //     if (check[i]['reps1'] == null) {
  //       reps1 = 0;
  //     } else {
  //       reps1 = check[i]['reps1'];
  //     }
  //     if (check[i]['reps2'] == null) {
  //       reps2 = 0;
  //     } else {
  //       reps2 = check[i]['reps2'];
  //     }
  //     if (check[i]['reps3'] == null) {
  //       reps3 = 0;
  //     } else {
  //       reps3 = check[i]['reps3'];
  //     }
  //     if (check[i]['weight1'] == null) {
  //       weight1 = 0;
  //     } else {
  //       weight1 = check[i]['weight1'];
  //     }
  //     if (check[i]['weight2'] == null) {
  //       weight2 = 0;
  //     } else {
  //       weight2 = check[i]['weight2'];
  //     }
  //     if (check[i]['weight3'] == null) {
  //       weight3 = 0;
  //     } else {
  //       weight3 = check[i]['weight3'];
  //     }

  //     return reps1 * weight1 + reps2 * weight2 + reps3 * weight3;
  //   });
  //   List<FlSpot> data = List.generate(check.length, (i) {
  //     return FlSpot(i.toDouble(), outputs[i]);
  //   });
  //   print(data);
  //   if (data.isNotEmpty) {
  //     this.spots = data;
  //     this.points = outputs;
  //   } else {
  //     this.spots = [];
  //     this.points = [];
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future checkData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   List<Map<String, dynamic>> check = await DatabaseHelper.instance.queryAll();

  //   List<Map<String, dynamic>> checkData = [];
  //   if (check.isNotEmpty) {
  //     for (int i = 0; i < check.length; i++) {
  //       List<Map<String, dynamic>> muscleData = await DatabaseHelper.instance
  //           .muscleData(sqlDateProcess(check[i]['date']));
  //       String muscle1 = muscleData[0]['muscle'];
  //       String muscle2 = muscleData.length > 1 ? muscleData[1]['muscle'] : "";
  //       checkData.add({
  //         'date': check[i]['date'],
  //         'number': check[i]['number'],
  //         'muscle1': muscle1,
  //         'muscle2': muscle2
  //       });
  //     }
  //     this.data = checkData;
  //   } else {
  //     this.data = [];
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future findY() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   double max = 0;
  //   for (int i = 0; i < points.length; i++) {
  //     if (points[i] > max) {
  //       max = points[i];
  //     }
  //   }
  //   this.y = max;
  //   print(y);
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   checkData();
  //   // graph();
  //   // findY();
  // }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xFF403F3C),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   icon: Icon(Icons.chevron_left),
              //   color: Theme.of(context).colorScheme.secondary,
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => HomePage(),
              //       ),
              //     );
              //   },
              // ),
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: const Color(0xFFFFFFFF),
              elevation: 0,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).primaryColor,
                      //     shape: BoxShape.rectangle,
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(height / 38)),
                      //   ),
                      //   width: width * 0.9,
                      //   height: height / 3,
                      //   child: LineChart(
                      //     LineChartData(
                      //       minX: 0,
                      //       maxX: 90,
                      //       minY: 0,
                      //       maxY: y,
                      //       titlesData: FlTitlesData(
                      //           show: true,
                      //           topTitles: SideTitles(showTitles: false),
                      //           rightTitles: SideTitles(showTitles: false),
                      //           leftTitles: SideTitles(
                      //             showTitles: false,
                      //           ),
                      //           bottomTitles: SideTitles(showTitles: false)),
                      //       gridData: FlGridData(
                      //         show: false,
                      //         getDrawingHorizontalLine: (value) {
                      //           return FlLine(
                      //             color: const Color(0xff37434d),
                      //             strokeWidth: 1,
                      //           );
                      //         },
                      //         drawVerticalLine: true,
                      //         getDrawingVerticalLine: (value) {
                      //           return FlLine(
                      //             color: const Color(0xff37434d),
                      //             strokeWidth: 1,
                      //           );
                      //         },
                      //       ),
                      //       borderData: FlBorderData(
                      //         show: false,
                      //         border: Border.all(
                      //             color: const Color(0xff37434d), width: 1),
                      //       ),
                      //       lineBarsData: [
                      //         LineChartBarData(
                      //           spots: spots,
                      //           isCurved: true,
                      //           colors: gradientColors,
                      //           barWidth: 5,
                      //           dotData: FlDotData(show: false),

                      //           // dotData: FlDotData(show: false),
                      //           belowBarData: BarAreaData(
                      //             show: true,
                      //             colors: gradientColors
                      //                 .map((color) => color.withOpacity(0.3))
                      //                 .toList(),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: height * 0.02),
                      SizedBox(
                        width: width,
                        height: height * 0.8186,
                        child: data.isEmpty
                            ? const Center(
                                child: Text('Nothing to show',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)))
                            : ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, i) => Column(
                                  children: const <Widget>[
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // DayTile(
                                    //   number: data[i]['number'],
                                    //   date: sqlDateProcess(data[i]['date'])
                                    //       .day
                                    //       .toString(),
                                    //   month: months[
                                    //       sqlDateProcess(data[i]['date'])
                                    //           .month],
                                    //   day: sqlDateProcess(data[i]['date']),
                                    //   muscle1: data[i]['muscle1'],
                                    //   muscle2: data[i]['muscle2'],
                                    // ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
