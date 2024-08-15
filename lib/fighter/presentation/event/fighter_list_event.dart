part of '../bloc/fighter_list_bloc.dart';

sealed class FighterListEvent extends Equatable {
  const FighterListEvent();

  @override
  List<Object> get props => [];
}

class FighterListFetched extends FighterListEvent {}
