part of '../bloc/update_or_delete_user_bloc.dart';

class UpdateOrDeleteUserState extends Equatable {
  const UpdateOrDeleteUserState({
    this.updateStatus = UpdateOrDeleteUserStatus.initial,
    this.deleteStatus = UpdateOrDeleteUserStatus.initial,
    this.deleteUserId = '',
    this.updateUserInput = const UpdateUserInput.empty(),
  });

  final UpdateOrDeleteUserStatus updateStatus;
  final UpdateOrDeleteUserStatus deleteStatus;
  final String deleteUserId;
  final UpdateUserInput updateUserInput;

  const UpdateOrDeleteUserState.empty()
      : updateStatus = UpdateOrDeleteUserStatus.initial,
        deleteStatus = UpdateOrDeleteUserStatus.initial,
        deleteUserId = '',
        updateUserInput = const UpdateUserInput.empty();

  UpdateOrDeleteUserState copyWith({
    UpdateOrDeleteUserStatus? updateStatus,
    UpdateOrDeleteUserStatus? deleteStatus,
    String? deleteUserId,
    UpdateUserInput? updateUserInput,
  }) {
    return UpdateOrDeleteUserState(
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      deleteUserId: deleteUserId ?? this.deleteUserId,
      updateUserInput: updateUserInput ?? this.updateUserInput,
    );
  }

  @override
  List<Object> get props => [
        updateStatus,
        deleteStatus,
        deleteUserId,
        updateUserInput,
      ];
}

enum UpdateOrDeleteUserStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == UpdateOrDeleteUserStatus.initial;
  bool get isLoading => this == UpdateOrDeleteUserStatus.loading;
  bool get isSuccess => this == UpdateOrDeleteUserStatus.success;
  bool get isError => this == UpdateOrDeleteUserStatus.error;
}
