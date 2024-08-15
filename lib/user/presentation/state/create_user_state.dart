part of '../bloc/create_user_bloc.dart';

class CreateUserState extends Equatable {
  const CreateUserState({
    this.status = CreateUserStatus.initial,
    this.userInput = const CreateUserInput.empty(),
  });

  final CreateUserStatus status;
  final CreateUserInput userInput;

  CreateUserState copyWith({
    CreateUserStatus? status,
    CreateUserInput? userInput,
  }) {
    return CreateUserState(
      status: status ?? this.status,
      userInput: userInput ?? this.userInput,
    );
  }

  const CreateUserState.empty()
      : status = CreateUserStatus.initial,
        userInput = const CreateUserInput.empty();

  @override
  List<Object> get props => [
        status,
        userInput,
      ];
}

enum CreateUserStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == CreateUserStatus.initial;
  bool get isLoading => this == CreateUserStatus.loading;
  bool get isSuccess => this == CreateUserStatus.success;
  bool get isError => this == CreateUserStatus.error;
}
