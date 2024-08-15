import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bet/fighter/presentation/bloc/create_fighter_bloc.dart';
import 'package:bet/fighter/presentation/bloc/fighter_list_bloc.dart';
import 'package:bet/fighter/presentation/component/fighter_list_view.dart';
import 'package:bet/fighter/presentation/component/fighter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FighterListScreen extends StatelessWidget {
  const FighterListScreen({super.key});

  static const String routeName = "/fighters";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => FighterListBloc(fighterRepository),
        ),
      ],
      child: const _FighterListScreen(),
    );
  }
}

class _FighterListScreen extends StatelessWidget {
  const _FighterListScreen({super.key});

  void _showCreateFighterModal(BuildContext contextFromParent) {
    showDialog(
      context: contextFromParent,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => CreateFighterBloc(fighterRepository),
          ),
          BlocProvider.value(
            value: BlocProvider.of<FighterListBloc>(contextFromParent),
          ),
        ],
        child: const FighterModal(
          type: FighterModalType.add,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fighters')),
      body: const Center(
        child: SizedBox(
          width: 1000,
          child: FighterListView(),
        ),
      ),
      floatingActionButton: SecondaryButton(
        height: 30,
        width: 120,
        onPressed: () => _showCreateFighterModal(context),
        labelText: 'Add Fighter',
      ),
    );
  }
}
