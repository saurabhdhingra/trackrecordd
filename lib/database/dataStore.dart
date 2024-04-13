import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/exercise.dart';
import '../models/userInfo.dart';
import 'exceptions.dart';

class UserStore {
  final CollectionReference dataCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Exercises');

  final CollectionReference workoutCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Workouts');

  Future<void> addExercise({required Exercise exercise}) async {
    try {
      final exerciseDocument = dataCollection.doc();
      await exerciseDocument.set(exercise.toJson());

      var data;
      await workoutCollection.doc(workoutId(DateTime.now())).get().then(
        (DocumentSnapshot doc) {
          data = doc.data() as Map<String, dynamic>;
          data["exercises"].add(exerciseDocument.id);
        },
      );

      await workoutCollection.doc(workoutId(DateTime.now())).set(data);

    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<void> updateExercise({required Exercise exercise, required String id}) async {
     try {
      final exerciseDocument = dataCollection.doc(id);
      await exerciseDocument.set(exercise.toJson());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<void> deleteExercise({required String id, required int index}) async{
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

  Future<UserInfo?> getUserInformation({required String userId}) async {
    if (userId.isNotEmpty) {
      // final userDoc = await userCollection.doc(userId).get();

      if (!userDoc.exists) {
        return null;
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      return UserInfo.fromJson(userData);
    } else {
      throw FireStoreException(message: 'User ID passed is empty.');
    }
  }
}

String workoutId(DateTime date) {
  return '${date.day}-${date.month}-${date.year}';
}
