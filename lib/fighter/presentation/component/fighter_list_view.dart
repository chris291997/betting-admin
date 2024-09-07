import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bet/fighter/presentation/bloc/fighter_list_bloc.dart';
import 'package:bet/fighter/presentation/bloc/fighter_update_or_delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FighterListView extends StatelessWidget {
  const FighterListView({
    super.key,
    this.initialSelectedFighter,
    this.onFighterSelected,
  });

  final FighterOutput? initialSelectedFighter;
  final Function(FighterOutput)? onFighterSelected;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FighterUpdateOrDeleteBloc, FighterUpdateOrDeleteState>(
      listener: (context, state) {
        if (state.deleteStatus.isSuccess) {
          context.read<FighterListBloc>().add(FighterListFetched());
        }
      },
      child: BlocBuilder<FighterListBloc, FighterListState>(
        builder: (context, state) {
          if (state.status.isError) {
            return const Center(child: Text('Failed to fetch fighters'));
          }

          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status.isInitial) {
            return const SizedBox();
          }

          final fighters = state.fighters;

          return CustomDataTable<FighterOutput>(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Weight')),
              DataColumn(label: Text('Breed')),
              DataColumn(label: Text('Trainer')),
            ],
            objects: fighters,
            onSelectChanged: (fighter) {},
            onDelete: (fighter) async {
              await showDialog(
                context: context,
                builder: (context) => BlocProvider.value(
                  value: context.read<FighterUpdateOrDeleteBloc>(),
                  child: _DeleteFighterModal(
                    fighterId: fighter.id,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DeleteFighterModal extends StatelessWidget {
  const _DeleteFighterModal({required this.fighterId});

  final String fighterId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Fighter'),
      content: const Text('Are you sure you want to delete this fighter?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<FighterUpdateOrDeleteBloc>().add(
                  FighterDeleted(fighterId),
                );
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
