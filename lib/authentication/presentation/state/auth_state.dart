part of '../viewmodel/auth_viewmodel.dart';

class AuthState extends Equatable {
  const AuthState({
    this.input = AuthInput.empty,
    this.status = ViewModelStatus.idle,
  });

  final AuthInput input;
  final ViewModelStatus status;

  AuthState copyWith({
    AuthInput? input,
    ViewModelStatus? status,
  }) {
    return AuthState(
      input: input ?? this.input,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [input, status];
}
