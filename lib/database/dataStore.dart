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
