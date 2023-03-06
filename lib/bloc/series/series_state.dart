part of 'series_bloc.dart';

@immutable
abstract class SeriesState {
  const SeriesState();
  List<Object> get props =>[];
}

class InitialSeriesState extends SeriesState {}

class SeriesLoading extends SeriesState {}

class SeriesLoaded extends SeriesState {
  final List<dynamic> series;
  const SeriesLoaded(this.series);
}

class SeriesNotLoaded extends SeriesState {
  final String? errorMessage;
  const SeriesNotLoaded(this.errorMessage);
}