part of '../bloc/fight_list_bloc.dart';

class FightListState extends Equatable {
  const FightListState({
    this.status = FightListStatus.initial,
    this.fights = const <FightOutput>[],
  });

  final FightListStatus status;
  final List<FightOutput> fights;

  FightListState copyWith({
    FightListStatus? status,
    List<FightOutput>? fights,
  }) {
    return FightListState(
      status: status ?? this.status,
      fights: fights ?? this.fights,
    );
  }

  const FightListState.empty() : this();

  @override
  List<Object> get props => [
        status,
        fights,
      ];
}

enum FightListStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == FightListStatus.initial;
  bool get isLoading => this == FightListStatus.loading;
  bool get isLoaded => this == FightListStatus.loaded;
  bool get isError => this == FightListStatus.error;
}
