import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:equatable/equatable.dart';

class FightState extends Equatable {
  const FightState({
    this.status = FightStatus.initial,
    this.fight = FightOutput.empty,
  });

  final FightStatus status;
  final FightOutput fight;

  FightState copyWith({
    FightStatus? status,
    FightOutput? fight,
  }) {
    return FightState(
      status: status ?? this.status,
      fight: fight ?? this.fight,
    );
  }

  @override
  List<Object> get props => [status, fight];
}

enum FightStatus { initial, loading, loaded, error }
