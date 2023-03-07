import 'package:desafio_flutter/providers/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState>{
  final int idSeason;
  EpisodesBloc({required this.idSeason}) : super(InitialEpisodesState()){
    final ApiRepository apiRepository = ApiRepository();
    
    on<FetchEpisodes>((event,emit)async {
      try{
        emit(EpisodesLoading());
        final List<dynamic> episodesList = await apiRepository.fetchEpisodesList(idSeason);
        emit(EpisodesLoaded(episodesList));
      }
      on NetworkError {
        emit(const EpisodesNotLoaded("Failed to fetch data"));
      }
    });
  }
  
}
