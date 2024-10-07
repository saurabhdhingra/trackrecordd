import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'initializer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const InitializerWidget(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: const RiveAnimation.asset(
            'images/trackrecord.riv',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
