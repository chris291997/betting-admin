import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:bet/common/di/service_locator.dart';
import 'package:bet/common/helper/extension/string.dart';
import 'package:bet/common/theme/theme.dart';
import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bet/fight/presentation/bloc/fight_bloc.dart';
import 'package:bet/fight/presentation/event/fight_event.dart';
import 'package:bet/fight/presentation/state/fight_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

        final status = state.fight.status;

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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: PrimaryButton(
                                state: (!state.fight.isLocked &&
                                            !state.fight.isCanceled &&
                                            !state.fight.isDraw) ||
                                        status == 'InProgress'
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
                                          state.fight.winnerId.isEmpty &&
                                          status != 'InProgress'
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
                  const Gap(20),
                  if (status == 'NotStarted')
                    _CancelTransactionButton(
                      fightId: state.fight.id,
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

class _CancelTransactionButton extends StatelessWidget {
  const _CancelTransactionButton({required this.fightId});

  final String fightId;

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => _CancelTransactionModal(fightId: fightId),
        );
      },
      labelText: 'Cancel Transaction',
    );
  }
}

class _CancelTransactionModal extends HookWidget {
  const _CancelTransactionModal({required this.fightId});

  final String fightId;

  Future<void> cancelTransaction(String transactionId) async {
    await networkManager.get('/bets/transaction/$transactionId/void');
  }

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cancel Transaction',
                style: context.textStyle.headline6,
              ),
              Text(
                'Warning: You cannot undo this action after confirming.',
                style: context.textStyle.subtitle2.copyWith(
                  color: context.colors.errorContainer,
                ),
              ),
              const Gap(20),
              BaseTextfield(
                controller: textController,
                onChanged: (value) {},
                hintText: 'Enter Transaction ID',
              ),
              const Gap(10),
              HookBuilder(builder: (context) {
                final state = useState(PrimaryButtonState.disabled);

                textController.addListener(() {
                  state.value = textController.text.isNotEmptyOrWhiteSpace
                      ? PrimaryButtonState.enabled
                      : PrimaryButtonState.disabled;
                });

                return PrimaryButton(
                  onPressed: () async {
                    state.value = PrimaryButtonState.loading;
                    await cancelTransaction(textController.text).then((_) {
                      state.value = PrimaryButtonState.enabled;
                      Navigator.pop(context);
                    }).catchError((error) {
                      state.value = PrimaryButtonState.enabled;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error: Failed to cancel transaction'),
                        ),
                      );
                    });
                  },
                  state: state.value,
                  labelText: 'Confirm',
                  color: AppColors.scheme.errorContainer,
                  disabledColor:
                      AppColors.scheme.errorContainer.withOpacity(0.4),
                );
              }),
              const Gap(20),
              SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  onPressed: () => Navigator.pop(context),
                  labelText: 'Cancel',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
