part of 'series_bloc.dart';

@immutable
abstract class SeriesEvent {
  const SeriesEvent();

  List<Object> get props => [];
}

class FetchSeries extends SeriesEvent{}


