import 'package:bet/fight/presentation/bloc/create_fight_bloc.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FightStartTimePicker extends StatelessWidget {
  const FightStartTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final time = Time(
      hour: 11,
      minute: 30,
    );

    return BlocSelector<CreateFightBloc, CreateFightState, String>(
      selector: (state) {
        return state.fightInput.startTime;
      },
      builder: (context, startTime) {
        return Row(
          children: [
            const Text("Fight Start Time:"),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: time,
                    minuteInterval: TimePickerInterval.FIVE,
                    onChange: (value) => {
                      context.read<CreateFightBloc>().add(
                            FightCreateEventStartTimeAdded(
                              value.toString(),
                            ),
                          )
                    },
                  ),
                );
              },
              child: Text(startTime.isNotEmpty ? startTime : "Select Time"),
            ),
          ],
        );
      },
    );
  }
}
