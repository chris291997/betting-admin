import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bet/fight/presentation/bloc/fight_bloc.dart';
import 'package:bet/fight/presentation/event/fight_event.dart';
import 'package:bet/fight/presentation/state/fight_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FightDetailsScreen extends StatelessWidget {
  const FightDetailsScreen({required this.fight, super.key});

  final FightOutput fight;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FightBloc>(
          create: (_) => FightBloc(
            fightRepository,
          )..add(
              FightRequested(
                eventId: fight.eventId,
                fightId: fight.id,
              ),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Fights')),
        body: const Center(
          child: _FightDetails(),
        ),
      ),
    );
  }
}

class _FightDetails extends StatelessWidget {
  const _FightDetails();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FightBloc, FightState>(
      builder: (context, state) {
        if (state.status == FightStatus.loading) {
          return const CircularProgressIndicator();
        }

        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Fight Number: ${state.fight.fightNumber}'),
                  const Gap(20),
                  Text(
                    'Status: ${state.fight.isCanceled ? 'Canceled' : state.fight.isDraw ? 'Draw' : state.fight.status}',
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Meron: ${state.fight.meronId}'),
                      const Gap(20),
                      Text('Wala: ${state.fight.walaId}'),
                    ],
                  ),
                  const Gap(20),
                  if (state.fight.winnerId.isNotEmpty)
                    Text('Winner: ${state.fight.winnerId}'),
                  const Gap(20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: PrimaryButton(
                            state: !state.fight.isLocked &&
                                    !state.fight.isCanceled &&
                                    !state.fight.isDraw
                                ? PrimaryButtonState.enabled
                                : PrimaryButtonState.disabled,
                            onPressed: () {
                              context.read<FightBloc>().add(
                                    FightOpenedBets(),
                                  );
                            },
                            labelText: 'Open Bets',
                          ),
                        ),
                        const Gap(20),
                        Flexible(
                          child: SizedBox(
                            width: double.infinity,
                            child: SecondaryButton(
                              state: state.fight.isLocked &&
                                      !state.fight.isCanceled &&
                                      !state.fight.isDraw &&
                                      state.fight.winnerId.isEmpty
                                  ? CircularButtonState.enabled
                                  : CircularButtonState.disabled,
                              onPressed: () {
                                context.read<FightBloc>().add(
                                      FightClosedBets(),
                                    );
                              },
                              labelText: 'Close Bets',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Row(
                      children: [
                        if (!state.fight.isLocked &&
                            state.fight.status != 'InProgress')
                          Flexible(
                            child: PrimaryButton(
                              state: PrimaryButtonState.enabled,
                              onPressed: () {
                                context.read<FightBloc>().add(
                                      FightStarted(),
                                    );
                              },
                              labelText: 'Start',
                            ),
                          ),
                        const Gap(20),
                        if ((!state.fight.isCanceled && !state.fight.isDraw) &&
                            state.fight.winnerId.isEmpty &&
                            state.fight.isLocked)
                          Flexible(
                            child: PrimaryButton(
                              state: PrimaryButtonState.enabled,
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (_) => BlocProvider<FightBloc>.value(
                                    value: context.read<FightBloc>(),
                                    child: ConcludeModal(
                                      meronId: state.fight.meronId,
                                      walaId: state.fight.walaId,
                                    ),
                                  ),
                                );
                              },
                              labelText: 'Conclude',
                            ),
                          ),
                        const Gap(20),
                        if ((!state.fight.isCanceled && !state.fight.isDraw) &&
                            state.fight.winnerId.isEmpty &&
                            state.fight.isLocked)
                          Flexible(
                            child: PrimaryButton(
                              state: PrimaryButtonState.enabled,
                              onPressed: () {
                                context.read<FightBloc>().add(
                                      FightCanceled(),
                                    );
                              },
                              labelText: 'Cancel',
                            ),
                          ),
                        const Gap(20),
                        if ((!state.fight.isCanceled && !state.fight.isDraw) &&
                            state.fight.winnerId.isEmpty &&
                            state.fight.isLocked)
                          Flexible(
                            child: PrimaryButton(
                              state: PrimaryButtonState.enabled,
                              onPressed: () {
                                context.read<FightBloc>().add(
                                      FightDrawn(),
                                    );
                              },
                              labelText: 'Draw',
                            ),
                          ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ConcludeModal extends StatelessWidget {
  const ConcludeModal({
    required this.meronId,
    required this.walaId,
    super.key,
  });

  final String meronId;
  final String walaId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose winner and conclude fight'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            onPressed: () {
              context.read<FightBloc>().add(
                    FightConcluded(
                      winnerId: meronId,
                    ),
                  );
              Navigator.of(context).pop();
            },
            labelText: 'Meron',
          ),
          const Gap(20),
          SizedBox(
            width: double.infinity,
            child: SecondaryButton(
              onPressed: () {
                context.read<FightBloc>().add(
                      FightConcluded(
                        winnerId: walaId,
                      ),
                    );
                Navigator.of(context).pop();
              },
              labelText: 'Wala',
            ),
          ),
        ],
      ),
    );
  }
}
