import 'package:bet/event/data/di/event_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/event_create_event.dart';
part '../state/create_event_state.dart';

class CreateEventBloc extends Bloc<EventCreateEvent, CreateEventState> {
  CreateEventBloc(this._eventRepository) : super(const CreateEventState()) {
    on<EventCreateEventNameAdded>(_onEventEventNameAdded);
    on<EventCreateEventDateAdded>(_onEventEventDateAdded);
    on<EventCreateEventLocationAdded>(_onEventEventLocationAdded);
    on<EventCreatedEventCreatorAdded>(_onEventEventCreatorAdded);
    on<EventCreated>(_onEventEventCreated);
  }

  final EventRepository _eventRepository;
  void _onEventEventNameAdded(
      EventCreateEventNameAdded event, Emitter<CreateEventState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(eventName: event.name),
      ),
    );
  }

  void _onEventEventDateAdded(
      EventCreateEventDateAdded event, Emitter<CreateEventState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(eventDate: event.date),
      ),
    );
  }

  void _onEventEventLocationAdded(
      EventCreateEventLocationAdded event, Emitter<CreateEventState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(location: event.location),
      ),
    );
  }

  void _onEventEventCreatorAdded(
      EventCreatedEventCreatorAdded event, Emitter<CreateEventState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(creatorId: event.creatorId),
      ),
    );
  }

  void _onEventEventCreated(
      EventCreated event, Emitter<CreateEventState> emit) async {
    try {
      emit(state.copyWith(status: CreateEventStatus.loading));
      print(state.eventInput);
      await _eventRepository.createEvent(input: state.eventInput);
      emit(state.copyWith(status: CreateEventStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateEventStatus.error));
    }
  }
}
