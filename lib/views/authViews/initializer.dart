import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:trackrecordd/views/authViews/detailsFlow/basicDetails.dart';
import 'package:trackrecordd/views/authViews/signUpFlow/createAccount.dart';
import 'package:trackrecordd/views/todayFlow/homeView.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../database/userDataStore.dart';
import '../../models/userInfo.dart';
import '../../utils/functions.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({super.key});

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;
  late User? _user;
  UserInformation? _userInformation;

  bool isLoading = true;

  Future<void> fetchUserData() async {
    UserStore userStore = UserStore();
    FirebaseAuth authInstance = FirebaseAuth.instance;

    try {
      String userId = authInstance.currentUser!.uid;
      final UserInformation? userInfo =
          await userStore.getUserInformation(userId: userId);
      _userInformation = userInfo;
      print(_userInformation!.dateJoined);
    } catch (e) {
      print('Error fetching user data: ${e.toString()}');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final ShowcaseActionProvider actionProvider =
        Provider.of<ShowcaseActionProvider>(context);
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? const CreateAccountView()
            : _userInformation == null
                ? const BasicDetailsPage()
                : ShowCaseWidget(
                    builder: (context) => HomeView(
                      action: actionProvider.currAction,
                      userInformation: _userInformation ??
                          UserInformation(
                            firstName: "",
                            lastName: "",
                            dateOfBirth: DateTime.now(),
                            dateJoined: DateTime.now(),
                          ),
                    ),
                  );
  }
}
