import 'package:flutter/material.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
import 'package:trackrecordd/database/userDataStore.dart';
import 'package:trackrecordd/models/userInfo.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/views/homeView.dart';
import 'package:trackrecordd/widgets/customField.dart';

import '../../database/userDataStore.dart';

class BasicDetailsPage extends StatefulWidget {
  const BasicDetailsPage({Key? key}) : super(key: key);

  @override
  BasicDetailsPageState createState() => BasicDetailsPageState();
}

class BasicDetailsPageState extends State<BasicDetailsPage> {
  final FocusNode dateNode = FocusNode(debugLabel: "date");
  final FocusNode monthNode = FocusNode(debugLabel: "date");
  final FocusNode yearNode = FocusNode(debugLabel: "date");

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobDateController = TextEditingController();
  final TextEditingController dobMonthController = TextEditingController();
  final TextEditingController dobYearController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController shouldersController = TextEditingController();
  final TextEditingController chestController = TextEditingController();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController leftArmController = TextEditingController();
  final TextEditingController rightArmController = TextEditingController();
  final TextEditingController leftLegController = TextEditingController();
  final TextEditingController rightLegController = TextEditingController();

  String firstName = "";
  String lastName = "";
  String dobDate = "";
  String dobMonth = "";
  String dobYear = "";
  String weight = "";
  String height = "";
  String shoulders = "";
  String chest = "";
  String waist = "";
  String leftArm = "";
  String rightArm = "";
  String leftLeg = "";
  String rightLeg = "";

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
              CustomField(setValue: (value) => firstName = value),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Last Name *'),
              CustomField(setValue: (value) => lastName = value),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Date of birth 👶 *'),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomField(
                    width: 0.15,
                    height: 0.06,
                    setValue: (value) => dobDate = value,
                    hintText: "Date",
                  ),
                  CustomField(
                    width: 0.175,
                    height: 0.06,
                    setValue: (value) => dobMonth = value,
                    hintText: "Month",
                  ),
                  CustomField(
                    width: 0.2,
                    height: 0.06,
                    setValue: (value) => dobYear = value,
                    hintText: "Year",
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Measurements 📝'),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Weight🏋️ *',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => weight = value,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Height🙆‍♂️ *',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => height = value,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Shoulders',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => shoulders = value,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Chest',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => chest = value,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Waist',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => waist = value,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Left 💪',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => leftArm = value,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Right 💪',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => rightArm = value,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Left 🦵',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => leftLeg = value,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Right 🦵',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomField(
                        width: 0.2,
                        height: 0.06,
                        setValue: (value) => rightLeg = value,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              const Align(
                alignment: AlignmentDirectional(0.7, 0),
                child: Text(
                  '* mandatory',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Align(
                alignment: const AlignmentDirectional(0.75, 0),
                child: Container(
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFED500),
                    shape: BoxShape.rectangle,
                    borderRadius:
                        BorderRadius.all(Radius.circular(height / 38)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      UserStore store = UserStore();
                      ExerciseInfoDataStore exerciseInfoDataStore =
                          ExerciseInfoDataStore();
                      exerciseInfoDataStore.batchWrite();
                      store
                          .addBasicDetails(
                            userInfo: UserInformation(
                              firstName: firstName,
                              lastName: lastName,
                              dateOfBirth: dateTimeParser(),
                              dateJoined: DateTime.now(),
                              measurements: measurementsParser(),
                            ),
                          )
                          .then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const HomeView();
                                },
                              ),
                            ),
                          );
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

  DateTime dateTimeParser() {
    int year = int.parse(dobYear);
    int month = int.parse(dobMonth);
    int date = int.parse(dobDate);
    return DateTime(year, month, date);
  }

  Map<String, dynamic> measurementsParser() {
    return {
      "chest": double.parse(chest != "" ? chest : "0"),
      "height": double.parse(height != "" ? height : "0"),
      "leftArm": double.parse(leftArm != "" ? leftArm : "0"),
      "leftLeg": double.parse(leftLeg != "" ? leftLeg : "0"),
      "rightArm": double.parse(rightArm != "" ? rightArm : "0"),
      "rightLeg": double.parse(rightLeg != "" ? rightLeg : "0"),
      "shoulders": double.parse(shoulders != "" ? shoulders : "0"),
      "waist": double.parse(waist != "" ? waist : "0"),
      "weight": double.parse(weight != "" ? weight : "0"),
    };
  }
}
