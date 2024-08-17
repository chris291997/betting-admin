part of '../../di/fighter_service_locator.dart';

class UdpateFighterInput extends FighterInput {
  const UdpateFighterInput({
    required super.name,
    required super.weight,
    required super.breed,
    required super.trainer,
  });

  const UdpateFighterInput.empty()
      : super(
          name: '',
          weight: 0,
          breed: '',
          trainer: '',
        );

  UdpateFighterInput copyWith({
    String? name,
    int? weight,
    String? breed,
    String? trainer,
  }) {
    return UdpateFighterInput(
      name: name ?? super.name,
      weight: weight ?? super.weight,
      breed: breed ?? super.breed,
      trainer: trainer ?? super.trainer,
    );
  }
}
