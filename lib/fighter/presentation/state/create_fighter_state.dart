part of '../bloc/create_fighter_bloc.dart';

class CreateFighterState extends Equatable {
  const CreateFighterState({
    this.status = CreateFighterStatus.initial,
    this.fighterInput = const CreateFighterInput.empty(),
  });

  final CreateFighterStatus status;
  final CreateFighterInput fighterInput;

  CreateFighterState copyWith({
    CreateFighterStatus? status,
    CreateFighterInput? fighterInput,
  }) {
    return CreateFighterState(
      status: status ?? this.status,
      fighterInput: fighterInput ?? this.fighterInput,
    );
  }

  const CreateFighterState.empty()
      : status = CreateFighterStatus.initial,
        fighterInput = const CreateFighterInput.empty();

  @override
  List<Object> get props => [
        status,
        fighterInput,
      ];
}

enum CreateFighterStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == CreateFighterStatus.initial;
  bool get isLoading => this == CreateFighterStatus.loading;
  bool get isSuccess => this == CreateFighterStatus.success;
  bool get isError => this == CreateFighterStatus.error;
}
