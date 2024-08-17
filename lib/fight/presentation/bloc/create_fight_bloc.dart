import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/create_fight_event.dart';
part '../state/create_fight_state.dart';

class CreateFightBloc extends Bloc<CreateFightEvent, CreateFightState> {
  CreateFightBloc(this._fightRepository, this.eventId)
      : super(CreateFightState(eventId: eventId)) {
    on<FightCreateEventFightNumAdded>(_onFightCreateEventFightNumAdded);
    on<FightCreateEventMeronAdded>(_onFightCreateEventMeronAdded);
    on<FightCreateEventWalaAdded>(_onFightCreateEventWalaAdded);
    on<FightCreateEventStartTimeAdded>(_onFightCreateEventStartTimeAdded);
    on<FightCreated>(_onFightCreated);
  }

  final FightRepository _fightRepository;
  final String eventId;

  void _onFightCreateEventFightNumAdded(
      FightCreateEventFightNumAdded event, Emitter<CreateFightState> emit) {
    emit(
      state.copyWith(
        fightInput: state.fightInput.copyWith(fightNumber: event.num),
      ),
    );
  }

  void _onFightCreateEventMeronAdded(
      FightCreateEventMeronAdded event, Emitter<CreateFightState> emit) {
    emit(
      state.copyWith(
        fightInput: state.fightInput.copyWith(meronId: event.meron),
      ),
    );
  }

  void _onFightCreateEventWalaAdded(
      FightCreateEventWalaAdded event, Emitter<CreateFightState> emit) {
    emit(
      state.copyWith(
        fightInput: state.fightInput.copyWith(walaId: event.wala),
      ),
    );
  }

  void _onFightCreateEventStartTimeAdded(
      FightCreateEventStartTimeAdded event, Emitter<CreateFightState> emit) {
    emit(
      state.copyWith(
        fightInput: state.fightInput.copyWith(startTime: event.startTime),
      ),
    );
  }

  void _onFightCreated(FightCreated event, Emitter<CreateFightState> emit) {
    try {
      emit(state.copyWith(status: CreateFightStatus.loading));
      _fightRepository.createFight(
        eventId: eventId,
        input: state.fightInput,
      );
      emit(state.copyWith(status: CreateFightStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateFightStatus.error));
    }
  }
}
