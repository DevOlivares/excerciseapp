import 'package:equatable/equatable.dart';
import '../models/workout.dart';

abstract class WorkoutState extends Equatable{
  final Workout? workout;
  final int? elapsed;
  const WorkoutState (
      this.workout,
      this.elapsed,
      );
}
 class WorkoutInitial extends WorkoutState{
 const  WorkoutInitial():super(null,0);

  @override
  // TODO: implement props
  List<Object?> get props => throw [];
  }

  class WorkoutEditing extends WorkoutState{
    final int index;
    const  WorkoutEditing(
        Workout? workout,
        this.index):super(workout,0);

    @override
    // TODO: implement props
    List<Object?> get props => throw [workout,index];
  }
