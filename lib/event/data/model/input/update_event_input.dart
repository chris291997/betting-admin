part of '../../di/event_service_locator.dart';

class UpdateEventInput extends EventInput {
  const UpdateEventInput({
    required super.eventName,
    required super.location,
    required super.creatorId,
    required super.eventDate,
  });

  const UpdateEventInput.empty()
      : super(
          eventName: '',
          location: '',
          creatorId: '',
          eventDate: null,
        );

  UpdateEventInput copyWith({
    String? eventName,
    String? location,
    String? creatorId,
    DateTime? eventDate,
  }) {
    return UpdateEventInput(
      eventName: eventName ?? this.eventName,
      location: location ?? this.location,
      creatorId: creatorId ?? this.creatorId,
      eventDate: eventDate ?? this.eventDate,
    );
  }

  @override
  List<Object?> get props => [
        eventName,
        location,
        creatorId,
        eventDate,
      ];
}
