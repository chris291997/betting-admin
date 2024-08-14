part of '../viewmodel/auth_viewmodel.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {}

class AuthLoginUsernameChanged extends AuthEvent {
  const AuthLoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object?> get props => [username];
}

class AuthLoginPasswordChanged extends AuthEvent {
  const AuthLoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}
