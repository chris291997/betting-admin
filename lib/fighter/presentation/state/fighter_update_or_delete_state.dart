part of '../bloc/fighter_update_or_delete_bloc.dart';

class FighterUpdateOrDeleteState extends Equatable {
  const FighterUpdateOrDeleteState({
    this.updateStatus = FighterUpdateOrDeleteStatus.initial,
    this.deleteStatus = FighterUpdateOrDeleteStatus.initial,
    this.deleteFighterId = '',
    this.fighterUpdateInput = const UdpateFighterInput.empty(),
  });

  final FighterUpdateOrDeleteStatus updateStatus;
  final FighterUpdateOrDeleteStatus deleteStatus;
  final String deleteFighterId;
  final UdpateFighterInput fighterUpdateInput;

  const FighterUpdateOrDeleteState.empty()
      : updateStatus = FighterUpdateOrDeleteStatus.initial,
        deleteStatus = FighterUpdateOrDeleteStatus.initial,
        deleteFighterId = '',
        fighterUpdateInput = const UdpateFighterInput.empty();

  FighterUpdateOrDeleteState copyWith({
    FighterUpdateOrDeleteStatus? updateStatus,
    FighterUpdateOrDeleteStatus? deleteStatus,
    String? deleteFighterId,
    UdpateFighterInput? fighterUpdateInput,
  }) {
    return FighterUpdateOrDeleteState(
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      deleteFighterId: deleteFighterId ?? this.deleteFighterId,
      fighterUpdateInput: fighterUpdateInput ?? this.fighterUpdateInput,
    );
  }

  @override
  List<Object> get props => [
        updateStatus,
        deleteStatus,
        deleteFighterId,
        fighterUpdateInput,
      ];
}

enum FighterUpdateOrDeleteStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == FighterUpdateOrDeleteStatus.initial;
  bool get isLoading => this == FighterUpdateOrDeleteStatus.loading;
  bool get isSuccess => this == FighterUpdateOrDeleteStatus.success;
  bool get isError => this == FighterUpdateOrDeleteStatus.error;
}
