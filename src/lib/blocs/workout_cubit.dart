import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/models/workout.dart';
import 'package:src/states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {

  WorkoutCubit() :super(const WorkoutInitial());

  editWorkout(Workout workout, int index)
    => emit(WorkoutEditing(workout,index, null));

  editExercise(int? exIndex) {
    print ("my exercise index is $exIndex");
    emit(WorkoutEditing(state.workout,(state as WorkoutEditing).index, exIndex));
  }

  goHome() => emit(const WorkoutInitial());

}