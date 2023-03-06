import 'package:desafio_flutter/providers/api_provider.dart';

class ApiRepository {

  final _provider = ApiProvider();
  Future<List> fetchSeriesList(){
    return _provider.fetchSeriesList(0);
  }
  
  Future<List> fetchSeasonsList(nro){
    return _provider.fetchSeasonsList(nro);
  }

  Future<List> fetchEpisodesList(nro){
    return _provider.fetchEpisodesList(nro);
  }

  Future<List> fetchSearchList(query){
    return _provider.fetchSearchList(query);
  }
}

class NetworkError extends Error {}