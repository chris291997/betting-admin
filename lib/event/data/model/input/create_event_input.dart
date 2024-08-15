part of '../../di/event_service_locator.dart';

class CreateEventInput extends EventInput {
  const CreateEventInput({
    required super.eventName,
    required super.location,
    required super.creatorId,
    required super.eventDate,
  });

  const CreateEventInput.empty()
      : super(
          eventName: '',
          location: '',
          creatorId: '',
          eventDate: null,
        );

  CreateEventInput copyWith({
    String? eventName,
    String? location,
    String? creatorId,
    DateTime? eventDate,
  }) {
    return CreateEventInput(
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
