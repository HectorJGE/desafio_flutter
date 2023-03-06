import 'package:desafio_flutter/models/serie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class   ApiProvider {
  final Dio dio = Dio();
  final String url = 'https://api.tvmaze.com/shows?page=0';

  Future<Series> fetchSeriesList() async {
    try{
      Response response = await dio.get(url);
      List<Series> series;
      return Series.fromJson(response.data);
    }catch(error, stacktrace){
      if(kDebugMode){
        print("Exception ocurred: $error stacktrace: $stacktrace");
      }
      return Series.withError("Data not found / Connection issue");
    }
  }
}