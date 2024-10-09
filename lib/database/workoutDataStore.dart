import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackrecordd/models/workout.dart';
import 'package:trackrecordd/models/workoutDetailed.dart';
import '../models/exercise.dart';
import '../models/userInfo.dart';
import 'exceptions.dart';

class WorkoutDataStore {
  final CollectionReference dataCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Exercises');

  final CollectionReference workoutCollection = FirebaseFirestore.instance
      .collection('User Information')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Workouts');

  Future<Map<String, dynamic>> getWorkoutDetails(
      {required DateTime date}) async {
    try {
      var data;
      WorkoutDetails result =
          WorkoutDetails(date: date, muscleGroups: [], exercises: []);

      Workout metaData = Workout(date: date, muscleGroups: [], exercises: []);

      await workoutCollection.doc(workoutId(date)).get().then(
        (DocumentSnapshot doc) async {
          if (doc.data() != null) {
            data = doc.data() as Map<String, dynamic>;
            var array = data["exercises"];
            List<String> exerciseIds = List<String>.from(array);
            List<Exercise> exerciseDetails = [];
            await dataCollection
                .where(FieldPath.documentId, whereIn: exerciseIds)
                .orderBy('date', descending: false)
                .get()
                .then(
              (querySnapshot) {
                for (var docSnapshot in querySnapshot.docs) {
                  var exerciseJson = docSnapshot.data() as Map<String, dynamic>;
                  exerciseDetails.add(Exercise.fromJson(exerciseJson));
                }
              },
              onError: (e) => print('Error completing: $e'),
            );

            var muscleArray = data["muscleGroups"];
            Set<String> muscleGroupRes = Set<String>.from(muscleArray);

            result = WorkoutDetails.fromJson({
              "date": data["date"],
              "exercises": exerciseDetails,
              "muscleGroups": muscleGroupRes.toList()
            });

            metaData = Workout.fromJson(data);
          }
        },
      );

      return {"details": result, "metaData": metaData};
    } catch (error) {
      print(error);
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<bool> checkAndRemoveMuscleGroup({required String muscleGroup}) async {
    try {
      bool isMuscleGroupRemoved = false;
      int muscleGroupCount = 0;
      List<String> exerciseIds = [];

      var data;
      await workoutCollection.doc(workoutId(DateTime.now())).get().then(
        (DocumentSnapshot doc) async {
          data = doc.data() as Map<String, dynamic>;
          var array = data["exercises"];
          exerciseIds = List<String>.from(array);

          await dataCollection
              .where(FieldPath.documentId, whereIn: exerciseIds)
              .orderBy('date', descending: false)
              .get()
              .then(
            (querySnapshot) {
              for (var docSnapshot in querySnapshot.docs) {
                var exerciseJson = docSnapshot.data() as Map<String, dynamic>;
                if (exerciseJson["muscleGroup"] == muscleGroup)
                  muscleGroupCount++;
              }
            },
            onError: (e) => print('Error completing: $e'),
          );
        },
      );

      if (muscleGroupCount < 2) {
        data["muscleGroups"]
            .removeAt(data["muscleGroups"].indexOf(muscleGroup));
        await updateWorkout(
            workout: Workout.fromJson(data), id: workoutId(DateTime.now()));
        isMuscleGroupRemoved = true;
      }

      if (exerciseIds.length == 1) {
        await deleteWorkout(id: workoutId(DateTime.now()));
      }

      return isMuscleGroupRemoved;
    } catch (error) {
      print(error);
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<Map<String, dynamic>> getWorkoutList({
    int limit = 15,
    DocumentSnapshot<Object?>? startAfterDoc,
  }) async {
    try {
      final query =
          workoutCollection.orderBy('date', descending: true).limit(limit);

      final querySnapshot = startAfterDoc != null
          ? await query.startAfterDocument(startAfterDoc).get()
          : await query.get();

      List<Workout> workouts = [];

      DocumentSnapshot? lastDoc;

      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var workoutJson = querySnapshot.docs[i].data() as Map<String, dynamic>;
        workouts.add(Workout.fromJson(workoutJson));
        if (i == querySnapshot.docs.length - 1) {
          lastDoc = querySnapshot.docs[i];
        }
      }
      return {
        "list": workouts,
        "limit": workouts.length < limit,
        "lastDoc": lastDoc
      };
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

  Future<void> deleteWorkout({required String id}) async {
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
  print('${date.day}-${date.month}-${date.year}');
  return '${date.day}-${date.month}-${date.year}';
}
