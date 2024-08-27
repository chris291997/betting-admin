import 'package:bet/event/data/di/event_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/event_update_or_delete_event.dart';
part '../state/update_or_delete_state.dart';

class UpdateOrDeleteEventBloc
    extends Bloc<EventUpdateOrDeleteEvent, UpdateOrDeleteState> {
  UpdateOrDeleteEventBloc(this._eventRepository)
      : super(const UpdateOrDeleteState()) {
    on<EventUpdateEventNameAdded>(_onEventUpdateEventNameAdded);
    on<EventUpdateEventDateAdded>(_onEventUpdateEventDateAdded);
    on<EventUpdateEventLocationAdded>(_onEventUpdateEventLocationAdded);
    on<EventDeleted>(_onEventDeleted);
    on<EventUpdateEvent>(_onEventUpdateEvent);
    on<EventUpdateInitialized>(_onEventUpdateInitialized);
  }

  final EventRepository _eventRepository;

  void _onEventUpdateEventNameAdded(
      EventUpdateEventNameAdded event, Emitter<UpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(eventName: event.name),
      ),
    );
  }

  void _onEventUpdateEventDateAdded(
      EventUpdateEventDateAdded event, Emitter<UpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(eventDate: event.date),
      ),
    );
  }

  void _onEventUpdateEventLocationAdded(
      EventUpdateEventLocationAdded event, Emitter<UpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(location: event.location),
      ),
    );
  }

  void _onEventDeleted(
      EventDeleted event, Emitter<UpdateOrDeleteState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: UpdateOrDeleteStatus.loading));
      await _eventRepository.deleteEvent(eventId: event.id);
      emit(state.copyWith(deleteStatus: UpdateOrDeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(deleteStatus: UpdateOrDeleteStatus.error));
    }
  }

  void _onEventUpdateEvent(
      EventUpdateEvent event, Emitter<UpdateOrDeleteState> emit) async {
    try {
      emit(state.copyWith(updateStatus: UpdateOrDeleteStatus.loading));
      await _eventRepository.updateEvent(
          eventId: event.id, input: state.eventInput);
      emit(state.copyWith(updateStatus: UpdateOrDeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(updateStatus: UpdateOrDeleteStatus.error));
    }
  }

  void _onEventUpdateInitialized(
      EventUpdateInitialized event, Emitter<UpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        eventInput: state.eventInput.copyWith(
          eventName: event.eventOutput.eventName,
          location: event.eventOutput.location,
          eventDate: event.eventOutput.eventDate,
          creatorId: event.creatorId,
        ),
      ),
    );
  }
}
