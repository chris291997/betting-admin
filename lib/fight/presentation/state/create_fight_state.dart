part of '../bloc/create_fight_bloc.dart';

class CreateFightState extends Equatable {
  const CreateFightState({
    this.status = CreateFightStatus.initial,
    this.eventId = '',
    this.fightInput = const CreateFightInput.empty(),
  });

  final CreateFightStatus status;
  final String eventId;
  final CreateFightInput fightInput;

  CreateFightState copyWith({
    CreateFightStatus? status,
    String? eventId,
    CreateFightInput? fightInput,
  }) {
    return CreateFightState(
      status: status ?? this.status,
      eventId: eventId ?? this.eventId,
      fightInput: fightInput ?? this.fightInput,
    );
  }

  const CreateFightState.empty()
      : status = CreateFightStatus.initial,
        eventId = '',
        fightInput = const CreateFightInput.empty();

  @override
  List<Object> get props => [
        status,
        eventId,
        fightInput,
      ];
}

enum CreateFightStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == CreateFightStatus.initial;
  bool get isLoading => this == CreateFightStatus.loading;
  bool get isSuccess => this == CreateFightStatus.success;
  bool get isError => this == CreateFightStatus.error;
}
