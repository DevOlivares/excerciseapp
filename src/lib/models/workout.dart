import 'exercise.dart';

class Workout {
  final String? title;
  final List<Exercise> exercises;
  const Workout({required this.exercises, required  this.title});
  factory Workout.fromJson(Map<String, dynamic> json){
    List<Exercise> exercises=[];
    int index = 0;
    int startTime = 0;
    for(var ex in (json['exercises'] as Iterable)){
      exercises.add(Exercise.fromJson(json, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(exercises: exercises, title:  json['title'] as String);
  }
  Map<String, dynamic> toJson()=>{'title':title, 'exercises':exercises};
}