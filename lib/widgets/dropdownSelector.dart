import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class DropdownSelector extends StatefulWidget {
  final Function(int) setState;
  final String dropDownValue;
  final List items;
  final FixedExtentScrollController? scrollController;
  const DropdownSelector({
    Key? key,
    required this.setState,
    required this.items,
    required this.dropDownValue,
    this.scrollController,
  }) : super(key: key);

  @override
  State<DropdownSelector> createState() => _DropdownSelectorState();
}

class _DropdownSelectorState extends State<DropdownSelector> {
  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.getWidth(context);
    var height = SizeConfig.getHeight(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          width * 0.025, height * 0.01, width * 0.025, height * 0.02),
      child: SizedBox(
        height: height * 0.07,
        child: Platform.isIOS
            ? CupertinoPicker(
                scrollController: widget.scrollController,
                magnification: 1.5,
                itemExtent: height * 0.025,
                onSelectedItemChanged: (int value) {
                  widget.setState(value);
                },
                children: widget.items
                    .map(
                      (e) => Center(
                        child: Text(
                          e.toString(),
                          style: TextStyle(
                              fontSize: height * 0.02, color: Colors.black87),
                        ),
                      ),
                    )
                    .toList(),
              )
            : DropdownButton<String>(
                underline: const SizedBox(),
                isExpanded: true,
                style: const TextStyle(color: Colors.black87),
                value: widget.dropDownValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (value) {
                  int intValue =
                      value == null ? 0 : widget.items.indexOf(value);
                  widget.setState(intValue);
                },
                items: widget.items
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Center(
                          child: Text(
                            e,
                            style: TextStyle(
                                fontSize: width * 0.04, color: Colors.black87),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
