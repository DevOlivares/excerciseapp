import 'dart:convert';
import 'package:excerciseapp/model/workout.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsCubit extends Cubit <List <Workout>> {
WorkoutsCubit():super([]);


  getWorkouts() async {
final List<Workout> workouts = [];
final workoutsJson =  jsonDecode(await rootBundle.loadString("assets/workouts.json"));
for (var el in (workoutsJson as Iterable)){
workouts.add(Workout.fromJson(el));
}
emit(workouts);
  }
}