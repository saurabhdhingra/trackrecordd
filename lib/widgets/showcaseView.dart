import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({
    super.key,
    required this.globalKey,
    this.title,
    required this.description,
    required this.child,
    this.shapeBorder = const CircleBorder(),
    required this.enabled,
  });

  final bool enabled;
  final GlobalKey globalKey;
  final String? title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) {
    return enabled
        ? Showcase(
            key: globalKey,
            title: title,
            description: description,
            child: child,
          )
        : child;
  }
}
