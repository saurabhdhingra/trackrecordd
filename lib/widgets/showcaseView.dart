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
    this.onComplete,
  });

  final bool enabled;
  final GlobalKey globalKey;
  final String? title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;
  final Function? onComplete;

  @override
  Widget build(BuildContext context) {
    return enabled
        ? Showcase(
            key: globalKey,
            targetBorderRadius: BorderRadius.circular(20),
            title: title,
            description: description,
            onTargetClick: (onComplete == null) ? null : onComplete!(),
            disposeOnTap: (onComplete != null) ? true : null,
            child: child,
          )
        : child;
  }
}
