import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bet/fighter/presentation/bloc/fighter_list_bloc.dart';
import 'package:bet/fighter/presentation/component/fighter_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> displayFighterList(BuildContext context,
    {FighterOutput? initialSelectedFighter,
    Function(FighterOutput)? onFighterSelected}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 600,
          child: Material(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  lazy: false,
                  create: (context) => FighterListBloc(fighterRepository)
                    ..add(FighterListFetched()),
                ),
              ],
              child: FighterListView(
                  initialSelectedFighter: initialSelectedFighter,
                  onFighterSelected: (output) {
                    print('called');
                    onFighterSelected?.call(output);
                    Navigator.pop(context);
                  }),
            ),
          ),
        ),
      );
    },
  );
}
