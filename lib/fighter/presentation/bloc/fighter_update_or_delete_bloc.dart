import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/fighter_update_or_delete_event.dart';
part '../state/fighter_update_or_delete_state.dart';

class FighterUpdateOrDeleteBloc
    extends Bloc<FighterUpdateOrDeleteEvent, FighterUpdateOrDeleteState> {
  FighterUpdateOrDeleteBloc(this._fighterRepository)
      : super(const FighterUpdateOrDeleteState()) {
    on<FighterUpdateEventNameAdded>(_onFighterUpdateEventNameAdded);
    on<FighterUpdateEventWeightAdded>(_onFighterUpdateEventWeightAdded);
    on<FighterUpdateEventBreedAdded>(_onFighterUpdateEventBreedAdded);
    on<FighterUpdateEventTrainerAdded>(_onFighterUpdateEventTrainerAdded);
    on<FighterDeleted>(_onFighterDeleted);
    on<FighterUpdateEvent>(_onFighterUpdateEvent);
  }

  final FighterRepository _fighterRepository;

  void _onFighterUpdateEventNameAdded(FighterUpdateEventNameAdded event,
      Emitter<FighterUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        fighterUpdateInput: state.fighterUpdateInput.copyWith(name: event.name),
      ),
    );
  }

  void _onFighterUpdateEventWeightAdded(FighterUpdateEventWeightAdded event,
      Emitter<FighterUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        fighterUpdateInput:
            state.fighterUpdateInput.copyWith(weight: event.weight),
      ),
    );
  }

  void _onFighterUpdateEventBreedAdded(FighterUpdateEventBreedAdded event,
      Emitter<FighterUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        fighterUpdateInput:
            state.fighterUpdateInput.copyWith(breed: event.breed),
      ),
    );
  }

  void _onFighterUpdateEventTrainerAdded(FighterUpdateEventTrainerAdded event,
      Emitter<FighterUpdateOrDeleteState> emit) {
    emit(
      state.copyWith(
        fighterUpdateInput:
            state.fighterUpdateInput.copyWith(trainer: event.trainer),
      ),
    );
  }

  void _onFighterDeleted(
      FighterDeleted event, Emitter<FighterUpdateOrDeleteState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: FighterUpdateOrDeleteStatus.loading));
      await _fighterRepository.deleteFighter(fighterId: event.id);
      emit(state.copyWith(deleteStatus: FighterUpdateOrDeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(deleteStatus: FighterUpdateOrDeleteStatus.error));
    }
  }

  void _onFighterUpdateEvent(FighterUpdateEvent event,
      Emitter<FighterUpdateOrDeleteState> emit) async {
    try {
      emit(state.copyWith(updateStatus: FighterUpdateOrDeleteStatus.loading));
      await _fighterRepository.updateFighter(
        input: state.fighterUpdateInput,
        fighterId: event.id,
      );
      emit(state.copyWith(updateStatus: FighterUpdateOrDeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(updateStatus: FighterUpdateOrDeleteStatus.error));
    }
  }
}
