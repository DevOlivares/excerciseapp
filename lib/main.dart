import 'package:excerciseapp/blocs/workout_cubit.dart';
import 'package:excerciseapp/model/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  ()=>runApp(WorkoutTime());
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(255, 66, 74, 96)),
        )
      ),
       home: BlocProvider<WorkoutsCubit>(
        create: (BuildContext context){
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if(workoutsCubit.state.isEmpty){
            print("...is Loading json since the state is empty ");
            workoutsCubit.getWorkouts();
          }else{
            print("...is Loading json since the state isn't empty ");
          }
          return workoutsCubit;
        },
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state){
          return Text("HI FERNANDO");
        },
        ),
      ),
    );
  }
}
