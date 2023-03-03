part of 'series_bloc.dart';

@immutable
abstract class SeriesState {
  final List? props;
  const SeriesState({this.props}) : super();
}

class InitialSeriesState extends SeriesState {}

class SeriesLoading extends SeriesState {}

class SeriesLoaded extends SeriesState {
  final List? series;

  const SeriesLoaded({this.series}) : super();
}

class SeriesNotLoaded extends SeriesState {}
