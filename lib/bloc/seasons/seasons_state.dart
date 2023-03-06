part of 'seasons_bloc.dart';

abstract class SeasonsState {
  const SeasonsState();
  List<Object> get props =>[];
}

class InitialSeasonsState extends SeasonsState {}

class SeasonsLoading extends SeasonsState {}

class SeasonsLoaded extends SeasonsState {
  final List<dynamic> seasons;
  const SeasonsLoaded(this.seasons);
}

class SeasonsNotLoaded extends SeasonsState {
  final String? errorMessage;
  const SeasonsNotLoaded(this.errorMessage);
}
