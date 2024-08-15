part of '../di/event_service_locator.dart';

abstract interface class EventRepositoryInterface {
  Future<EventOutput> createEvent({required CreateEventInput input});
  Future<void> deleteEvent({required String eventId});
  Future<EventOutput> updateEvent(
      {required String eventId, required UpdateEventInput input});
  Future<List<EventOutput>> getEvents();
}
