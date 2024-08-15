import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/fight_list_event.dart';
part '../state/fight_list_state.dart';

class FightListBloc extends Bloc<FightListEvent, FightListState> {
  FightListBloc(this._fightRepository) : super(const FightListState()) {
    on<FightListFetched>(_onFightListFetched);
  }

  final FightRepository _fightRepository;

  void _onFightListFetched(
      FightListFetched event, Emitter<FightListState> emit) async {
    emit(state.copyWith(status: FightListStatus.loading));

    final fights = await _fightRepository.getFights(eventId: event.eventId);

    emit(state.copyWith(status: FightListStatus.loaded, fights: fights));
  }
}
