part of '../../di/event_service_locator.dart';

class EventRemoteSource {
  const EventRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String eventPath = '/events';

  Future<EventOutput> createEvent({required CreateEventInput input}) async {
    final response = await _manager.post(
      eventPath,
      data: input.toJson(),
    );

    return EventOutput.fromJson(response.data);
  }

  Future<EventOutput> updateEvent({
    required String eventId,
    required UpdateEventInput input,
  }) async {
    final response = await _manager.patch(
      '$eventPath/$eventId',
      data: input.toJson(),
    );

    return EventOutput.fromJson(response.data);
  }

  Future<void> deleteEvent({required String id}) async {
    await _manager.delete(
      '$eventPath/$id',
    );
  }

  Future<EventOutput> getEvent({required String id}) async {
    final response = await _manager.get(
      '$eventPath/$id',
    );

    return EventOutput.fromJson(response.data);
  }

  Future<List<EventOutput>> getEvents() async {
    final response = await _manager.get(
      eventPath,
    );

    return (response.data as List)
        .map((e) => EventOutput.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
