import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/exercise.dart';
import '../models/exerciseInfo.dart';
import '../models/userInfo.dart';
import 'exceptions.dart';

class ExerciseDataStore {
  final CollectionReference exerciseInfoCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Exercise Information');

  Future<List<ExerciseInfo>> getAllExercises() async {
    try {
      List<ExerciseInfo> exercises = [];

      final querySnapshot =
          await exerciseInfoCollection.orderBy('muscleGroup').get();

      for (var docSnapshot in querySnapshot.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        exercises.add(ExerciseInfo.fromJson(workoutJson));
      }
      return exercises;
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add exercise', devDetails: '$error');
    }
  }

  // Future<void> batchWrite() async {
  //   try {
  //     var batch = FirebaseFirestore.instance.batch();

  //     intialExercisesArray.forEach((doc) {
  //       var docRef = exerciseInfoCollection.doc();
  //       batch.set(docRef, doc);
  //     });

  //     batch.commit();
  //   } catch (error) {}
  // }

  Future<Map<String, List<ExerciseInfo>>> getSortedExercises() async {
    try {
      List<ExerciseInfo> chestExercises = [];
      List<ExerciseInfo> backExercises = [];
      List<ExerciseInfo> shoulderExercises = [];
      List<ExerciseInfo> bicepExercises = [];
      List<ExerciseInfo> tricepExercises = [];
      List<ExerciseInfo> legsExercises = [];
      List<ExerciseInfo> coreExercises = [];

      final querySnapshotChest = await exerciseInfoCollection
          .where('muscleGroup', isEqualTo: "Chest")
          .get();
      final querySnapshotBack = await exerciseInfoCollection
          .where('muscleGroup', isEqualTo: "Back")
          .get();
      final querySnapshotShoulder = await exerciseInfoCollection
          .where('muscleGroup', isEqualTo: "Shoulder")
          .get();
      final querySnapshotBicep = await exerciseInfoCollection
          .where('muscleGroup', isEqualTo: "Bicep")
          .get();
      final querySnapshotTricep = await exerciseInfoCollection
          .where('muscleGroup', isEqualTo: "Tricep")
          .get();
      final querySnapshotLegs = await exerciseInfoCollection
          .where('muscleGroup', isEqualTo: "Legs")
          .get();
      final querySnapshotCore = await exerciseInfoCollection
          .where('muscleGroup', isEqualTo: "Core")
          .get();

      for (var docSnapshot in querySnapshotChest.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        chestExercises.add(ExerciseInfo.fromJson(workoutJson));
      }
      for (var docSnapshot in querySnapshotBack.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        backExercises.add(ExerciseInfo.fromJson(workoutJson));
      }
      for (var docSnapshot in querySnapshotShoulder.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        shoulderExercises.add(ExerciseInfo.fromJson(workoutJson));
      }
      for (var docSnapshot in querySnapshotBicep.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        bicepExercises.add(ExerciseInfo.fromJson(workoutJson));
      }
      for (var docSnapshot in querySnapshotTricep.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        tricepExercises.add(ExerciseInfo.fromJson(workoutJson));
      }
      for (var docSnapshot in querySnapshotLegs.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        legsExercises.add(ExerciseInfo.fromJson(workoutJson));
      }
      for (var docSnapshot in querySnapshotCore.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        coreExercises.add(ExerciseInfo.fromJson(workoutJson));
      }

      return {
        'chest': chestExercises,
        'back': backExercises,
        'shoulder': shoulderExercises,
        'bicep': bicepExercises,
        'tricep': tricepExercises,
        'legs': legsExercises,
        'core': coreExercises
      };
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add exercise', devDetails: '$error');
    }
  }

  Future<String> addExercise({required ExerciseInfo exercise}) async {
    try {
      final exerciseDocument = exerciseInfoCollection.doc();
      await exerciseDocument.set(exercise.toJson());

      return exerciseDocument.id;
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add exercise', devDetails: '$error');
    }
  }

  Future<void> updateExercise(
      {required ExerciseInfo exercise, required String id}) async {
    try {
      final exerciseDocument = exerciseInfoCollection.doc(id);
      await exerciseDocument.set(exercise.toJson());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to update exercise.', devDetails: '$error');
    }
  }

