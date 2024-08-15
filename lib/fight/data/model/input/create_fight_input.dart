part of '../../di/fight_service_locator.dart';

class CreateFightInput extends FightInput {
  const CreateFightInput({
    required super.fightNumber,
    required super.meronId,
    required super.walaId,
    required super.startTime,
  });

  CreateFightInput copyWith({
    int? fightNumber,
    String? meronId,
    String? walaId,
    String? startTime,
  }) {
    return CreateFightInput(
      fightNumber: fightNumber ?? this.fightNumber,
      meronId: meronId ?? this.meronId,
      walaId: walaId ?? this.walaId,
      startTime: startTime ?? this.startTime,
    );
  }

  const CreateFightInput.empty()
      : super(
          fightNumber: 0,
          meronId: '',
          walaId: '',
          startTime: '',
        );
}
