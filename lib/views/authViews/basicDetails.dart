import 'package:flutter/material.dart';
import 'package:trackrecordd/database/userFunctions.dart';
import 'package:trackrecordd/models/userInfo.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/views/homeView.dart';
import 'package:trackrecordd/widgets/customField.dart';

import '../../database/userFunctions.dart';

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
              CustomTextInputWidget(
                width: 0.9,
                height: 0.06,
                controller: firstNameController,
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Last Name *'),
              CustomTextInputWidget(
                width: 0.9,
                height: 0.06,
                controller: lastNameController,
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Date of birth 👶 *'),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: width * 0.1),
                  CustomTextInputWidget(
                    width: 0.15,
                    height: 0.06,
                    focusNode: dateNode,
                    nextFocusNode: monthNode,
                    controller: dobDateController,
                    keyboardType: TextInputType.number,
                    hintText: "Date",
                  ),
                  SizedBox(width: width * 0.175),
                  CustomTextInputWidget(
                    width: 0.15,
                    height: 0.06,
                    focusNode: monthNode,
                    nextFocusNode: yearNode,
                    controller: dobMonthController,
                    hintText: "Month",
                  ),
                  SizedBox(width: width * 0.15),
                  CustomTextInputWidget(
                    width: 0.2,
                    height: 0.06,
                    focusNode: yearNode,
                    controller: dobYearController,
                    hintText: "Year",
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              alignedText(height, 'Measurements 📝'),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: width * 0.16),
                  Column(
                    children: [
                      const Text(
                        'Weight🏋️ *',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: weightController,
                      )
                    ],
                  ),
                  SizedBox(width: width * 0.3),
                  Column(
                    children: [
                      const Text(
                        'Height🙆‍♂️ *',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: heightController,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: width * 0.08),
                  Column(
                    children: [
                      const Text(
                        'Shoulders',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: shouldersController,
                      )
                    ],
                  ),
                  SizedBox(width: width * 0.13),
                  Column(
                    children: [
                      const Text(
                        'Chest',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: chestController,
                      )
                    ],
                  ),
                  SizedBox(width: width * 0.13),
                  Column(
                    children: [
                      const Text(
                        'Waist',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: waistController,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: width * 0.17),
                  Column(
                    children: [
                      const Text(
                        'Left 💪',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: leftArmController,
                      )
                    ],
                  ),
                  SizedBox(width: width * 0.3),
                  Column(
                    children: [
                      const Text(
                        'Right 💪',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: rightArmController,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: width * 0.17),
                  Column(
                    children: [
                      const Text(
                        'Left 🦵',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: leftLegController,
                      )
                    ],
                  ),
                  SizedBox(width: width * 0.3),
                  Column(
                    children: [
                      const Text(
                        'Right 🦵',
                        style: TextStyle(color: Colors.black87),
                      ),
                      CustomTextInputWidget(
                        width: 0.2,
                        height: 0.06,
                        controller: rightLegController,
                      )
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
                      UserStore store = new UserStore();
                      store
                          .addBasicDetails(
                            userInfo: UserInformation(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
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
    int year = int.parse(dobYearController.text);
    int month = int.parse(dobMonthController.text);
    int date = int.parse(dobDateController.text);
    return DateTime(year, month, date);
  }

  Map<String, dynamic> measurementsParser() {
    return {
      "chest": double.parse(chestController.text),
      "height": double.parse(heightController.text),
      "leftArm": double.parse(leftArmController.text),
      "leftLeg": double.parse(leftLegController.text),
      "rightArm": double.parse(rightArmController.text),
      "rightLeg": double.parse(rightLegController.text),
      "shoulders": double.parse(shouldersController.text),
      "waist": double.parse(waistController.text),
      "weight": double.parse(weightController.text),
    };
  }
}
