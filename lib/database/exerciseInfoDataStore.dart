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


List initialExercises = [
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
  {"muscleGroup": "Shoulders", "name": "Barbell Front Raise"},
  {"muscleGroup": "Shoulders", "name": "Barbell Rear Delt Row"},
  {"muscleGroup": "Shoulders", "name": "Barbell Upright Row"},
  {"muscleGroup": "Shoulders", "name": "Face Pull"},
  {"muscleGroup": "Shoulders", "name": "Front Hold"},
  {"muscleGroup": "Shoulders", "name": "Push Press"},
  {"muscleGroup": "Shoulders", "name": "Squat Jerk"},
  {"muscleGroup": "Shoulders", "name": "Split Jerk"},
  {"muscleGroup": "Biceps", "name": "Barbell Curl"},
  {"muscleGroup": "Biceps", "name": "Barbell Preacher Curl"},
  {"muscleGroup": "Biceps", "name": "Bodyweight Curl"},
  {"muscleGroup": "Biceps", "name": "Concentration Curl"},
  {"muscleGroup": "Biceps", "name": "Dumbbell Curl"},
  {"muscleGroup": "Biceps", "name": "Hammer Curl"},
  {"muscleGroup": "Biceps", "name": "Spider Curl"},
  {"muscleGroup": "Triceps", "name": "Barbell Standing Extension"},
  {"muscleGroup": "Triceps", "name": "Bench Dip"},
  {"muscleGroup": "Triceps", "name": "Overhead Cable Extension"},
  {"muscleGroup": "Triceps", "name": "Bodyweight Extension"},
  {"muscleGroup": "Triceps", "name": "Pushdown With Bar"},
  {"muscleGroup": "Triceps", "name": "Pushdown With Rope"},
  {"muscleGroup": "Back", "name": "Back Extension"},
  {"muscleGroup": "Back", "name": "Banded Muscle-Up"},
  {"muscleGroup": "Back", "name": "Chin-Up"},
  {"muscleGroup": "Back", "name": "Deadlift"},
  {"muscleGroup": "Back", "name": "Dumbbell Row"},
  {"muscleGroup": "Back", "name": "Dumbbell Shrug"},
  {"muscleGroup": "Back", "name": "Floor Back Extension"},
  {"muscleGroup": "Back", "name": "Power Clean"},
  {"muscleGroup": "Back", "name": "Power Snatch"},
  {"muscleGroup": "Back", "name": "Pull-Up"},
  {"muscleGroup": "Back", "name": "Rack Pull"},
  {"muscleGroup": "Back", "name": "Sumo Deadlift"},
  {"muscleGroup": "Core", "name": "Ball Slams"},
  {"muscleGroup": "Core", "name": "Cable Crunch"},
  {"muscleGroup": "Core", "name": "Crunch"},
  {"muscleGroup": "Core", "name": "Hanging Knee Raise"},
  {"muscleGroup": "Core", "name": "Hanging Leg Raise"},
  {"muscleGroup": "Core", "name": "Hanging Sit-Up"},
  {"muscleGroup": "Core", "name": "Kneeling Plank"},
  {"muscleGroup": "Core", "name": "Kneeling Side Plank"},
  {"muscleGroup": "Core", "name": "Lying Leg Raise"},
  {"muscleGroup": "Legs", "name": "Barbell Lunge"},
  {"muscleGroup": "Legs", "name": "Barbell Walking Lunge"},
  {"muscleGroup": "Legs", "name": "Leg Extension"},
  {"muscleGroup": "Legs", "name": "Leg Press"},
  {"muscleGroup": "Legs", "name": "Romanian Deadlift"},
  {"muscleGroup": "Legs", "name": "Seated Leg Curl"},
  {"muscleGroup": "Legs", "name": "Squat"},
  {"muscleGroup": "Legs", "name": "Step Up"},
];
