part of '../bloc/update_or_delete_event_bloc.dart';

sealed class EventUpdateOrDeleteEvent extends Equatable {
  const EventUpdateOrDeleteEvent();

  @override
  List<Object> get props => [];
}

class EventUpdateEventNameAdded extends EventUpdateOrDeleteEvent {
  const EventUpdateEventNameAdded(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EventUpdateEventLocationAdded extends EventUpdateOrDeleteEvent {
  const EventUpdateEventLocationAdded(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class EventUpdateEventDateAdded extends EventUpdateOrDeleteEvent {
  const EventUpdateEventDateAdded(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class EventDeleted extends EventUpdateOrDeleteEvent {
  const EventDeleted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class EventUpdateEvent extends EventUpdateOrDeleteEvent {
  const EventUpdateEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class EventUpdateInitialized extends EventUpdateOrDeleteEvent {
  const EventUpdateInitialized(this.creatorId, this.eventOutput);

  final String creatorId;
  final EventOutput eventOutput;

  @override
  List<Object> get props => [eventOutput];
}
