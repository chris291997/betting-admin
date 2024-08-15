part of '../bloc/account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountEventLoggedUserRequested extends AccountEvent {}
