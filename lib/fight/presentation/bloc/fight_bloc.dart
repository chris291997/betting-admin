import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bet/fight/presentation/event/fight_event.dart';
import 'package:bet/fight/presentation/state/fight_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

class FightBloc extends Bloc<FightEvent, FightState>
    with BlocPresentationMixin<FightState, FightEvent> {
  FightBloc(this._fightRepository) : super(const FightState()) {
    on<FightRequested>(_onFightRequested);
    on<FightStarted>(_onFightStarted);
    on<FightConcluded>(_onFightConcluded);
    on<FightDrawn>(_onFightDrawn);
    on<FightCanceled>(_onFightCanceled);
    on<FightOpenedBets>(_onFightOpenedBets);
    on<FightClosedBets>(_onFightClosedBets);
  }

  final FightRepository _fightRepository;

  Future<void> _onFightRequested(
    FightRequested event,
    Emitter<FightState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FightStatus.loading));
      final fight = await _fightRepository.getFightById(
          eventId: event.eventId, fightId: event.fightId);
      emit(state.copyWith(status: FightStatus.loaded, fight: fight));
    } catch (e) {
      emit(state.copyWith(status: FightStatus.error));
    }
  }

  Future<void> _onFightStarted(
      FightStarted event, Emitter<FightState> emit) async {
    try {
      if (state.fight.isEmpty) return;

      emit(state.copyWith(status: FightStatus.loading));
      await _fightRepository.startFight(
        eventId: state.fight.eventId,
        fightId: state.fight.id,
      );

      add(
        FightRequested(
          eventId: state.fight.eventId,
          fightId: state.fight.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FightStatus.error));
    }
  }

  Future<void> _onFightConcluded(
      FightConcluded event, Emitter<FightState> emit) async {
    try {
      if (state.fight.isEmpty) return;

      emit(state.copyWith(status: FightStatus.loading));
      await _fightRepository.concludeFight(
        eventId: state.fight.eventId,
        fightId: state.fight.id,
        winnerId: event.winnerId,
      );

      add(
        FightRequested(
          eventId: state.fight.eventId,
          fightId: state.fight.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FightStatus.error));
    }
  }

  Future<void> _onFightDrawn(FightDrawn event, Emitter<FightState> emit) async {
    try {
      if (state.fight.isEmpty) return;

      emit(state.copyWith(status: FightStatus.loading));
      await _fightRepository.drawFight(
        eventId: state.fight.eventId,
        fightId: state.fight.id,
      );

      add(
        FightRequested(
          eventId: state.fight.eventId,
          fightId: state.fight.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FightStatus.error));
    }
  }

  Future<void> _onFightCanceled(
      FightCanceled event, Emitter<FightState> emit) async {
    try {
      if (state.fight.isEmpty) return;

      emit(state.copyWith(status: FightStatus.loading));
      await _fightRepository.cancelFight(
        eventId: state.fight.eventId,
        fightId: state.fight.id,
      );

      add(
        FightRequested(
          eventId: state.fight.eventId,
          fightId: state.fight.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FightStatus.error));
    }
  }

  Future<void> _onFightOpenedBets(
      FightOpenedBets event, Emitter<FightState> emit) async {
    try {
      if (state.fight.isEmpty) return;

      emit(state.copyWith(status: FightStatus.loading));
      await _fightRepository.openBets(
        eventId: state.fight.eventId,
        fightId: state.fight.id,
      );

      add(
        FightRequested(
          eventId: state.fight.eventId,
          fightId: state.fight.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FightStatus.error));
    }
  }

  Future<void> _onFightClosedBets(
      FightClosedBets event, Emitter<FightState> emit) async {
    try {
      if (state.fight.isEmpty) return;

      emit(state.copyWith(status: FightStatus.loading));
      await _fightRepository.closeBets(
        eventId: state.fight.eventId,
        fightId: state.fight.id,
      );

      add(
        FightRequested(
          eventId: state.fight.eventId,
          fightId: state.fight.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FightStatus.error));
    }
  }
}
