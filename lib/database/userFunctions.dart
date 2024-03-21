import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'exceptions.dart';

class UserStore {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser({required User user}) async {
    try {
      final userDocument = userCollection.doc(user.id);
      await userDocument.set(user.toJson());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to create new user', devDetails: '$error');
    }
  }

  Future<User?> getuser({required String userId}) async {
    if (userId.isNotEmpty) {
      final userDoc = await userCollection.doc(userId).get();

      if (!userDoc.exists) {
        return null;
      }

      final userData = userDoc.data()as Map<String, dynamic>;
      return User.fromJson(userData);
    }else{
      throw FireStoreException(message: 'User ID passed is empty.');

    }
  }
}
