part of '../bloc/update_or_delete_user_bloc.dart';

sealed class UpdateOrDeleteUserEvent extends Equatable {
  const UpdateOrDeleteUserEvent();

  @override
  List<Object> get props => [];
}

class UserUpdateEventUserInitialValueAdded extends UpdateOrDeleteUserEvent {
  const UserUpdateEventUserInitialValueAdded(this.userInitialValue);

  final UpdateUserInput userInitialValue;

  @override
  List<Object> get props => [userInitialValue];
}

class UserUpdateEventUserTypeAdded extends UpdateOrDeleteUserEvent {
  const UserUpdateEventUserTypeAdded(this.userType);

  final String userType;

  @override
  List<Object> get props => [userType];
}

class UserUpdateEventFirstNameAdded extends UpdateOrDeleteUserEvent {
  const UserUpdateEventFirstNameAdded(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class UserUpdateEventMiddleNameAdded extends UpdateOrDeleteUserEvent {
  const UserUpdateEventMiddleNameAdded(this.middleName);

  final String middleName;

  @override
  List<Object> get props => [middleName];
}

class UserUpdateEventLastNameAdded extends UpdateOrDeleteUserEvent {
  const UserUpdateEventLastNameAdded(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class UserUpdateEventUserNameAdded extends UpdateOrDeleteUserEvent {
  const UserUpdateEventUserNameAdded(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

class UserUpdateEventCreatedByAdded extends UpdateOrDeleteUserEvent {
  const UserUpdateEventCreatedByAdded(this.createdBy);

  final String createdBy;

  @override
  List<Object> get props => [createdBy];
}

class UserDeleted extends UpdateOrDeleteUserEvent {
  const UserDeleted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class UserUpdated extends UpdateOrDeleteUserEvent {
  const UserUpdated(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class UserUpdateInitialized extends UpdateOrDeleteUserEvent {
  const UserUpdateInitialized(this.user);

  final UserOutput user;

  @override
  List<Object> get props => [user];
}
