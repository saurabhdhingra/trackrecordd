import 'package:equatable/equatable.dart';

class Exercise {
  final int id;
  final String name;

  Exercise({required this.id, required this.name});
}

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoadInProgress extends ExerciseState {}

class ExerciseLoadSuccess extends ExerciseState {
  final List<Exercise> exercises;

  const ExerciseLoadSuccess([this.exercises = const []]);

  @override
  List<Object> get props => [exercises];
}

class ExerciseLoadFailure extends ExerciseState {}
