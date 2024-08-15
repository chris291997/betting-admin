import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/fighter_list_event.dart';
part '../state/fighter_list_state.dart';

class FighterListBloc extends Bloc<FighterListEvent, FighterListState> {
  FighterListBloc(this._fighterRepository) : super(const FighterListState()) {
    on<FighterListFetched>(_onFighterListFetched);
  }

  final FighterRepository _fighterRepository;

  void _onFighterListFetched(
      FighterListFetched event, Emitter<FighterListState> emit) async {
    try {
      emit(state.copyWith(status: FighterListStatus.loading));

      final fighters = await _fighterRepository.getFighters();

      emit(
          state.copyWith(status: FighterListStatus.loaded, fighters: fighters));
    } catch (e) {
      emit(state.copyWith(status: FighterListStatus.error));
    }
  }
}
