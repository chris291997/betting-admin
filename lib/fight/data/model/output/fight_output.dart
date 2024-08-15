part of '../../di/fight_service_locator.dart';

class FightOutput extends Equatable {
  const FightOutput({
    this.id = '',
    this.eventId = '',
    this.fightNumber = 0,
    this.meronId = '',
    this.walaId = '',
    this.startTime = '',
    this.isLocked = false,
    this.winnerId = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  final String id;
  final String eventId;
  final int fightNumber;
  final String meronId;
  final String walaId;
  final String startTime;
  final bool isLocked;
  final String winnerId;
  final String createdAt;
  final String updatedAt;

  static const empty = FightOutput();

  bool get isEmpty => this == FightOutput.empty;

  factory FightOutput.fromJson(Map<String, dynamic> json) {
    return FightOutput(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      fightNumber: json['fightNumber'] as int,
      meronId: json['meronId'] as String,
      walaId: json['walaId'] as String,
      startTime: json['startTime'] as String,
      isLocked: json['isLocked'] as bool,
      winnerId: json['winnerId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'fightNumber': fightNumber,
      'meronId': meronId,
      'walaId': walaId,
      'startTime': startTime,
      'isLocked': isLocked,
      'winnerId': winnerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object> get props => [
        id,
        eventId,
        fightNumber,
        meronId,
        walaId,
        startTime,
        isLocked,
        winnerId,
        createdAt,
        updatedAt,
      ];
}













