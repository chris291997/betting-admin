import 'package:equatable/equatable.dart';

class CreateEventInput extends Equatable {
  const CreateEventInput({
    required this.eventName,
    required this.location,
    required this.creatorId,
    required this.eventDate,
  });

  final String eventName;
  final String location;
  final String creatorId;
  final DateTime eventDate;

  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'location': location,
      'creatorId': creatorId,
      'eventDate': eventDate.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        eventName,
        location,
        creatorId,
        eventDate,
      ];
}
