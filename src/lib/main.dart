import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/blocs/workouts_cubits.dart';
import 'package:src/models/workout.dart';
import 'package:src/screens/home_page.dart';

void main()=>runApp(const WorkoutTime());

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercises for all',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(255, 66, 74, 96))
        )
      ),
      home: BlocProvider<WorkoutCubit>(
        create: (BuildContext context){
          WorkoutCubit workoutCubit = WorkoutCubit();
          if(workoutCubit.state.isEmpty){
            print("...loading json since the state is empty");
            workoutCubit.getWorkouts();
          }else{
            print("...the state is not empty");
          }
          return workoutCubit;
        },
        child: BlocBuilder<WorkoutCubit, List<Workout>>(builder: (context, state){
          return const HomePage();
        },),
      ),
    );
  }
}
