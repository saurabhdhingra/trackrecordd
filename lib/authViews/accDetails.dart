import 'package:flutter/material.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trackrecordd/widgets/customField.dart';

class AccdetailsWidget extends StatefulWidget {
  const AccdetailsWidget({Key? key}) : super(key: key);

  @override
  AccdetailsWidgetState createState() => AccdetailsWidgetState();
}

class AccdetailsWidgetState extends State<AccdetailsWidget> {
  String firstname = "";
  String lastName = "";

  static final _firestore = FirebaseFirestore.instance;
  static final _CollectionReference =
      _firestore.collection("Users").doc("UsersInfo").collection("Profile");
  static final _DocumentReference = _CollectionReference.doc('ProfileInfo');

  final TextEditingController textController6 = new TextEditingController();
  final TextEditingController textController7 = new TextEditingController();
  final TextEditingController textController8 = new TextEditingController();
  final TextEditingController textController9 = new TextEditingController();
  final TextEditingController textController10 = new TextEditingController();
  final TextEditingController textController11 = new TextEditingController();
  final TextEditingController textController12 = new TextEditingController();
  final TextEditingController textController13 = new TextEditingController();
  final TextEditingController textController14 = new TextEditingController();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  final _formKey7 = GlobalKey<FormState>();
  final _formKey8 = GlobalKey<FormState>();
  final _formKey9 = GlobalKey<FormState>();
  final _formKey10 = GlobalKey<FormState>();
  final _formKey11 = GlobalKey<FormState>();
  final _formKey12 = GlobalKey<FormState>();
  final _formKey13 = GlobalKey<FormState>();
  final _formKey14 = GlobalKey<FormState>();
  final _formKey15 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Align(
                alignment: const AlignmentDirectional(-0.7, 0),
                child: Text(
                  'Enter your details',
                  style: TextStyle(
                    fontSize: height * 0.035,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Name *'),
              CustomField(
                setValue: (value) => setState(() => firstname),
                formKey: _formKey1,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Last Name *'),
              CustomField(
                setValue: (value) => setState(() => lastName),
                formKey: _formKey2,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Date of birth 👶 *'),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.055,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.15,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      key: _formKey3,
                      obscureText: false,
                      decoration: inputDecoration('Date'),
                      style: TextStyle(
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.075,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.15,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      key: _formKey4,
                      obscureText: false,
                      decoration: inputDecoration('Month'),
                      style: TextStyle(
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.075,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.25,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      key: _formKey5,
                      obscureText: false,
                      decoration: inputDecoration('Year'),
                      style: TextStyle(
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Measurements 📝'),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.16,
                    height: height * 0.02,
                  ),
                  const Text(
                    'Weight🏋️ *',
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(
                    width: width * 0.33,
                    height: height * 0.02,
                  ),
                  const Text(
                    'Height🙆‍♂️ *',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.15,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController6,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.3,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController7,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.08,
                    height: height * 0.02,
                  ),
                  const Text(
                    'Shoulders',
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(
                    width: width * 0.19,
                    height: height * 0.02,
                  ),
                  const Text(
                    'Chest',
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(
                    width: width * 0.23,
                    height: height * 0.02,
                  ),
                  const Text(
                    'Waist',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.08,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController8,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.12,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController9,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.12,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController10,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.19,
                    height: height * 0.02,
                  ),
                  const Align(
                    alignment: AlignmentDirectional(-0.85, 0),
                    child: Text(
                      'Left 💪',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.39,
                    height: height * 0.02,
                  ),
                  const Align(
                    alignment: AlignmentDirectional(-0.85, 0),
                    child: Text(
                      'Right 💪',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.15,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController11,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.3,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController12,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.19,
                    height: height * 0.02,
                  ),
                  const Text(
                    'Left 🦵',
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(
                    width: width * 0.39,
                    height: height * 0.02,
                  ),
                  const Text(
                    'Right 🦵',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: width * 0.15,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController13,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.3,
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.2,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      controller: textController14,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              const Align(
                alignment: AlignmentDirectional(-0.75, 0),
                child:
                    Text('* mandatory, and no we won\'t ask you the gender.'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Align(
                alignment: const AlignmentDirectional(0.7, 0),
                child: Container(
                  width: width * 0.4,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFED500),
                    shape: BoxShape.rectangle,
                    borderRadius:
                        BorderRadius.all(Radius.circular(height / 38)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    child: Text(
                      'Next >>',
                      style: TextStyle(
                        fontSize: height * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
      ),
    );
  }

  Align alignedText(height, String text) {
    return Align(
      alignment: const AlignmentDirectional(-0.85, 0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: height * 0.02,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
