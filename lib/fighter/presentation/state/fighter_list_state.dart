part of '../bloc/fighter_list_bloc.dart';

class FighterListState extends Equatable {
  const FighterListState({
    this.status = FighterListStatus.initial,
    this.fighters = const <FighterOutput>[],
  });

  final FighterListStatus status;
  final List<FighterOutput> fighters;

  FighterListState copyWith({
    FighterListStatus? status,
    List<FighterOutput>? fighters,
  }) {
    return FighterListState(
      status: status ?? this.status,
      fighters: fighters ?? this.fighters,
    );
  }

  const FighterListState.empty() : this();

  @override
  List<Object> get props => [
        status,
        fighters,
      ];
}

enum FighterListStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == FighterListStatus.initial;
  bool get isLoading => this == FighterListStatus.loading;
  bool get isLoaded => this == FighterListStatus.loaded;
  bool get isError => this == FighterListStatus.error;
}
