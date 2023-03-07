part of 'search_bloc.dart';

abstract class SearchState {
  const SearchState();
  List<Object> get props =>[];
}

class InitialSearchState extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<dynamic> search;
  const SearchLoaded(this.search);
}

class SearchNotLoaded extends SearchState {
  final String? errorMessage;
  const SearchNotLoaded(this.errorMessage);
}
