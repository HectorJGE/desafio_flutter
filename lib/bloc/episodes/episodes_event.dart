part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesEvent {
  const EpisodesEvent();

  List<Object> get props => [];
}

class FetchSeasons extends EpisodesEvent{}