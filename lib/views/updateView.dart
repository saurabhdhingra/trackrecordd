// import 'package:trackrecordd/screens/todayScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trackrecordd/utils/constants.dart';
// import 'package:trackrecord/database/db.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'dart:io' show Platform;

import 'package:trackrecordd/views/homeView.dart';
import 'package:trackrecordd/widgets/customField.dart';
import 'package:trackrecordd/widgets/submitButton.dart';

class UpdateView extends StatefulWidget {
  final String name;
  final String muscle;
  final List<Map> sets;

  const UpdateView(
      {Key? key, required this.name, required this.muscle, required this.sets})
      : super(key: key);

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  List<Map> sets = [];

  @override
  void initState() {
    sets = widget.sets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: width * 0.06,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.01),
              ...sets.map(
                (e) => setTile(height, width, sets.indexOf(e)),
              ),
              addButton(height, width),
              SizedBox(height: height * 0.01),
              SubmitButton(onSubmit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Divider divider(width) {
    return Divider(
        height: 0.01,
        thickness: 2,
        indent: width * 0.05,
        endIndent: width * 0.05);
  }

  SizedBox setTile(height, width, int index) {
    return SizedBox(
      height: height * 0.23,
      width: width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 0, 0, 0),
                child: Text(
                  "Set ${index + 1}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: height * 0.025),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, width * 0.05, 0),
                child: IconButton(
                  onPressed: () => setState(() {
                    sets.removeAt(index);
                  }),
                  icon: const Icon(CupertinoIcons.minus),
                ),
              ),
            ],
          ),
          CustomField(
            setValue: (value) => sets[index]["reps"] = value,
            unit: "reps",
          ),
          SizedBox(height: height * 0.02),
          CustomField(
            setValue: (value) => sets[index]["weight"] = value,
            unit: "kgs",
          ),
        ],
      ),
    );
  }

  GestureDetector addButton(height, width) {
    return GestureDetector(
      onTap: () => setState(() => sets.add({
            "weight": 0,
            "reps": 0,
          })),
      child: Container(
        width: width * 0.85,
        height: height * 0.08,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(235, 235, 235, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Row titleText(width) {
    return Row(
      children: [
        SizedBox(width: width * 0.05),
        Text(
          widget.name,
          style: TextStyle(
            fontSize: width * 0.06,
          ),
        ),
      ],
    );
  }
}
