import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/utils/constants.dart';

class RowText extends StatelessWidget {
  final String text;
  final bool topPadding;
  const RowText({super.key, required this.text, this.topPadding = false});

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.getWidth(context);
    var height = SizeConfig.getHeight(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: height * 0.01,
        top: topPadding ? height * 0.02 : 0,
      ),
      child: Row(
        children: [
          SizedBox(width: width * 0.05),
          Text(
            text,
            style:
                TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
