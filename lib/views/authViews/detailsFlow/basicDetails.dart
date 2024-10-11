import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
import 'package:trackrecordd/database/userDataStore.dart';
import 'package:trackrecordd/models/userInfo.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/views/todayFlow/homeView.dart';
import 'package:trackrecordd/widgets/customDatePicker.dart';
import 'package:trackrecordd/widgets/customField.dart';

import '../../../database/userDataStore.dart';
import '../../../utils/functions.dart';

class BasicDetailsPage extends StatefulWidget {
  const BasicDetailsPage({Key? key}) : super(key: key);

  @override
  BasicDetailsPageState createState() => BasicDetailsPageState();
}

class BasicDetailsPageState extends State<BasicDetailsPage> {
  final FocusNode dateNode = FocusNode(debugLabel: "date");
  final FocusNode monthNode = FocusNode(debugLabel: "date");
  final FocusNode yearNode = FocusNode(debugLabel: "date");

  DateTime dateOfBirth = DateTime(2010, 01, 01);

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

  late ScrollController _scrollController;

  bool showAppBarContent = false;

  void runAnimation1() {
    if (_scrollController.position.extentBefore >
        MediaQuery.of(context).size.height * 0.3) {
      setState(() => showAppBarContent = true);
    } else {
      setState(() => showAppBarContent = false);
    }
  }

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() => runAnimation1());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    var theme = Theme.of(context); // Access the theme

    final ShowcaseActionProvider actionProvider =
        Provider.of<ShowcaseActionProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: showAppBarContent
              ? Text(
                  'Enter your details',
                  style: TextStyle(color: Theme.of(context).highlightColor),
                )
              : null),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: height * 0.02),
              Align(
                alignment: const AlignmentDirectional(-0.7, 0),
                child: Text(
                  'Enter your details',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: height * 0.035,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Name *'),
              CustomField(setValue: (value) => firstName = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Last Name *'),
              CustomField(setValue: (value) => lastName = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Date of birth 👶 *'),
              CustomDatePickerField(
                  selectedDate: dateOfBirth, dateController: dobDateController),
              SizedBox(height: height * 0.02),
              alignedText(theme, height * 1.2, 'Measurements 📝'),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Weight🏋️ *'),
              CustomField(setValue: (value) => weight = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Height🙆‍♂️ *'),
              CustomField(setValue: (value) => height = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Shoulders'),
              CustomField(setValue: (value) => shoulders = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Chest'),
              CustomField(setValue: (value) => chest = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Waist'),
              CustomField(setValue: (value) => waist = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Left Arm 💪'),
              CustomField(setValue: (value) => leftArm = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Right Arm 💪'),
              CustomField(setValue: (value) => rightArm = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Left Leg 🦵'),
              CustomField(setValue: (value) => leftLeg = value),
              SizedBox(height: height * 0.02),
              alignedText(theme, height, 'Right Leg 🦵'),
              CustomField(setValue: (value) => rightLeg = value),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: Text(
                      '* mandatory',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: width * 0.4,
                    margin: EdgeInsets.only(right: width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.rectangle,
                      borderRadius:
                          BorderRadius.all(Radius.circular(height / 38)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (firstName != "" &&
                            lastName != "" &&
                            measurementsParser() != null) {
                          UserStore store = UserStore();
                          ExerciseInfoDataStore exerciseInfoDataStore =
                              ExerciseInfoDataStore();
                          exerciseInfoDataStore.batchWrite();
                          store
                              .addBasicDetails(
                                userInfo: UserInformation(
                                  firstName: firstName,
                                  lastName: lastName,
                                  dateOfBirth: dateOfBirth,
                                  dateJoined: DateTime.now(),
                                  measurements: measurementsParser(),
                                ),
                              )
                              .then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return ShowCaseWidget(
                                        builder: (context) {
                                          return HomeView(
                                            action: actionProvider.currAction,
                                            userInformation: UserInformation(
                                              firstName: firstName,
                                              lastName: lastName,
                                              dateJoined: DateTime.now(),
                                              dateOfBirth: dateOfBirth,
                                              measurements: {},
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter valid values")),
                          );
                        }
                      },
                      child: Text(
                        'Next >>',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
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

  Align alignedText(ThemeData theme, double height, String text) {
    return Align(
      alignment: const AlignmentDirectional(-0.85, 0),
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: height * 0.02,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onBackground,
        ),
      ),
    );
  }

  Map<String, dynamic>? measurementsParser() {
    Map<String, dynamic>? result;

    result = {
      "chest": double.tryParse(chest),
      "height": double.tryParse(height),
      "leftArm": double.tryParse(leftArm),
      "leftLeg": double.tryParse(leftLeg),
      "rightArm": double.tryParse(rightArm),
      "rightLeg": double.tryParse(rightLeg),
      "shoulders": double.tryParse(shoulders),
      "waist": double.tryParse(waist),
      "weight": double.tryParse(weight),
    };

    return result;
  }
}
