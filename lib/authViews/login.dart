import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/views/homeView.dart';
import 'package:trackrecordd/authViews/createAccount.dart';
import '../utils/constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

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
            children: [
              SizedBox(
                width: width,
                height: height * 0.26,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                    controller: passwordController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style:const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.01,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding:const  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: TextField(
                    controller: emailController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.grey),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                width: 230,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFED500),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(height / 38)),
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
                      auth
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>const  HomeView()));
                      });
                    }),
              ),
              SizedBox(
                height: height * 0.3,
              ),
              Align(
                alignment: const AlignmentDirectional(-0.55, 0),
                child: Row(
                  children: [
                    const Text(
                      '   Don\'t have an account?',
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
                              builder: (context) => const  CreateAccountView(),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
