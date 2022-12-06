import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:src/blocs/workouts_cubits.dart';
import 'package:src/helpers.dart';

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
                child: InkWell(
                  onLongPress:()=> showDialog(context: context,
                      builder:
                      (_){
                    final controller= TextEditingController(
                      text: widget.workout!.exercises[widget.exIndex!].prelude!.toString(),
                    );
                    return AlertDialog(
                      content: TextField(
                        controller: controller,
                          decoration: const InputDecoration(
                            labelText: "Prelude (Seconds)"
                          ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState((){
                                  widget.workout!.exercises[widget.exIndex!]
                                  =widget.workout!.exercises[widget.exIndex!].copyWith(
                                    prelude: int.parse(
                                        controller.text),
                                  );
                                  BlocProvider.of<WorkoutsCubit>(context).
                                  saveWorkout(widget.workout!, widget.index);
                                }
                                );
                              }
                            },
                            child: Text("Save"),)

                      ],
                    );
                      }
                  ),
                  child: NumberPicker(
                  itemHeight: 30,
                    value: widget.workout!.exercises[widget.exIndex!].prelude!,
                    maxValue: 3599,
                    minValue: 0,
                    textMapper: (strVal)=>formatTime(int.parse(strVal),false),
                    onChanged: (value)=>setState((){
                      widget.workout!.exercises[widget.exIndex!]
                      =widget.workout!.exercises[widget.exIndex!].copyWith(
                      prelude: value,
                      );
                      BlocProvider.of<WorkoutsCubit>(context).
                      saveWorkout(widget.workout!, widget.index);
                      }),
                  ),
                ),
            ),
            Expanded(
                child:TextField(
                  textAlign: TextAlign.center,
                  controller: _title,
                  onChanged: (value)=>setState(() {
                    widget.workout!.exercises[widget.exIndex!]
                    =widget.workout!.exercises[widget.exIndex!].copyWith(
                    title: value,
                  );
                    BlocProvider.of<WorkoutsCubit>(context).
                    saveWorkout(widget.workout!, widget.index);
                  }),
                ),
                ),
            Expanded(
              flex: 3,
              child: InkWell(
                onLongPress:()=> showDialog(context: context,
                    builder:
                        (_){
                      final controller= TextEditingController(
                        text: widget.workout!.exercises[widget.exIndex!].duration!.toString(),
                      );
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              labelText: "Duration (Seconds)"
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState((){
                                  widget.workout!.exercises[widget.exIndex!]
                                  =widget.workout!.exercises[widget.exIndex!].copyWith(
                                    duration: int.parse(
                                        controller.text),
                                  );
                                  BlocProvider.of<WorkoutsCubit>(context).
                                  saveWorkout(widget.workout!, widget.index);
                                }
                                );
                              }
                            },
                            child: Text("Save"),)

                        ],
                      );
                    }
                ),
                child: NumberPicker(
                  itemHeight: 30,
                  value: widget.workout!.exercises[widget.exIndex!].duration!,
                  maxValue: 3599,
                  minValue: 0,
                  textMapper: (strVal)=>formatTime(int.parse(strVal),false),
                  onChanged: (value)=>setState((){
                    widget.workout!.exercises[widget.exIndex!]
                    =widget.workout!.exercises[widget.exIndex!].copyWith(
                      duration: value,
                    );
                    BlocProvider.of<WorkoutsCubit>(context).
                    saveWorkout(widget.workout!, widget.index);
                  }),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
