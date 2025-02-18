import 'dart:io';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final String text;
  final bool isEndIndent;
  const SubmitButton({
    Key? key,
    required this.onSubmit,
    this.text = "Submit",
    this.isEndIndent = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.getWidth(context);
    var height = SizeConfig.getHeight(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onSubmit,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            height: height * 0.04,
            width: width * 0.25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: height * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        isEndIndent
            ? SizedBox(
                width: width * 0.05,
              )
            : const SizedBox()
      ],
    );
  }
}
