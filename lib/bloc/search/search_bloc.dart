import 'package:desafio_flutter/providers/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  final String query;
  SearchBloc({required this.query}) : super(InitialSearchState()){
    final ApiRepository apiRepository = ApiRepository();
    
    on<FetchSearch>((event,emit)async {
      try{
        emit(SearchLoading());
        final List<dynamic> searchList = await apiRepository.fetchSearchList(query);
        emit(SearchLoaded(searchList));
      }
      on NetworkError {
        emit(const SearchNotLoaded("Failed to fetch data"));
      }
    });
  }
  
}
