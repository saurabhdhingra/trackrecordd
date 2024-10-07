import 'package:flutter/material.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/views/dayFlow/dateView.dart';
// import 'package:trackrecord/screens/dateScreen.dart';

class DayTile extends StatefulWidget {
  final DateTime day;
  final int number;
  final String muscle1;
  final String? muscle2;

  const DayTile({
    super.key,
    required this.number,
    required this.day,
    required this.muscle1,
    this.muscle2,
  });

  @override
  State<DayTile> createState() => _DayTileState();
}

class _DayTileState extends State<DayTile> {
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
      title: Text(widget.muscle1 +
          (widget.muscle2 != '' ? " and ${widget.muscle2}" : '')),
      subtitle: Text(
          '${widget.number}${widget.number == 1 ? " Exercise" : " Exercises"}'),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DateView(date: widget.day),
            ),
          );
        },
      ),
    );
  }
}
