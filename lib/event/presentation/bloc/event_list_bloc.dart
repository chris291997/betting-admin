import 'package:bet/event/data/di/event_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/event_list_event.dart';
part '../state/event_list_state.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  EventListBloc(this._eventRepository) : super(const EventListState()) {
    on<EventListEventFetched>(_onEventListEventFetched);
  }

  final EventRepository _eventRepository;

  _onEventListEventFetched(
      EventListEventFetched event, Emitter<EventListState> emit) async {
    emit(state.copyWith(status: EventListStatus.loading));
    try {
      final events = await _eventRepository.getEvents();

      emit(state.copyWith(status: EventListStatus.loaded, events: events));
    } catch (e) {
      emit(state.copyWith(status: EventListStatus.error));
    }
  }
}
