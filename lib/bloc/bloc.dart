
import 'package:bloc/bloc.dart';
import 'events.dart';
import 'states.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseInitial());

  @override
  Stream<ExerciseState> _mapEventToState(ExerciseEvent event) async* {
    if (event is AddExercise) {
      yield* _mapAddExerciseToState(event);
    } else if (event is EditExercise) {
      yield* _mapEditExerciseToState(event);
    } else if (event is RemoveExercise) {
      yield* _mapRemoveExerciseToState(event);
    }
  }

  Stream<ExerciseState> _mapAddExerciseToState(AddExercise event) async* {
    if (state is ExerciseLoadSuccess) {
      final List<Exercise> updatedExercises =
          List.from((state as ExerciseLoadSuccess).exercises)
            ..add(Exercise(id: DateTime.now().millisecondsSinceEpoch, name: event.name));
      yield ExerciseLoadSuccess(updatedExercises);
    }
  }

  Stream<ExerciseState> _mapEditExerciseToState(EditExercise event) async* {
    if (state is ExerciseLoadSuccess) {
      final List<Exercise> updatedExercises = (state as ExerciseLoadSuccess)
          .exercises
          .map((exercise) =>
              exercise.id == event.id ? Exercise(id: event.id, name: event.name) : exercise)
          .toList();
      yield ExerciseLoadSuccess(updatedExercises);
    }
  }

  Stream<ExerciseState> _mapRemoveExerciseToState(RemoveExercise event) async* {
    if (state is ExerciseLoadSuccess) {
      final List<Exercise> updatedExercises = (state as ExerciseLoadSuccess)
          .exercises
          .where((exercise) => exercise.id != event.id)
          .toList();
      yield ExerciseLoadSuccess(updatedExercises);
    }
  }
}