  Future<void> deleteExercise({required String id}) async {
    try {
      final exerciseDocument = exerciseInfoCollection.doc(id);
      await exerciseDocument.delete();
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to delete exercise.', devDetails: '$error');
    }
  }
}

void intialExercisesArray() {
  List<Map<String, dynamic>> result = [];

  for (String item in chest) {
    result.add({"muscleGroup": "Chest", "name": item});
  }
  for (String item in shoulder) {
    result.add({"muscleGroup": "Shoulders", "name": item});
  }
  for (String item in back) {
    result.add({"muscleGroup": "Back", "name": item});
  }
  for (String item in core) {
    result.add({"muscleGroup": "Core", "name": item});
  }
  for (String item in legs) {
    result.add({"muscleGroup": "Legs", "name": item});
  }
  for (String item in bicep) {
    result.add({"muscleGroup": "Biceps", "name": item});
  }
  for (String item in tricep) {
    result.add({"muscleGroup": "Triceps", "name": item});
  }

  log(result as String);
}

List chest = [
  {"muscleGroup": "Chest", "name": "Bench Press"},
  {"muscleGroup": "Chest", "name": "Dumbbell Chest Fly"},
  {"muscleGroup": "Chest", "name": "Dumbbell Pullover"},
  {"muscleGroup": "Chest", "name": "Incline Bench Press"},
  {"muscleGroup": "Chest", "name": "Incline Dumbbell Press"},
  {"muscleGroup": "Chest", "name": "Incline Push-Up"},
  {"muscleGroup": "Chest", "name": "Kettlebell Floor Press"},
  {"muscleGroup": "Chest", "name": "Pec Deck"},
  {"muscleGroup": "Chest", "name": "Pin Bench Press"},
  {"muscleGroup": "Chest", "name": "Push-Up"},
];

List shoulder = [
  "Barbell Front Raise",
  "Barbell Rear Delt Row",
  "Barbell Upright Row",
  "Face Pull",
  "Front Hold",
  "Push Press",
  "Squat Jerk",
  "Split Jerk"
];

List bicep = [
  "Barbell Curl",
  "Barbell Preacher Curl",
  "Bodyweight Curl",
  "Concentration Curl",
  "Dumbbell Curl",
  "Hammer Curl",
  "Spider Curl"
];

List tricep = [
  "Barbell Standing Extension",
  "Bench Dip",
  "Overhead Cable Extension",
  "Bodyweight Extension",
  "Pushdown With Bar",
  "Pushdown With Rope"
];

List back = [
  "Back Extension",
  "Banded Muscle-Up",
  "Barbell Row",
  "Barbell Shrug",
  "Block Clean",
  "Block Snatch",
  "Chin-Up",
  "Clean",
  "Clean and Jerk",
  "Deadlift",
  "Deficit Deadlift",
  "Dumbbell Deadlift",
  "Dumbbell Row",
  "Dumbbell Shrug",
  "Floor Back Extension",
  "Good Morning",
  "Hang Clean",
  "Muscle-Up (Bar)",
  "Muscle-Up (Rings)",
  "Pause Deadlift",
  "Pendlay Row",
  "Power Clean",
  "Power Snatch",
  "Pull-Up",
  "Rack Pull",
  "Ring Pull-Up",
  "Ring Row",
  "Seal Row",
  "Sumo Deadlift"
];

List core = [
  " Ball Slams",
  "Cable Crunch",
  "Crunch",
  "Dead Bug",
  "Hanging Knee Raise",
  "Hanging Leg Raise",
  "Hanging Sit-Up",
  "High to Low Wood Chop with Band",
  "Horizontal Wood Chop with Band",
  "Kneeling Ab Wheel Roll-Out",
  "Kneeling Plank",
  "Kneeling Side Plank",
  "Lying Leg Raise",
  "Lying Windshield Wiper"
];

