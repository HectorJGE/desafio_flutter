part of 'episodes_bloc.dart';

abstract class EpisodesState {
  const EpisodesState();
  List<Object> get props =>[];
}

class InitialEpisodesState extends EpisodesState {}

class EpisodesLoading extends EpisodesState {}

class EpisodesLoaded extends EpisodesState {
  final List<dynamic> episodes;
  const EpisodesLoaded(this.episodes);
}

class EpisodesNotLoaded extends EpisodesState {
  final String? errorMessage;
  const EpisodesNotLoaded(this.errorMessage);
}
