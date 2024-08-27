part of '../../di/event_service_locator.dart';

class EventOutput extends Equatable implements JsonSerializable {
  const EventOutput({
    this.id = '',
    this.eventName = '',
    this.location = '',
    this.creatorId = '',
    this.eventDate,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String eventName;
  final String location;
  final String creatorId;
  final DateTime? eventDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory EventOutput.fromJson(Map<String, dynamic> json) {
    return EventOutput(
      id: json.parseString('id'),
      eventName: json.parseString('eventName'),
      location: json.parseString('location'),
      creatorId: json.parseString('creatorId'),
      eventDate: json.parseDateTime('eventDate'),
      createdAt: json.parseDateTime('createdAt'),
      updatedAt: json.parseDateTime('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': eventName,
      'location': location,
      'creatorId': creatorId,
      'eventDate': eventDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> toTableJson() {
    // convert eventDate format to MM/dd/yyyy HH:mm:ss AA
    final eventDateFormatted = eventDate != null
        ? DateFormat('MM/dd/yyyy hh:mm:ss aa').format(eventDate!)
        : null;

    return {
      'eventName': eventName,
      'location': location,
      'eventDate': eventDateFormatted,
    };
  }

  static const empty = EventOutput();

  @override
  List<Object?> get props => [
        id,
        eventName,
        location,
        creatorId,
        eventDate,
        createdAt,
        updatedAt,
      ];
}
