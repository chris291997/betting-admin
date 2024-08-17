part of '../bloc/account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({
    this.status = AccountStatus.initial,
    this.userId = '',
    this.userOutput = UserOutput.empty,
  });

  final AccountStatus status;
  final String userId;
  final UserOutput userOutput;

  AccountState copyWith({
    AccountStatus? status,
    String? userId,
    UserOutput? userOutput,
  }) {
    return AccountState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      userOutput: userOutput ?? this.userOutput,
    );
  }

  const AccountState.empty()
      : status = AccountStatus.initial,
        userId = '',
        userOutput = UserOutput.empty;

  

  @override
  List<Object> get props => [
        status,
        userId,
        userOutput,
      ];
}

enum AccountStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == AccountStatus.initial;
  bool get isLoading => this == AccountStatus.loading;
  bool get isSuccess => this == AccountStatus.success;
  bool get isError => this == AccountStatus.error;
}
