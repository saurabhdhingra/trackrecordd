

import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class AddExercise extends ExerciseEvent {
  final String name;

  const AddExercise(this.name);

  @override
  List<Object> get props => [name];
}

class EditExercise extends ExerciseEvent {
  final int id;
  final String name;

  const EditExercise(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}

class RemoveExercise extends ExerciseEvent {
  final int id;

  const RemoveExercise(this.id);

  @override
  List<Object> get props => [id];
}
