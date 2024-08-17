part of '../../di/event_service_locator.dart';

class EventInput extends Equatable {
  const EventInput({
    required this.eventName,
    required this.location,
    required this.creatorId,
    this.eventDate,
  });

  final String eventName;
  final String location;
  final String creatorId;
  final DateTime? eventDate;

  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'location': location,
      'creatorId': creatorId,
      'eventDate': eventDate?.toIso8601String(),
    };
  }

  const EventInput.empty()
      : eventName = '',
        location = '',
        creatorId = '',
        eventDate = null;

  @override
  List<Object?> get props => [
        eventName,
        location,
        creatorId,
        eventDate,
      ];
}
