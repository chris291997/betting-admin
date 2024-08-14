import 'package:bet/common/helper/extension/json.dart';
import 'package:equatable/equatable.dart';

class EventOutput extends Equatable {
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
