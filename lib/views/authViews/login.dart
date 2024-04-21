import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/views/homeView.dart';
import 'package:trackrecordd/views/authViews/createAccount.dart';
import 'package:trackrecordd/widgets/customField.dart';
import '../../utils/constants.dart';

class LoginView extends StatefulWidget {
  final bool isLogout;
  const LoginView({Key? key, required this.isLogout}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String email = '';
  String password = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      appBar: AppBar(
        leading: widget.isLogout
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.chevron_left)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: height * 0.05),
              Column(
                children: [
                  CustomTextInputWidget(
                    width: 0.9,
                    height: 0.065,
                    controller: emailController,
                    hintText: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomTextInputWidget(
                    width: 0.9,
                    height: 0.065,
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: 230,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFED500),
                      shape: BoxShape.rectangle,
                      borderRadius:
                          BorderRadius.all(Radius.circular(height / 38)),
                    ),
                    child: TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        onPressed: () {
                          try {
                            auth
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((_) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()));
                            });
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message.toString())));
                          }
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    child: Text('Sign up',
                        style: TextStyle(color: Colors.blue[900])),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountView(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
