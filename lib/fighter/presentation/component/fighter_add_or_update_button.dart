import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/fighter/presentation/bloc/create_fighter_bloc.dart';
import 'package:bet/fighter/presentation/bloc/fighter_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FighterAddOrUpdateButton extends StatelessWidget {
  const FighterAddOrUpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateFighterBloc, CreateFighterState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<FighterListBloc>().add(FighterListFetched());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return PrimaryButton(
            onPressed: () {
              context.read<CreateFighterBloc>().add(FighterCreated());
              Navigator.pop(context);
            },
            labelText: 'Submit');
      },
    );
  }
}
