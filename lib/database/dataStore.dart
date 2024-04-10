import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/exercise.dart';
import '../models/userInfo.dart';
import 'exceptions.dart';

class UserStore {
  final CollectionReference dataCollection = FirebaseFirestore.instance
      .collection('')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Exercises');
  final DocumentReference workout = FirebaseFirestore.instance.collection('Workouts').doc(FirebaseAuth.instance.currentUser?.uid).collection('Workouts').
  Future<void> addExercise({required Exercise exercise}) async {
    try {
      final exerciseDocument = dataCollection.doc();

      await userDocument.set(exercise.toFirestore());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<UserInfo?> getUserInformation({required String userId}) async {
    if (userId.isNotEmpty) {
      final userDoc = await userCollection.doc(userId).get();

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
