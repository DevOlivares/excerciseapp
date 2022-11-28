import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/models/workout.dart';
import 'package:src/states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {

  WorkoutCubit() :super(const WorkoutInitial());

  editWorkout(Workout workout, int index){
  return  emit (WorkoutEditing(workout, index));


  }

}