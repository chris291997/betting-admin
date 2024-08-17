part of '../bloc/create_event_bloc.dart';

class CreateEventState extends Equatable {
  const CreateEventState({
    this.status = CreateEventStatus.initial,
    this.eventInput = const CreateEventInput.empty(),
  });

  final CreateEventStatus status;
  final CreateEventInput eventInput;

  const CreateEventState.empty()
      : status = CreateEventStatus.initial,
        eventInput = const CreateEventInput.empty();

  CreateEventState copyWith({
    CreateEventStatus? status,
    CreateEventInput? eventInput,
  }) {
    return CreateEventState(
      status: status ?? this.status,
      eventInput: eventInput ?? this.eventInput,
    );
  }

  @override
  List<Object> get props => [
        status,
        eventInput,
      ];
}

enum CreateEventStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == CreateEventStatus.initial;
  bool get isLoading => this == CreateEventStatus.loading;
  bool get isSuccess => this == CreateEventStatus.success;
  bool get isError => this == CreateEventStatus.error;
}
