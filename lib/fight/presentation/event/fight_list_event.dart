part of '../bloc/fight_list_bloc.dart';

sealed class FightListEvent extends Equatable {
  const FightListEvent();

  @override
  List<Object> get props => [];
}

class FightListFetched extends FightListEvent {
  const FightListFetched(this.eventId);

  final String eventId;

  @override
  List<Object> get props => [eventId];
}
