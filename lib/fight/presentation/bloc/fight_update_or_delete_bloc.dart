import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/fight_update_or_delete_event.dart';
part '../state/fight_update_or_delete_state.dart';

class FightUpdateOrDeleteBloc
    extends Bloc<FightUpdateOrDeleteEvent, FightUpdateOrDeleteState> {
  FightUpdateOrDeleteBloc(
    this._fightRepository,
    this.eventId,
  ) : super(FightUpdateOrDeleteState(eventId: eventId)) {
    on<FightUpdateEventFightNumAdded>(_onFightUpdateEventFightNumAdded);
    on<FightUpdateEventMeronAdded>(_onFightUpdateEventMeronAdded);
    on<FightUpdateEventWalaAdded>(_onFightUpdateEventWalaAdded);
    on<FightUpdateEventStartTimeAdded>(_onFightUpdateEventStartTimeAdded);
    on<FightDeleted>(_onFightDeleted);
    on<FightUpdateEvent>(_onFightUpdateEvent);
    on<FightUpdateInitialized>(_onFightUpdateInitialized);
  }

  final String eventId;
  final FightRepository _fightRepository;

  void _onFightUpdateEventFightNumAdded(FightUpdateEventFightNumAdded event,
      Emitter<FightUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        updateFightInput:
            state.updateFightInput.copyWith(fightNumber: event.num),
      ),
    );
  }

  void _onFightUpdateEventMeronAdded(FightUpdateEventMeronAdded event,
      Emitter<FightUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        updateFightInput: state.updateFightInput.copyWith(meronId: event.meron),
      ),
    );
  }

  void _onFightUpdateEventWalaAdded(
      FightUpdateEventWalaAdded event, Emitter<FightUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        updateFightInput: state.updateFightInput.copyWith(walaId: event.wala),
      ),
    );
  }

  void _onFightUpdateEventStartTimeAdded(FightUpdateEventStartTimeAdded event,
      Emitter<FightUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        updateFightInput:
            state.updateFightInput.copyWith(startTime: event.startTime),
      ),
    );
  }

  void _onFightDeleted(
      FightDeleted event, Emitter<FightUpdateOrDeleteState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: FightUpdateOrDeleteStatus.loading));
      _fightRepository.deleteFight(eventId: eventId, fightId: event.id);
      emit(state.copyWith(deleteStatus: FightUpdateOrDeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(deleteStatus: FightUpdateOrDeleteStatus.error));
    }
  }

  void _onFightUpdateEvent(
      FightUpdateEvent event, Emitter<FightUpdateOrDeleteState> emit) async {
    try {
      emit(state.copyWith(updateStatus: FightUpdateOrDeleteStatus.loading));
      await _fightRepository.updateFight(
        eventId: eventId,
        fightId: event.id,
        input: state.updateFightInput,
      );
      emit(state.copyWith(updateStatus: FightUpdateOrDeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(updateStatus: FightUpdateOrDeleteStatus.error));
    }
  }

  void _onFightUpdateInitialized(
      FightUpdateInitialized event, Emitter<FightUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        updateFightInput: UpdateFightInput(
          fightNumber: event.fight.fightNumber,
          meronId: event.fight.meronId,
          walaId: event.fight.walaId,
          startTime: event.fight.startTime,
        ),
      ),
    );
  }
}
