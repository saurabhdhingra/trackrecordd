import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/userInfo.dart';
import 'exceptions.dart';

class UserStore {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User Information');

  Future<void> addBasicDetails({required UserInformation userInfo}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    try {
      final userDocument = userCollection.doc(user?.uid);
      await userDocument.set(userInfo.toJson());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<UserInformation?> getUserInformation({required String userId}) async {
    if (userId.isNotEmpty) {
      final userDoc = await userCollection.doc(userId).get();

      if (!userDoc.exists) {
        print("User Doc doesn't exist.");
        return null;
      }

      final userData = userDoc.data() as Map<String, dynamic>;

      return UserInformation.fromJson(userData);
    } else {
      throw FireStoreException(message: 'User ID passed is empty.');
    }
  }
}
