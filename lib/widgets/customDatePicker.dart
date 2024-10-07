import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';

class CustomDatePickerField extends StatefulWidget {
  final DateTime? selectedDate;
  final TextEditingController dateController;

  const CustomDatePickerField({
    Key? key,
    this.selectedDate,
    required this.dateController,
  }) : super(key: key);

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    widget.dateController.text = _formatDate(_selectedDate!);
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _pickDate(BuildContext context) async {
    if (Platform.isIOS) {
      await _showCupertinoDatePicker(context);
    } else {
      await _showMaterialDatePicker(context);
    }
  }

  Future<void> _showMaterialDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2010, 01, 01),
      firstDate: DateTime(1940),
      lastDate: DateTime(2012),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(primary: Theme.of(context).colorScheme.secondary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .secondary, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.dateController.text = _formatDate(pickedDate);
      });
    }
  }

  Future<void> _showCupertinoDatePicker(BuildContext context) async {
    DateTime pickedDate = _selectedDate ?? DateTime.now();

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.35,
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.done),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).copyWith().size.height * 0.25,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: pickedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      widget.dateController.text = _formatDate(newDate);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: GestureDetector(
        onTap: () => _pickDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: widget.dateController,
            decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColor,
              hintText: 'Select Date',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
