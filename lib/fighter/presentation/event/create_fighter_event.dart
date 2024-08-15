part of '../bloc/create_fighter_bloc.dart';

sealed class CreateFighterEvent extends Equatable {
  const CreateFighterEvent();

  @override
  List<Object> get props => [];
}

class FighterCreateEventNameAdded extends CreateFighterEvent {
  const FighterCreateEventNameAdded(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class FighterCreateEventWeightAdded extends CreateFighterEvent {
  const FighterCreateEventWeightAdded(this.weight);

  final int weight;

  @override
  List<Object> get props => [weight];
}

class FighterCreateEventBreedAdded extends CreateFighterEvent {
  const FighterCreateEventBreedAdded(this.breed);

  final String breed;

  @override
  List<Object> get props => [breed];
}

class FighterCreateEventTrainerAdded extends CreateFighterEvent {
  const FighterCreateEventTrainerAdded(this.trainer);

  final String trainer;

  @override
  List<Object> get props => [trainer];
}

class FighterCreated extends CreateFighterEvent {}
