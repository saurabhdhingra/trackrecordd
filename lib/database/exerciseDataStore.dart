import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackrecordd/database/workoutDataStore.dart';
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
            workoutDocument.set({
              'date': DateTime.now(),
              'muscleGroups': [exercise.muscleGroup],
              'exercises': [exerciseDocument.id]
            });
          } else {
            data = doc.data() as Map<String, dynamic>;

            if (data["exercises"].length <= 10) {
              data["exercises"].add(exerciseDocument.id);
            } else {
              throw Exception("Can't add more than 10 exercises in a day.");
            }

            if (!data["muscleGroups"].contains(exercise.muscleGroup)) {
              data["muscleGroups"].add(exercise.muscleGroup);
            }
            workoutCollection.doc(workoutId(DateTime.now())).set(data);
          }
        },
      );

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

      await workoutCollection.doc(workoutId(DateTime.now())).get().then(
        (DocumentSnapshot doc) {
          var data = doc.data() as Map<String, dynamic>;

          if (!data["muscleGroups"].contains(exercise.muscleGroup)) {
            data["muscleGroups"].add(exercise.muscleGroup);
          }
          workoutCollection.doc(workoutId(DateTime.now())).set(data);
        },
      );
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to add user details', devDetails: '$error');
    }
  }

  Future<bool> deleteExercise(
      {required String id,
      required int index,
      required String muscleGroup}) async {
    try {
      bool isMuscleGroupRemoved = false;
      final exerciseDocument = dataCollection.doc(id);
      await exerciseDocument.delete();

      var data;
      await workoutCollection.doc(workoutId(DateTime.now())).get().then(
        (DocumentSnapshot doc) {
          data = doc.data() as Map<String, dynamic>;
          data["exercises"].removeAt(index);
        },
      );

      WorkoutDataStore workoutDataStore = WorkoutDataStore();
      await workoutDataStore
          .checkAndRemoveMuscleGroup(muscleGroup: muscleGroup)
          .then((value) {
        isMuscleGroupRemoved = value;
      });

      await workoutCollection.doc(workoutId(DateTime.now())).set(data);

      return isMuscleGroupRemoved;
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to delete this exercise', devDetails: '$error');
    }
  }

  Future<List<Map<String, dynamic>>> getBarChartData(
      String exerciseName) async {
    try {
      List<Map<String, dynamic>> result = [];

      Query exerciseQuery =
          dataCollection.where('name', isEqualTo: exerciseName);

      await exerciseQuery.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var data = docSnapshot.data() as Map<String, dynamic>;
          result.add({
            "date": barChartDate(data["date"].toDate()),
            "value": normalizedWorkDone(data["sets"])
          });
        }
      });

      return result;
    } catch (error) {
      throw FireStoreException(
          message: 'Failed to fetch bar chart data', devDetails: '$error');
    }
  }
}

String workoutId(DateTime date) {
  return '${date.day}-${date.month}-${date.year}';
}

double normalizedWorkDone(List sets) {
  double result = 0;
  for (Map set in sets) {
    result += double.parse(set["weight"]) * int.parse(set["reps"]);
  }
  return result;
}

String barChartDate(DateTime date) {
  return '${date.day}+\n${months[date.month - 1]}';
}

List months = [
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
];
