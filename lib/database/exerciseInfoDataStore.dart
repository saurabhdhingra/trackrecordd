import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/exercise.dart';
import '../models/exerciseInfo.dart';
import '../models/userInfo.dart';
import 'exceptions.dart';

class ExerciseDataStore {
  final CollectionReference dataCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Exercise Information');

  Future<List<ExerciseInfo>> getAllExercises() async {
    try {
      List<ExerciseInfo> exercises = [];

      final querySnapshot = await dataCollection.orderBy('muscleGroup').get();

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

      final querySnapshotChest =
          await dataCollection.where('muscleGroup', isEqualTo: "Chest").get();
      final querySnapshotBack =
          await dataCollection.where('muscleGroup', isEqualTo: "Back").get();
      final querySnapshotShoulder = await dataCollection
          .where('muscleGroup', isEqualTo: "Shoulder")
          .get();
      final querySnapshotBicep =
          await dataCollection.where('muscleGroup', isEqualTo: "Bicep").get();
      final querySnapshotTricep =
          await dataCollection.where('muscleGroup', isEqualTo: "Tricep").get();
      final querySnapshotLegs =
          await dataCollection.where('muscleGroup', isEqualTo: "Legs").get();
      final querySnapshotCore =
          await dataCollection.where('muscleGroup', isEqualTo: "Core").get();

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
      final exerciseDocument = dataCollection.doc();
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
      final exerciseDocument = dataCollection.doc(id);
      await exerciseDocument.set(exercise.toJson());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to update exercise.', devDetails: '$error');
    }
  }

  Future<void> deleteExercise({required String id}) async {
    try {
      final exerciseDocument = dataCollection.doc(id);
      await exerciseDocument.delete();
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to delete exercise.', devDetails: '$error');
    }
  }
}
