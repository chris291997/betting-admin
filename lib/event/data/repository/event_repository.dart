part of '../di/event_service_locator.dart';

class EventRepository implements EventRepositoryInterface {
  const EventRepository(
    this._remoteSource,
  );

  final EventRemoteSource _remoteSource;

  @override
  Future<EventOutput> createEvent({required CreateEventInput input}) async {
    return _remoteSource.createEvent(input: input);
  }

  @override
  Future<void> deleteEvent({required String eventId}) async {
    return _remoteSource.deleteEvent(id: eventId);
  }

  @override
  Future<EventOutput> updateEvent(
      {required String eventId, required UpdateEventInput input}) async {
    return _remoteSource.updateEvent(eventId: eventId, input: input);
  }

  @override
  Future<List<EventOutput>> getEvents() async {
    return _remoteSource.getEvents();
  }
}
