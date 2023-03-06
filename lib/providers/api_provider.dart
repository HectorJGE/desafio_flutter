import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio dio = Dio();
  
  final String url = 'https://api.tvmaze.com';

  Future<List> fetchSeriesList(int nro) {
    return fetch('$url/shows?page=$nro');
  }

  Future<List> fetchSeasonsList(int nro) {
    return fetch('$url/shows/$nro/seasons');
  }

  Future<List> fetchEpisodesList(int nro) {
    return fetch('$url/episodes/$nro');
  }
  
  Future<List> fetchSearchList(String query) {
    return fetch('$url/search/shows?q=$query');
  }
  
  Future<List> fetch(urlEP)async {
    try{
      Response response = await dio.get(urlEP);
      return response.data;
    }catch(error, stacktrace){
      if(kDebugMode){
        print("Exception ocurred: $error stacktrace: $stacktrace");
      }
      return [];
    }
  }
}