part of '../../di/fight_service_locator.dart';

class UpdateFightInput extends FightInput {
  const UpdateFightInput({
    required super.fightNumber,
    required super.meronId,
    required super.walaId,
    required super.startTime,
  });

  UpdateFightInput copyWith({
    int? fightNumber,
    String? meronId,
    String? walaId,
    String? startTime,
  }) {
    return UpdateFightInput(
      fightNumber: fightNumber ?? this.fightNumber,
      meronId: meronId ?? this.meronId,
      walaId: walaId ?? this.walaId,
      startTime: startTime ?? this.startTime,
    );
  }

  const UpdateFightInput.empty()
      : super(
          fightNumber: 0,
          meronId: '',
          walaId: '',
          startTime: '',
        );
}
