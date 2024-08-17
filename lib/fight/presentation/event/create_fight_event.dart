part of '../bloc/create_fight_bloc.dart';

sealed class CreateFightEvent extends Equatable {
  const CreateFightEvent();

  @override
  List<Object> get props => [];
}

class FightCreateEventFightNumAdded extends CreateFightEvent {
  const FightCreateEventFightNumAdded(this.num);

  final int num;

  @override
  List<Object> get props => [num];
}

class FightCreateEventMeronAdded extends CreateFightEvent {
  const FightCreateEventMeronAdded(this.meron);

  final String meron;

  @override
  List<Object> get props => [meron];
}

class FightCreateEventWalaAdded extends CreateFightEvent {
  const FightCreateEventWalaAdded(this.wala);

  final String wala;

  @override
  List<Object> get props => [wala];
}

class FightCreateEventStartTimeAdded extends CreateFightEvent {
  const FightCreateEventStartTimeAdded(this.startTime);

  final String startTime;

  @override
  List<Object> get props => [startTime];
}

class FightCreated extends CreateFightEvent {}
