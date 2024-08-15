import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/create_fighter_event.dart';
part '../state/create_fighter_state.dart';

class CreateFighterBloc extends Bloc<CreateFighterEvent, CreateFighterState> {
  CreateFighterBloc(this._fighterRepository)
      : super(const CreateFighterState()) {
    on<FighterCreateEventNameAdded>(_onFighterCreateEventNameAdded);
    on<FighterCreateEventWeightAdded>(_onFighterCreateEventWeightAdded);
    on<FighterCreateEventBreedAdded>(_onFighterCreateEventBreedAdded);
    on<FighterCreateEventTrainerAdded>(_onFighterCreateEventTrainerAdded);
    on<FighterCreated>(_onFighterCreated);
  }

  final FighterRepository _fighterRepository;

  void _onFighterCreateEventNameAdded(
    FighterCreateEventNameAdded event,
    Emitter<CreateFighterState> emit,
  ) {
    emit(
      state.copyWith(
        fighterInput: state.fighterInput.copyWith(name: event.name),
      ),
    );
  }

  void _onFighterCreateEventWeightAdded(
    FighterCreateEventWeightAdded event,
    Emitter<CreateFighterState> emit,
  ) {
    emit(
      state.copyWith(
        fighterInput: state.fighterInput.copyWith(weight: event.weight),
      ),
    );
  }

  void _onFighterCreateEventBreedAdded(
    FighterCreateEventBreedAdded event,
    Emitter<CreateFighterState> emit,
  ) {
    emit(
      state.copyWith(
        fighterInput: state.fighterInput.copyWith(breed: event.breed),
      ),
    );
  }

  void _onFighterCreateEventTrainerAdded(
    FighterCreateEventTrainerAdded event,
    Emitter<CreateFighterState> emit,
  ) {
    emit(
      state.copyWith(
        fighterInput: state.fighterInput.copyWith(trainer: event.trainer),
      ),
    );
  }

  void _onFighterCreated(
    FighterCreated event,
    Emitter<CreateFighterState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateFighterStatus.loading));

      await _fighterRepository.createFighter(input: state.fighterInput);

      emit(
        state.copyWith(
          status: CreateFighterStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: CreateFighterStatus.error));
    }
  }
}
