import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import '../utils/constants.dart';

class CustomDatePickerField extends StatefulWidget {
  DateTime selectedDate;
  final TextEditingController dateController;
  CustomDatePickerField(
      {super.key, required this.selectedDate, required this.dateController});

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  Future<void> _pickDate(BuildContext context) async {
    if (Platform.isAndroid) {
      // Android date picker
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null && pickedDate != widget.selectedDate) {
        setState(() {
          widget.selectedDate = pickedDate;
          widget.dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        });
      }
    } else if (Platform.isIOS) {
      // iOS Cupertino date picker
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  initialDateTime: widget.selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime picked) {
                    setState(() {
                      widget.selectedDate = picked;
                      widget.dateController.text =
                          "${picked.toLocal()}".split(' ')[0];
                    });
                  },
                ),
              ),
              CupertinoButton(
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: TextField(
        controller: widget.dateController,
        readOnly: true,
        onTap: () => _pickDate(context),
        decoration: InputDecoration(
          hintText: 'Select Date',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
