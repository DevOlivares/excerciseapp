import 'package:equatable/equatable.dart';

import 'exercise.dart';

class Workout extends Equatable{
  final String? title;
  final List<Exercise> exercises;
  const Workout({required this.exercises, required  this.title});
  factory Workout.fromJson(Map<String, dynamic> json){
    List<Exercise> exercises=[];
    int index = 0;
    int startTime = 0;
    for(var ex in (json['exercises'] as Iterable)){
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      print(".....$index....");
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(exercises: exercises, title:  json['title'] as String);
  }
  Map<String, dynamic> toJson()=>{'title':title, 'exercises':exercises};
  copyWith({String? title})=> Workout(title: title??this.title,exercises: exercises);

  int getTotal() =>
      exercises.fold(0,(prev,ex)=>prev+ex.duration!+ex.prelude!);

  Exercise getCurrentExercise(int? elapsed)=>
  // last smalled element object
      exercises.lastWhere((element) => element.startTime!<=elapsed!);

  @override
  // TODO: implement props
  List<Object?> get props => [title, exercises];

  @override
  bool get stringify => true;
}