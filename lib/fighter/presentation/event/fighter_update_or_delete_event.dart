part of '../bloc/fighter_update_or_delete_bloc.dart';

sealed class FighterUpdateOrDeleteEvent extends Equatable {
  const FighterUpdateOrDeleteEvent();

  @override
  List<Object> get props => [];
}

class FighterUpdateEventNameAdded extends FighterUpdateOrDeleteEvent {
  const FighterUpdateEventNameAdded(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class FighterUpdateEventWeightAdded extends FighterUpdateOrDeleteEvent {
  const FighterUpdateEventWeightAdded(this.weight);

  final int weight;

  @override
  List<Object> get props => [weight];
}

class FighterUpdateEventBreedAdded extends FighterUpdateOrDeleteEvent {
  const FighterUpdateEventBreedAdded(this.breed);

  final String breed;

  @override
  List<Object> get props => [breed];
}

class FighterUpdateEventTrainerAdded extends FighterUpdateOrDeleteEvent {
  const FighterUpdateEventTrainerAdded(this.trainer);

  final String trainer;

  @override
  List<Object> get props => [trainer];
}

class FighterDeleted extends FighterUpdateOrDeleteEvent {
  const FighterDeleted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class FighterUpdateEvent extends FighterUpdateOrDeleteEvent {
  const FighterUpdateEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
