import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/blocs/workouts_cubits.dart';
import 'package:src/helpers.dart';
import 'package:src/states/workout_states.dart';

import '../blocs/workout_cubit.dart';
import '../models/exercise.dart';
import '../models/workout.dart';

class WorkoutProgress extends StatelessWidget {
  const WorkoutProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> _getStats(Workout workout, int workoutElapsed){
      // [0,30,40,70,90, 120 seconds
      int workoutTotal = workout.getTotal();
      Exercise exercise = workout.getCurrentExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed-exercise.startTime!;
      int exerciseRemaining = exercise.prelude!-exerciseElapsed;
      bool isPrelude = exerciseElapsed<exercise.prelude!;
      int exerciseTotal=isPrelude? exercise.prelude!:exercise.duration!;
      if(!isPrelude){
        exerciseElapsed -=exercise.prelude!;
        // -1+30 =>29
        exerciseRemaining -=exercise.prelude!;
      }

      return {
      "workoutTitle":workout.title,
      "workoutProgress":workoutElapsed/workoutTotal,
      "workoutElapsed":workoutElapsed,
      "totalExercise":workout.exercises.length,
      "currentExerciseIndex":exercise.index!.toDouble(),
      "workoutRemaining":workoutTotal-workoutElapsed,
      "exerciseRemaining":exerciseRemaining,
      "exerciseProgress": exerciseElapsed/exerciseTotal,
      "isPrelude":isPrelude,
    };
    }
    return BlocConsumer<WorkoutCubit,WorkoutState>(
        builder:(context,state){
          final stats=_getStats(state.workout!, state.elapsed!);
          return Scaffold (
            appBar: AppBar(
              title: Text(state.workout!.title.toString()),
              leading: BackButton(
                onPressed: ()=>BlocProvider.of<WorkoutCubit>(context).goHome(),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    backgroundColor: Colors.blue[100],
                    minHeight: 10,
                    value: stats['workoutProgress'],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(stats["workoutElapsed"],true)
                      ),
                      DotsIndicator(dotsCount: stats['totalExercise'],
                        position: stats['currentExerciseIndex'],
                      ),
                      Text(
                          '-${formatTime(stats["workoutRemaining"],true)}'
                      ),
                    ],
                  ),
                  ),
                  const Spacer(),
                  InkWell(
                    child: Stack(
                      alignment: const Alignment(0, 0),
                      children: [
                        Center(
                          child: SizedBox(
                            height: 220,
                            width: 220,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                stats['isPrelude']?Colors.red:Colors.blue,
                              ),
                              strokeWidth: 25,
                              value: stats['exerciseProgress']
                            ),
                          ),
                        ),
                         Center(
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Image.asset('stopwatch.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
        listener:(context,state){

    }
    );
  }
}
