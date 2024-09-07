import 'package:equatable/equatable.dart';

abstract class FightEvent extends Equatable {
  const FightEvent();

  @override
  List<Object> get props => [];
}

class FightRequested extends FightEvent {
  const FightRequested({required this.eventId, required this.fightId});

  final String eventId;
  final String fightId;

  @override
  List<Object> get props => [eventId, fightId];
}

class FightStarted extends FightEvent {}

class FightConcluded extends FightEvent {
  const FightConcluded({required this.winnerId});

  final String winnerId;

  @override
  List<Object> get props => [winnerId];
}

class FightDrawn extends FightEvent {}

class FightCanceled extends FightEvent {}

class FightOpenedBets extends FightEvent {}

class FightClosedBets extends FightEvent {}
