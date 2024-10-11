import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/views/authViews/detailsFlow/basicDetails.dart';
import 'package:trackrecordd/views/authViews/initializer.dart';
import 'package:trackrecordd/views/todayFlow/homeView.dart';
import 'package:trackrecordd/views/authViews/signUpFlow/signUp.dart';
import 'package:trackrecordd/widgets/customField.dart';
import '../../../utils/constants.dart';

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
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: height * 0.05),
              Column(
                children: [
                  CustomField(
                    width: 0.9,
                    height: 0.065,
                    hintText: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                    setValue: (String value) {
                      setState(() => email = value);
                    },
                  ),
                  SizedBox(height: height * 0.01),
                  CustomField(
                    width: 0.9,
                    height: 0.065,
                    hintText: 'Password',
                    obscureText: true,
                    setValue: (String value) {
                      setState(() => password = value);
                    },
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
                      onPressed: () async {
                        try {
                          // Sign in with Firebase using email and password
                          await auth.signInWithEmailAndPassword(
                            email: email.trim(),
                            password: password.trim(),
                          );

                          // If successful, navigate to BasicDetailsPage
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const InitializerWidget()),
                          );
                        } on FirebaseAuthException catch (e) {
                          // Handle specific FirebaseAuth errors
                          String errorMessage;

                          switch (e.code) {
                            case 'invalid-email':
                              errorMessage = 'The email address is not valid.';
                              break;
                            case 'user-disabled':
                              errorMessage =
                                  'This user account has been disabled.';
                              break;
                            case 'user-not-found':
                              errorMessage = 'No user found for that email.';
                              break;
                            case 'wrong-password':
                              errorMessage =
                                  'Incorrect password. Please try again.';
                              break;
                            default:
                              errorMessage =
                                  'An unknown error occurred : ${e.code}. Please try again later.';
                              break;
                          }

                          // Display the error message in a SnackBar
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)));
                        } catch (e) {
                          // Handle any other exceptions (e.g., network issues)
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'An unexpected error occurred. Please check your internet connection and try again.'),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    child: Text('Sign up',
                        style: TextStyle(color: Colors.blue[900])),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpView(),
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
