part of '../bloc/event_list_bloc.dart';

class EventListState extends Equatable {
  const EventListState({
    this.status = EventListStatus.initial,
    this.events = const <EventOutput>[],
  });

  final EventListStatus status;
  final List<EventOutput> events;

  EventListState copyWith({
    EventListStatus? status,
    List<EventOutput>? events,
  }) {
    return EventListState(
      status: status ?? this.status,
      events: events ?? this.events,
    );
  }

  const EventListState.empty() : this();

  @override
  List<Object> get props => [
        status,
        events,
      ];
}

enum EventListStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == EventListStatus.initial;
  bool get isLoading => this == EventListStatus.loading;
  bool get isLoaded => this == EventListStatus.loaded;
  bool get isError => this == EventListStatus.error;
}
