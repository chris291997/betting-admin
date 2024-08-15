part of '../bloc/create_event_bloc.dart';

sealed class EventCreateEvent extends Equatable {
  const EventCreateEvent();

  @override
  List<Object> get props => [];
}

class EventCreateEventNameAdded extends EventCreateEvent {
  const EventCreateEventNameAdded(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EventCreateEventLocationAdded extends EventCreateEvent {
  const EventCreateEventLocationAdded(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class EventCreateEventDateAdded extends EventCreateEvent {
  const EventCreateEventDateAdded(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class EventCreated extends EventCreateEvent {}
