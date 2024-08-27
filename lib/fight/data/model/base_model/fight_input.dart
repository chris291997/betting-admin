part of '../../di/fight_service_locator.dart';

class FightInput extends Equatable {
  const FightInput({
    required this.fightNumber,
    required this.meronId,
    required this.walaId,
    required this.startTime,
  });

  final int fightNumber;
  final String meronId;
  final String walaId;
  final String startTime;

  factory FightInput.fromJson(Map<String, dynamic> json) {
    return FightInput(
      fightNumber: json['fightNumber'] as int,
      meronId: json['meronId'] as String,
      walaId: json['walaId'] as String,
      startTime: json['startTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meronId': meronId,
      'walaId': walaId,
      'startTime': startTime,
    };
  }

  @override
  List<Object> get props => [fightNumber, meronId, walaId, startTime];
}
