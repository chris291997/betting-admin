part of '../bloc/fight_update_or_delete_bloc.dart';

class FightUpdateOrDeleteState extends Equatable {
  const FightUpdateOrDeleteState({
    this.updateStatus = FightUpdateOrDeleteStatus.initial,
    this.deleteStatus = FightUpdateOrDeleteStatus.initial,
    this.eventId = '',
    this.deleteFightId = '',
    this.updateFightInput = const UpdateFightInput.empty(),
  });

  final FightUpdateOrDeleteStatus updateStatus;
  final FightUpdateOrDeleteStatus deleteStatus;
  final String eventId;
  final String deleteFightId;
  final UpdateFightInput updateFightInput;

  FightUpdateOrDeleteState copyWith({
    String? eventId,
    FightUpdateOrDeleteStatus? updateStatus,
    FightUpdateOrDeleteStatus? deleteStatus,
    String? deleteFightId,
    UpdateFightInput? updateFightInput,
  }) {
    return FightUpdateOrDeleteState(
      eventId: eventId ?? this.eventId,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      deleteFightId: deleteFightId ?? this.deleteFightId,
      updateFightInput: updateFightInput ?? this.updateFightInput,
    );
  }

  const FightUpdateOrDeleteState.empty()
      : updateStatus = FightUpdateOrDeleteStatus.initial,
        deleteStatus = FightUpdateOrDeleteStatus.initial,
        deleteFightId = '',
        eventId = '',
        updateFightInput = const UpdateFightInput.empty();

  @override
  List<Object> get props => [
        updateStatus,
        deleteStatus,
        deleteFightId,
        updateFightInput,
        eventId,
      ];
}

enum FightUpdateOrDeleteStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == FightUpdateOrDeleteStatus.initial;
  bool get isLoading => this == FightUpdateOrDeleteStatus.loading;
  bool get isSuccess => this == FightUpdateOrDeleteStatus.success;
  bool get isError => this == FightUpdateOrDeleteStatus.error;
}
