part of 'seasons_bloc.dart';

@immutable
abstract class SeasonsEvent {
  const SeasonsEvent();

  List<Object> get props => [];
}

class FetchSeasons extends SeasonsEvent{}