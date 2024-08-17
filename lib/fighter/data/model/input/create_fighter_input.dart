part of '../../di/fighter_service_locator.dart';

class CreateFighterInput extends FighterInput {
  const CreateFighterInput({
    required super.name,
    required super.weight,
    required super.breed,
    required super.trainer,
  });

  const CreateFighterInput.empty()
      : super(
          name: '',
          weight: 0,
          breed: '',
          trainer: '',
        );

  CreateFighterInput copyWith({
    String? name,
    int? weight,
    String? breed,
    String? trainer,
  }) {
    return CreateFighterInput(
      name: name ?? super.name,
      weight: weight ?? super.weight,
      breed: breed ?? super.breed,
      trainer: trainer ?? super.trainer,
    );
  }
}
