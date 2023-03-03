part of 'series_bloc.dart';

@immutable
abstract class SeriesEvent {
  final List? props;
  const SeriesEvent({this.props}) : super();
}

class FetchSeries extends SeriesEvent{}


