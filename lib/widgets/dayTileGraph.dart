import 'package:flutter/material.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/views/dateView.dart';
// import 'package:trackrecord/screens/dateScreen.dart';

class DayTileGraph extends StatefulWidget {
  final DateTime day;

  final double value;

  const DayTileGraph({
    super.key,
    required this.day,
    required this.value,
  });

  @override
  State<DayTileGraph> createState() => _DayTileGraphState();
}

class _DayTileGraphState extends State<DayTileGraph> {
  List months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return ListTile(
      leading: Container(
        width: width / 7,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(height / 70)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                widget.day.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: width * 0.03,
                ),
              ),
              Text(
                months[widget.day.month - 1],
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: width * 0.03,
                ),
              )
            ],
          ),
        ),
      ),
      title: Text('${widget.value.toString()} Normalized Training Score'),
    );
  }
}
