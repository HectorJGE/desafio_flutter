import 'package:desafio_flutter/providers/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'series_event.dart';
part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState>{
  SeriesBloc() : super(InitialSeriesState()){
    final ApiRepository apiRepository = ApiRepository();
    
    on<FetchSeries>((event,emit)async {
      try{
        emit(SeriesLoading());
        final List<dynamic> seriesList = await apiRepository.fetchSeriesList();
        emit(SeriesLoaded(seriesList));
      }
      on NetworkError {
        emit(const SeriesNotLoaded("Failed to fetch data"));
      }
    });
  }
  
}
