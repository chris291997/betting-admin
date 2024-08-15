part of '../bloc/create_user_bloc.dart';

sealed class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class UserCreateEventUserTypeAdded extends CreateUserEvent {
  const UserCreateEventUserTypeAdded(this.userType);

  final String userType;

  @override
  List<Object> get props => [userType];
}

class UserCreateEventFirstNameAdded extends CreateUserEvent {
  const UserCreateEventFirstNameAdded(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class UserCreateEventMiddleNameAdded extends CreateUserEvent {
  const UserCreateEventMiddleNameAdded(this.middleName);

  final String middleName;

  @override
  List<Object> get props => [middleName];
}

class UserCreateEventLastNameAdded extends CreateUserEvent {
  const UserCreateEventLastNameAdded(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class UserCreateEventUserNameAdded extends CreateUserEvent {
  const UserCreateEventUserNameAdded(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

class UserCreateEventCreatedByAdded extends CreateUserEvent {
  const UserCreateEventCreatedByAdded(this.createdBy);

  final String createdBy;

  @override
  List<Object> get props => [createdBy];
}

class UserCreated extends CreateUserEvent {}
