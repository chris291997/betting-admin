part of '../../di/fight_service_locator.dart';

class FightOutput extends Equatable implements JsonSerializable {
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
    this.status = '',
    this.isDraw = false,
    this.isCanceled = false,
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
  final String status;
  final bool isDraw;
  final bool isCanceled;

  static const empty = FightOutput();

  bool get isEmpty => this == FightOutput.empty;

  factory FightOutput.fromJson(Map<String, dynamic> json) {
    return FightOutput(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      fightNumber: json['fightNumber'] as int,
      meronId: json['meronId'] as String,
      walaId: json['walaId'] as String,
      startTime: json.parseString('startTime'),
      isLocked: json.parseBool('isLocked'),
      winnerId: json.parseString('winnerId'),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      status: json.parseString('status'),
      isDraw: json.parseBool('isDraw'),
      isCanceled: json.parseBool('isCanceled'),
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
  Map<String, dynamic> toTableJson() {
    final createdAtFormat = DateFormat('MM/dd/yyyy hh:mm:ss aa').format(
      DateTime.parse(createdAt),
    );

    final updatedAtFormat = DateFormat('MM/dd/yyyy hh:mm:ss aa').format(
      DateTime.parse(updatedAt),
    );

    return {
      'fightNumber': fightNumber,
      'startTime': startTime,
      'createdAt': createdAtFormat,
      'updatedAt': updatedAtFormat,
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
