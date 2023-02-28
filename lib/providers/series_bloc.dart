

import 'package:dio/dio.dart';

dynamic onDisplaySeries = [];
List<dynamic> onDisplaySeasons = [];
List<dynamic> onDisplayEpisodes = [];
const sERIES = ['s1','s2','s3'];

void getSeriesApi() async {
  final response = await Dio().get('https://api.tvmaze.com/shows?page=1');
  onDisplaySeries = response.data;
}

void getSeasonsApi(String idSerie) async {
  final response = await Dio().get('https://api.tvmaze.com/shows/$idSerie/seasons');
  onDisplaySeasons = response.data;
}

void getEpisodesApi(String idSeason) async {
  final response = await Dio().get('https://api.tvmaze.com/seasons/$idSeason/episodes');
  onDisplayEpisodes = response.data;
}
class SeriesBloc{
    Stream<List<dynamic>> get getSeries async*{
      getSeriesApi();
      final List<dynamic> series =[];
      for( dynamic serie in onDisplaySeries){
        await Future.delayed(const Duration(milliseconds:500));
        series.add(serie);
        yield series;
      }
    }  
}

class SeasonsBloc{
  final String idShow;

  const SeasonsBloc({required this.idShow});

  Stream<List<dynamic>> get getSeasons async*{
    getSeasonsApi(idShow);
    final List<dynamic> seasons =[];
    for( dynamic season in onDisplaySeasons){
        seasons.add(season);
        yield seasons;
    }
  }  
}

class EpisodesBloc{
  final String idSeason;

  const EpisodesBloc({required this.idSeason});
  
  Stream<List<dynamic>> get getEpisodes async*{
    getEpisodesApi(idSeason);
    final List<dynamic> episodes =[];
    for( dynamic episode in onDisplayEpisodes){
        episodes.add(episode);
        yield episodes;
    }
  }  
}
