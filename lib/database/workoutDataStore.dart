import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/exercise.dart';
import '../models/userInfo.dart';
import 'exceptions.dart';

class ExerciseDataStore {
  final CollectionReference dataCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Exercises');

  final CollectionReference workoutCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Workouts');

  Future<String> addExercise({required Exercise exercise}) async {
    try {
      final exerciseDocument = dataCollection.doc();
      await exerciseDocument.set(exercise.toJson());

      var data;
      await workoutCollection.doc(workoutId(DateTime.now())).get().then(
        (DocumentSnapshot doc) {
          if (doc.data() == null) {
            final workoutDocument =
                workoutCollection.doc(workoutId(DateTime.now()));
            workoutDocument.set();
          } else {
            data = doc.data() as Map<String, dynamic>;
            data["exercises"].add(exerciseDocument.id);
          }
        },
      );

      await workoutCollection.doc(workoutId(DateTime.now())).set(data);
      return exerciseDocument.id;
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<void> updateExercise(
      {required Exercise exercise, required String id}) async {
    try {
      final exerciseDocument = dataCollection.doc(id);
      await exerciseDocument.set(exercise.toJson());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<void> deleteExercise({required String id, required int index}) async {
    try {
      final exerciseDocument = dataCollection.doc(id);
      await exerciseDocument.delete();

      var data;
      await workoutCollection.doc(workoutId(DateTime.now())).get().then(
        (DocumentSnapshot doc) {
          data = doc.data() as Map<String, dynamic>;
          data["exercises"].removeAt(index);
        },
      );

      await workoutCollection.doc(workoutId(DateTime.now())).set(data);
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }
}

String workoutId(DateTime date) {
  return '${date.day}-${date.month}-${date.year}';
}
