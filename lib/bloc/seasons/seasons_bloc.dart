import 'package:desafio_flutter/providers/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'seasons_event.dart';
part 'seasons_state.dart';

class SeasonsBloc extends Bloc<SeasonsEvent, SeasonsState>{
  final int idShow;
  SeasonsBloc({required this.idShow}) : super(InitialSeasonsState()){
    final ApiRepository apiRepository = ApiRepository();
    
    on<FetchSeasons>((event,emit)async {
      try{
        emit(SeasonsLoading());
        final List<dynamic> seasonsList = await apiRepository.fetchSeasonsList(idShow);
        emit(SeasonsLoaded(seasonsList));
      }
      on NetworkError {
        emit(const SeasonsNotLoaded("Failed to fetch data"));
      }
    });
  }
  
}
