part of '../bloc/fight_update_or_delete_bloc.dart';

sealed class FightUpdateOrDeleteEvent extends Equatable {
  const FightUpdateOrDeleteEvent();

  @override
  List<Object> get props => [];
}

class FightUpdateEventFightNumAdded extends FightUpdateOrDeleteEvent {
  const FightUpdateEventFightNumAdded(this.num);

  final int num;

  @override
  List<Object> get props => [num];
}

class FightUpdateEventMeronAdded extends FightUpdateOrDeleteEvent {
  const FightUpdateEventMeronAdded(this.meron);

  final String meron;

  @override
  List<Object> get props => [meron];
}

class FightUpdateEventWalaAdded extends FightUpdateOrDeleteEvent {
  const FightUpdateEventWalaAdded(this.wala);

  final String wala;

  @override
  List<Object> get props => [wala];
}

class FightUpdateEventStartTimeAdded extends FightUpdateOrDeleteEvent {
  const FightUpdateEventStartTimeAdded(this.startTime);

  final String startTime;

  @override
  List<Object> get props => [startTime];
}

class FightDeleted extends FightUpdateOrDeleteEvent {
  const FightDeleted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class FightUpdateEvent extends FightUpdateOrDeleteEvent {
  const FightUpdateEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class FightUpdateInitialized extends FightUpdateOrDeleteEvent {
  const FightUpdateInitialized(this.fight);

  final FightOutput fight;

  @override
  List<Object> get props => [fight];
}
