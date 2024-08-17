part of '../../di/fighter_service_locator.dart';

class FighterInput extends Equatable {
  const FighterInput({
    required this.name,
    required this.weight,
    required this.breed,
    required this.trainer,
  });

  final String name;
  final int weight;
  final String breed;
  final String trainer;

  factory FighterInput.fromJson(Map<String, dynamic> json) {
    return FighterInput(
      name: json['name'] as String,
      weight: json['weight'] as int,
      breed: json['breed'] as String,
      trainer: json['trainer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'breed': breed,
      'trainer': trainer,
    };
  }

  

  @override
  List<Object> get props => [name, weight, breed, trainer];
}