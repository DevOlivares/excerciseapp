import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/blocs/workouts_cubits.dart';
import 'package:src/models/workout.dart';

import '../helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Time!'),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.event_available)),
          IconButton(onPressed: null, icon: Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutCubit, List<Workout>>(
          builder: (context,workouts)=>ExpansionPanelList.radio(
            children:
              workouts.map((workout)=> ExpansionPanelRadio(
                  value: workout,
                  headerBuilder: (BuildContext context, bool isExpanded)=>ListTile(
            visualDensity: const VisualDensity(
            horizontal: 0,
            vertical: VisualDensity.maximumDensity,
        ),
        leading: const IconButton(onPressed: null, icon: Icon(Icons.edit)),
        title: Text(workout.title!),
        trailing: Text(formatTime(workout.getTotal(), true)),
        ),
                  body: ListView.builder(
                    shrinkWrap: true,
                      itemCount: workout.exercises.length,
                      itemBuilder: (BuildContext context, int index)=>
                    ListTile(
                      onTap: null,
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: VisualDensity.maximumDensity,
                      ),
                      leading: Text(formatTime(workout.exercises[index].prelude!, true)),
                      title: Text(workout.exercises[index].title!),
                      trailing: Text(formatTime(workout.exercises[index].duration!,true)),
                    ),
                  ),

              )).toList()
          ),
        ),
      ),

    );
  }
}