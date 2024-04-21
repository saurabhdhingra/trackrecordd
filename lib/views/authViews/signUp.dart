import 'package:flutter/material.dart';
import 'package:trackrecordd/views/authViews/createAccount.dart';
import 'package:trackrecordd/views/authViews/login.dart';
import 'package:trackrecordd/utils/uiUtils.dart';
import '../../utils/constants.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: height * 0.1),
              Column(
                children: [
                  Text(
                    'Track your workouts with us',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.06,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  createAccountButton(width, height, context),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '   Already have an account ?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    loginButton(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return GestureDetector(
      child: Text(' Log in', style: TextStyle(color: Colors.blue[900])),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(isLogout: false,),
          ),
        );
      },
    );
  }

  Container createAccountButton(width, height, BuildContext context) {
    return Container(
      width: width * 0.5,
      decoration: BoxDecoration(
          color: const Color(0xFFFED500),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(height / 38))),
      child: TextButton(
        child: Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.045,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAccountView(),
            ),
          );
        },
      ),
    );
  }
}
