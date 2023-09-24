import 'package:flutter/material.dart';
import 'package:trackrecordd/utils/constants.dart';
// import 'package:trackrecord/screens/dateScreen.dart';

class DayTile extends StatefulWidget {
  final DateTime day;
  final String date;
  final String month;
  final int number;
  final String muscle1;
  final String muscle2;
  const DayTile(
      {Key? key,
      required this.date,
      required this.month,
      required this.number,
      required this.day,
      required this.muscle1,
      required this.muscle2})
      : super(key: key);

  @override
  State<DayTile> createState() => _DayTileState();
}

class _DayTileState extends State<DayTile> {
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
            children: <Widget>[
              SizedBox(
                height: height / 90,
              ),
              Text(
                widget.date,
                style: TextStyle(
                  fontSize: height / 50,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                widget.month,
                style: TextStyle(
                  fontSize: height / 55,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
        ),
      ),
      title: Text(widget.muscle1 +
          (widget.muscle2 != '' ? " and ${widget.muscle2}" : '')),
      subtitle: Text('${widget.number} Exercises'),
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DatePage(date: widget.day),
          //   ),
          // );
        },
      ),
    );
  }
}
