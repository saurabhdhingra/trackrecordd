// import 'package:trackrecord/startupScreens/startup.dart';

// import 'package:trackrecord/screens/todayScreen.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/views/homeView.dart';

class InitializerWidget extends StatefulWidget {
  InitializerWidget();

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  // late User? _user;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();

    // isLoading
    //     ? const Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       )
    //     : _user == null
    //         ? SignupPageWidget()
    //         : HomePage();
  }
}
