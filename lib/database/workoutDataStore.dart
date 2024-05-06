import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackrecordd/models/workout.dart';
import 'package:trackrecordd/models/workoutDetailed.dart';
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

  Future<WorkoutDetails> getWorkoutDetails({required DateTime date}) async {
    try {
      var data;
      WorkoutDetails result =
          WorkoutDetails(date: date, muscleGroups: [], exercises: []);

      await workoutCollection.doc(workoutId(DateTime.now())).get().then(
        (DocumentSnapshot doc) {
          if (doc.data() != null) {
            data = doc.data() as Map<String, dynamic>;
            List<String> exerciseIds = data["exercises"] as List<String>;
            List<Exercise> exerciseDetails = [];
            dataCollection
                .where(FieldPath.documentId, whereIn: exerciseIds)
                .get()
                .then(
              (querySnapshot) {
                print("Successfully completed");
                for (var docSnapshot in querySnapshot.docs) {
                  var exerciseJson = docSnapshot.data() as Map<String, dynamic>;
                  exerciseDetails.add(Exercise.fromJson(exerciseJson));
                }
              },
              onError: (e) => print('Error completing: $e'),
            );

            result = WorkoutDetails(
                date: date,
                muscleGroups: data["muscleGroups"],
                exercises: exerciseDetails);
          }
        },
      );

      return result;
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<List<Workout>> getWorkoutList({
    int limit = 15,
    DocumentSnapshot<Object?>? startAfterDoc,
  }) async {
    try {
      final query =
          workoutCollection.orderBy('date', descending: false).limit(limit);

      final querySnapshot = startAfterDoc != null
          ? await query.startAfterDocument(startAfterDoc).get()
          : await query.get();

      List<Workout> workouts = [];

      for (var docSnapshot in querySnapshot.docs) {
        var workoutJson = docSnapshot.data() as Map<String, dynamic>;
        workouts.add(Workout.fromJson(workoutJson));
      }
      return workouts;
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<void> updateWorkout(
      {required Workout workout, required String id}) async {
    try {
      final workoutDocument = workoutCollection.doc(id);
      await workoutDocument.set(workout.toFirestore());
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<void> deleteWorkout({required String id, required int index}) async {
    try {
      final workoutDocument = dataCollection.doc(id);
      await workoutDocument.delete();
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to delete workout. Please try again.',
          devDetails: '$error');
    }
  }
}

String workoutId(DateTime date) {
  return '${date.day}-${date.month}-${date.year}';
}
