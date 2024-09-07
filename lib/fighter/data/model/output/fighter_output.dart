part of '../../di/fighter_service_locator.dart';

class FighterOutput extends Equatable implements JsonSerializable {
  const FighterOutput({
    this.id = '',
    this.name = '',
    this.weight = 0,
    this.breed = '',
    this.trainer = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  final String id;
  final String name;
  final int weight;
  final String breed;
  final String trainer;
  final String createdAt;
  final String updatedAt;

  static const empty = FighterOutput();

  bool get isEmpty => this == FighterOutput.empty;

  factory FighterOutput.fromJson(Map<String, dynamic> json) {
    return FighterOutput(
      id: json['id'] as String,
      name: json['name'] as String,
      weight: json['weight'] as int,
      breed: json['breed'] as String,
      trainer: json['trainer'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'breed': breed,
      'trainer': trainer,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        weight,
        breed,
        trainer,
        createdAt,
        updatedAt,
      ];

  @override
  Map<String, dynamic> toTableJson() {
    return {
      'name': name,
      'weight': weight,
      'breed': breed,
      'trainer': trainer,
    };
  }
}