List legs = [
  "Air Squat",
  "Barbell Hack Squat",
  "Barbell Lunge",
  "Barbell Walking Lunge",
  "Belt Squat",
  "Body Weight Lunge",
  "Bodyweight Leg Curl",
  "Box Squat",
  "Bulgarian Split Squat",
  "Chair Squat",
  "Dumbbell Lunge",
  "Dumbbell Squat",
  "Front Squat",
  "Goblet Squat",
  "Hack Squat Machine",
  "Half Air Squat",
  "Hip Adduction Machine",
  "Jumping Lunge",
  "Landmine Hack Squat",
  "Landmine Squat",
  "Leg Curl On Ball",
  "Leg Extension",
  "Leg Press",
  "Lying Leg Curl",
  "Nordic Hamstring Eccentric",
  "Pause Squat",
  "Reverse Barbell Lunge",
  "Romanian Deadlift",
  "Safety Bar Squat",
  "Seated Leg Curl",
  "Shallow Body Weight Lunge",
  "Side Lunges (Bodyweight)",
  "Smith Machine Squat",
  "Squat",
  "Step Up",
  "Zercher Squat"
];


// List initialExercises = [{"muscleGroup": "Chest", "name": "Bench Press"}, {"muscleGroup": "Chest", "name": "Board Press"}, {muscleGroup: Chest, name: Cable Chest Press}, {muscleGroup: Chest, name: Close-Grip Bench Press}, {muscleGroup: Chest, name: Decline Bench Press}, {muscleGroup: Chest, name: Dumbbell Chest Fly}, {muscleGroup: Chest, name: Dumbbell Chest Press}, {muscleGroup: Chest, name: Dumbbell Decline Chest Press}, {muscleGroup: Chest, name: Dumbbell Floor Press}, {muscleGroup: Chest, name: Dumbbell Pullover}, {muscleGroup: Chest, name: Feet-Up Bench Press}, {muscleGroup: Chest, name: Floor Press}, {muscleGroup: Chest, name: Incline Bench Press}, {muscleGroup: Chest, name: Incline Dumbbell Press}, {muscleGroup: Chest, name: Incline Push-Up}, {muscleGroup: Chest, name: Kettlebell Floor Press}, {muscleGroup: Chest, name: Kneeling Incline Push-Up}, {muscleGroup: Chest, name: Machine Chest Fly}, {muscleGroup: Chest, name: Machine Chest Press}, {muscleGroup: Chest, name: Pec Deck}, {muscleGroup: Chest, name: Pin Bench Press}, {muscleGroup: Chest, name: Push-Up}, {muscleGroup: Chest, name: Push-Up Against Wall}, {muscleGroup: Chest, name: Push-Ups With Feet in Rings}, {muscleGroup: Chest, name: Resistance Band Chest Fly}, {muscleGroup: Chest, name: Smith Machine Bench Press}, {muscleGroup: Chest, name: Smith Machine Incline Bench Press}, {muscleGroup: Chest, name: Standing Cable Chest Fly}, {muscleGroup: Chest, name: Standing Resistance Band Chest Fly}, {muscleGroup: Shoulders, name: Band External Shoulder Rotation}, {muscleGroup: Shoulders, name: Band Internal Shoulder Rotation}, {muscleGroup: Shoulders, name: Band Pull-Apart}, {muscleGroup: Shoulders, name: Barbell Front Raise}, {muscleGroup: Shoulders, name: Barbell Rear Delt Row}, {muscleGroup: Shoulders, name: Barbell Upright Row}, {muscleGroup: Shoulders, name: Behind the Neck Press}, {muscleGroup: Shoulders, name: Cable Lateral Raise}, {muscleGroup: Shoulders, name: Cable Rear Delt Row}, {muscleGroup: Shoulders, name: Dumbbell Front Raise}, {muscleGroup: Shoulders, name: Dumbbell Horizontal Internal Shoulder Rotation}, {muscleGroup: Shoulders, name: Dumbbell Horizontal External Shoulder Rotation}, {muscleGroup: Shoulders, name: Dumbbell Lateral Raise}, {muscleGroup: Shoulders, name: Dumbbell Rear Delt Row}, {muscleGroup: Shoulders, name: Dumbbell Shoulder Press}, {muscleGroup: Shoulders, name: Face Pull}, {muscleGroup: Shoulders, name: Front Hold}, {muscleGroup: Shoulders, name: Lying Dumbbell External Shoulder Rotation}, {muscleGroup: Shoulders, name: Lying Dumbbell Internal Shoulder Rotation}, {muscleGroup: Shoulders, name: Machine Lateral Raise}, {muscleGroup: Shoulders, name: Machine Shoulder Press}, {muscleGroup: Shoulders, name: Monkey Row}, {muscleGroup: Shoulders, name: Overhead Press}, {muscleGroup: Shoulders, name: Plate Front Raise}, {muscleGroup: Shoulders, name: Power Jerk}, {muscleGroup: Shoulders, name: Push Press}, {muscleGroup: Shoulders, name: Reverse Cable Flyes}, {muscleGroup: Shoulders, name: Reverse Dumbbell Flyes}, {muscleGroup: Shoulders, name: Reverse Machine Fly}, {muscleGroup: Shoulders, name: Seated Dumbbell Shoulder Press}, {muscleGroup: Shoulders, name: Seated Barbell Overhead Press}, {muscleGroup: Shoulders, name: Seated Smith Machine Shoulder Press}, {muscleGroup: Shoulders, name: Snatch Grip Behind the Neck Press}, {muscleGroup: Shoulders, name: Squat Jerk}, {muscleGroup: Shoulders, name: Split Jerk}, {muscleGroup: Back, name: Assisted Chin-Up}, {muscleGroup: Back, name: Assisted Pull-Up}, {muscleGroup: Back, name: Back Extension}, {muscleGroup: Back, name: Banded Muscle-Up}, {muscleGroup: Back, name: Barbell Row}, {muscleGroup: Back, name: Barbell Shrug}, {muscleGroup: Back, name: Block Clean}, {muscleGroup: Back, name: Block Snatch}, {muscleGroup: Back, name: Cable Close Grip Seated Row}, {muscleGroup: Back, name: Cable Wide Grip Seated Row}, {muscleGroup: Back, name: Chin-Up}, {muscleGroup: Back, name: Clean}, {muscleGroup: Back, name: Clean and Jerk}, {muscleGroup: Back, name: Deadlift}, {muscleGroup: Back, name: Deficit Deadlift}, {muscleGroup: Back, name: Dumbbell Deadlift}, {muscleGroup: Back, name: Dumbbell Row}, {muscleGroup: Back, name: Dumbbell Shrug}, {muscleGroup: Back, name: Floor Back Extension}, {muscleGroup: Back, name: Good Morning}, {muscleGroup: Back, name: Hang Clean}, {muscleGroup: Back, name: Hang Power Clean}, {muscleGroup: Back, name: Hang Power Snatch}, {muscleGroup: Back, name: Hang Snatch}, {muscleGroup: Back, name: Inverted Row}, {muscleGroup: Back, name: Inverted Row with Underhand Grip}, {muscleGroup: Back, name: Jefferson Curl}, {muscleGroup: Back, name: Jumping Muscle-Up}, {muscleGroup: Back, name: Kettlebell Swing}, {muscleGroup: Back, name: Lat Pulldown With Pronated Grip}, {muscleGroup: Back, name: Lat Pulldown With Supinated Grip}, {muscleGroup: Back, name: Muscle-Up (Bar)}, {muscleGroup: Back, name: Muscle-Up (Rings)}, {muscleGroup: Back, name: One-Handed Cable Row}, {muscleGroup: Back, name: One-Handed Lat Pulldown}, {muscleGroup: Back, name: Pause Deadlift}, {muscleGroup: Back, name: Pendlay Row}, {muscleGroup: Back, name: Power Clean}, {muscleGroup: Back, name: Power Snatch}, {muscleGroup: Back, name: Pull-Up}, {muscleGroup: Back, name: Pull-Up With a Neutral Grip}, {muscleGroup: Back, name: Rack Pull}, {muscleGroup: Back, name: Ring Pull-Up}, {muscleGroup: Back, name: Ring Row}, {muscleGroup: Back, name: Seal Row}, {muscleGroup: Back, name: Seated Machine Row}, {muscleGroup: Back, name: Snatch}, {muscleGroup: Back, name: Snatch Grip Deadlift}, {muscleGroup: Back, name: Stiff-Legged Deadlift}, {muscleGroup: Back, name: Straight Arm Lat Pulldown}, {muscleGroup: Back, name: Sumo Deadlift}, {muscleGroup: Core, name:  Ball Slams}, {muscleGroup: Core, name: Cable Crunch}, {muscleGroup: Core, name: Crunch}, {muscleGroup: Core, name: Dead Bug}, {muscleGroup: Core, name: Hanging Knee Raise}, {muscleGroup: Core, name: Hanging Leg Raise}, {muscleGroup: Core, name: Hanging Sit-Up}, {muscleGroup: Core, name: High to Low Wood Chop with Band}, {muscleGroup: Core, name: Horizontal Wood Chop with Band}, {muscleGroup: Core, name: Kneeling Ab Wheel Roll-Out}, {muscleGroup: Core, name: Kneeling Plank}, {muscleGroup: Core, name: Kneeling Side Plank}, {muscleGroup: Core, name: Lying Leg Raise}, {muscleGroup: Core, name: Lying Windshield Wiper}, {muscleGroup: Legs, name: Air Squat}, {muscleGroup: Legs, name: Barbell Hack Squat}, {muscleGroup: Legs, name: Barbell Lunge}, {muscleGroup: Legs, name: Barbell Walking Lunge}, {muscleGroup: Legs, name: Belt Squat}, {muscleGroup: Legs, name: Body Weight Lunge}, {muscleGroup: Legs, name: Bodyweight Leg Curl}, {muscleGroup: Legs, name: Box Squat}, {muscleGroup: Legs, name: Bulgarian Split Squat}, {muscleGroup: Legs, name: Chair Squat}, {muscleGroup: Legs, name: Dumbbell Lunge}, {muscleGroup: Legs, name: Dumbbell Squat}, {muscleGroup: Legs, name: Front Squat}, {muscleGroup: Legs, name: Goblet Squat}, {muscleGroup: Legs, name: Hack Squat Machine}, {muscleGroup: Legs, name: Half Air Squat}, {muscleGroup: Legs, name: Hip Adduction Machine}, {muscleGroup: Legs, name: Jumping Lunge}, {muscleGroup: Legs, name: Landmine Hack Squat}, {muscleGroup: Legs, name: Landmine Squat}, {muscleGroup: Legs, name: Leg Curl On Ball}, {muscleGroup: Legs, name: Leg Extension}, {muscleGroup: Legs, name: Leg Press}, {muscleGroup: Legs, name: Lying Leg Curl}, {muscleGroup: Legs, name: Nordic Hamstring Eccentric}, {muscleGroup: Legs, name: Pause Squat}, {muscleGroup: Legs, name: Reverse Barbell Lunge}, {muscleGroup: Legs, name: Romanian Deadlift}, {muscleGroup: Legs, name: Safety Bar Squat}, {muscleGroup: Legs, name: Seated Leg Curl}, {muscleGroup: Legs, name: Shallow Body Weight Lunge}, {muscleGroup: Legs, name: Side Lunges (Bodyweight)}, {muscleGroup: Legs, name: Smith Machine Squat}, {muscleGroup: Legs, name: Squat}, {muscleGroup: Legs, name: Step Up}, {muscleGroup: Legs, name: Zercher Squat}, {muscleGroup: Biceps, name: Barbell Curl}, {muscleGroup: Biceps, name: Barbell Preacher Curl}, {muscleGroup: Biceps, name: Bodyweight Curl}, {muscleGroup: Biceps, name: Cable Curl With Bar}, {muscleGroup: Biceps, name: Cable Curl With Rope}, {muscleGroup: Biceps, name: Concentration Curl}, {muscleGroup: Biceps, name: Dumbbell Curl}, {muscleGroup: Biceps, name: Dumbbell Preacher Curl}, {muscleGroup: Biceps, name: Hammer Curl}, {muscleGroup: Biceps, name: Incline Dumbbell Curl}, {muscleGroup: Biceps, name: Machine Bicep Curl}, {muscleGroup: Biceps, name: Spider Curl}, {muscleGroup: Triceps, name: Barbell Standing Triceps Extension}, {muscleGroup: Triceps, name: Barbell Lying Triceps Extension}, {muscleGroup: Triceps, name: Bench Dip}, {muscleGroup: Triceps, name: Close-Grip Push-Up}, {muscleGroup: Triceps, name: Dumbbell Lying Triceps Extension}, {muscleGroup: Triceps, name: Dumbbell Standing Triceps Extension}, {muscleGroup: Triceps, name: Overhead Cable Triceps Extension}, {muscleGroup: Triceps, name: Tricep Bodyweight Extension}, {"muscleGroup": "Triceps", "name": "Tricep Pushdown With Bar"}, {"muscleGroup": "Triceps", "name": "Tricep Pushdown With Rope"}];
