part of '../bloc/update_or_delete_event_bloc.dart';

class UpdateOrDeleteState extends Equatable {
  const UpdateOrDeleteState({
    this.updateStatus = UpdateOrDeleteStatus.initial,
    this.deleteStatus = UpdateOrDeleteStatus.initial,
    this.eventInput = const UpdateEventInput.empty(),
    this.deleteEventId = '',
  });

  final UpdateOrDeleteStatus updateStatus;
  final UpdateOrDeleteStatus deleteStatus;
  final UpdateEventInput eventInput;
  final String deleteEventId;

  UpdateOrDeleteState copyWith({
    UpdateOrDeleteStatus? updateStatus,
    UpdateOrDeleteStatus? deleteStatus,
    UpdateEventInput? eventInput,
    String? deleteEventId,
  }) {
    return UpdateOrDeleteState(
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      eventInput: eventInput ?? this.eventInput,
      deleteEventId: deleteEventId ?? this.deleteEventId,
    );
  }

  const UpdateOrDeleteState.initial() : this();

  @override
  List<Object> get props => [
        updateStatus,
        deleteStatus,
        eventInput,
        deleteEventId,
      ];
}

enum UpdateOrDeleteStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == UpdateOrDeleteStatus.initial;
  bool get isLoading => this == UpdateOrDeleteStatus.loading;
  bool get isSuccess => this == UpdateOrDeleteStatus.success;
  bool get isError => this == UpdateOrDeleteStatus.error;
}
