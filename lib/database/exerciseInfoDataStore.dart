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

  Future<void> batchWrite() async {
    try {
      var batch = FirebaseFirestore.instance.batch();

      intialExercisesArray.forEach((doc) {
        var docRef = exerciseInfoCollection.doc();
        batch.set(docRef, doc);
      });

      batch.commit();
    } catch (error) {}
  }

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

List<Map<String, String>> intialExercisesArray = [
  {"muscleGroup": "Chest", "name": "Bench Press"}
];

List<String> chest = [
  "Bench Press",
  "Board Press",
  "Cable Chest Press",
  "Close-Grip Bench Press",
  "Decline Bench Press",
  "Dumbbell Chest Fly",
  "Dumbbell Chest Press",
  "Dumbbell Decline Chest Press",
  "Dumbbell Floor Press",
  "Dumbbell Pullover",
  "Feet-Up Bench Press",
  "Floor Press",
  "Incline Bench Press",
  "Incline Dumbbell Press",
  "Incline Push-Up",
  "Kettlebell Floor Press",
  "Kneeling Incline Push-Up",
  "Machine Chest Fly",
  "Machine Chest Press",
  "Pec Deck",
  "Pin Bench Press",
  "Push-Up",
  "Push-Up Against Wall",
  "Push-Ups With Feet in Rings",
  "Resistance Band Chest Fly",
  "Smith Machine Bench Press",
  "Smith Machine Incline Bench Press",
  "Standing Cable Chest Fly",
  "Standing Resistance Band Chest Fly"
];

List shoulder = [
  "Band External Shoulder Rotation",
  "Band Internal Shoulder Rotation",
  "Band Pull-Apart",
  "Barbell Front Raise",
  "Barbell Rear Delt Row",
  "Barbell Upright Row",
  "Behind the Neck Press",
  "Cable Lateral Raise",
  "Cable Rear Delt Row",
  "Dumbbell Front Raise",
  "Dumbbell Horizontal Internal Shoulder Rotation",
  "Dumbbell Horizontal External Shoulder Rotation",
  "Dumbbell Lateral Raise",
  "Dumbbell Rear Delt Row",
  "Dumbbell Shoulder Press",
  "Face Pull",
  "Front Hold",
  "Lying Dumbbell External Shoulder Rotation",
  "Lying Dumbbell Internal Shoulder Rotation",
  "Machine Lateral Raise",
  "Machine Shoulder Press",
  "Monkey Row",
  "Overhead Press",
  "Plate Front Raise",
  "Power Jerk",
  "Push Press",
  "Reverse Cable Flyes",
  "Reverse Dumbbell Flyes",
  "Reverse Machine Fly",
  "Seated Dumbbell Shoulder Press",
  "Seated Barbell Overhead Press",
  "Seated Smith Machine Shoulder Press",
  "Snatch Grip Behind the Neck Press",
  "Squat Jerk",
  "Split Jerk"
];

List

https://www.strengthlog.com/exercise-directory/#Chest_Exercises