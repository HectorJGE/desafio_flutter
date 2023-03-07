part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();

  List<Object> get props => [];
}

class FetchSearch extends SearchEvent{}