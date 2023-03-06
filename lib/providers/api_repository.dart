  

import 'package:desafio_flutter/models/serie.dart';
import 'package:desafio_flutter/providers/api_provider.dart';

class ApiRepository {

  final _provider = ApiProvider();
  Future<Series> fetchSeriesList(){
    return _provider.fetchSeriesList();
  }
}

class NetworkError extends Error {}