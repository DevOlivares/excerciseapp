import 'package:flutter/material.dart';

import '../models/workout.dart';

class EditExerciseScreen extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int? exIndex;
  const EditExerciseScreen({Key? key,
  this.workout,
  this.exIndex,
  required this.index,
  }) : super(key: key);

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();

}

class _EditExerciseScreenState extends State<EditExerciseScreen> {

  TextEditingController ? _title;

  @override
  void initstate(){
    _title = TextEditingController(
      text: widget.workout!.exercises[widget.exIndex!].title
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child:TextField(
                  textAlign: TextAlign.center,
                  controller: _title,
                  onChanged: (value)=>setState(() {

                  }),
                ),
                ),
          ],
        ),
      ],
    );
  }
}