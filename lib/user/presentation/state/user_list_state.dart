part of '../bloc/user_list_bloc.dart';

class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.users = const <UserOutput>[],
  });

  final UserListStatus status;
  final List<UserOutput> users;

  UserListState copyWith({
    UserListStatus? status,
    List<UserOutput>? users,
  }) {
    return UserListState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }

  const UserListState.empty() : this();

  @override
  List<Object> get props => [
        status,
        users,
      ];
}

enum UserListStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == UserListStatus.initial;
  bool get isLoading => this == UserListStatus.loading;
  bool get isLoaded => this == UserListStatus.loaded;
  bool get isError => this == UserListStatus.error;
}
