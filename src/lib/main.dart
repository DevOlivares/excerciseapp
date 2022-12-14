import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:src/blocs/workout_cubit.dart';
import 'package:src/blocs/workouts_cubits.dart';
import 'package:src/screens/edit_workout_screen.dart';
import 'package:src/screens/home_page.dart';
import 'package:src/screens/workout_in_progress.dart';
import 'package:src/states/workout_states.dart';
import 'package:bloc/bloc.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 final storage = await HydratedStorage.build(
     storageDirectory: await getApplicationDocumentsDirectory()
  );
 HydratedBlocOverrides.runZoned(
         ()=> runApp(const WorkoutTime()),
          storage: storage);
}

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
      home:
      MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: (BuildContext context){
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if(workoutsCubit.state.isEmpty){
                print("...loading json since the state is empty");
                workoutsCubit.getWorkouts();
              }else{
                print("...the state is not empty");
              }
              return workoutsCubit;
            }),
          BlocProvider<WorkoutCubit>(create: (BuildContext context)=> WorkoutCubit(),)
        ],
        child: BlocBuilder<WorkoutCubit,WorkoutState>(
          builder: (context,state){
            if(state is WorkoutInitial){
           return const HomePage();
            }else if (state is WorkoutEditing){
              return EditWorkoutScreen();
            }
            return const WorkoutProgress();
          },
        )
      ),
    );
  }
}
