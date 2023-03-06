// To parse this JSON data, do
//
//     final series = seriesFromMap(jsonString);

class Series {
  int? id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  String? status;
  int? runtime;
  int? averageRuntime;
  String? premiered;
  String? ended;
  String? officialSite;
  Schedule? schedule;
  Rating? rating;
  int? weight;
  Network? network;
  String? webChannel;
  String? dvdCountry;
  Externals? externals;
  Image? image;
  String? summary;
  int? updated;
  Links? lLinks;
  String? error;

  Series(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.language,
      this.genres,
      this.status,
      this.runtime,
      this.averageRuntime,
      this.premiered,
      this.ended,
      this.officialSite,
      this.schedule,
      this.rating,
      this.weight,
      this.network,
      this.webChannel,
      this.dvdCountry,
      this.externals,
      this.image,
      this.summary,
      this.updated,
      this.lLinks});

    Series.withError(String errorMessage){
      error=errorMessage;
    }
    
    Series.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      url = json['url'];
      name = json['name'];
      type = json['type'];
      language = json['language'];
      genres = json['genres'].cast<String>();
      status = json['status'];
      runtime = json['runtime'];
      averageRuntime = json['averageRuntime'];
      premiered = json['premiered'];
      ended = json['ended'];
      officialSite = json['officialSite'];
      schedule = json['schedule'] != null
          ? Schedule.fromJson(json['schedule'])
          : null;
      rating =
          json['rating'] != null ? Rating.fromJson(json['rating']) : null;
      weight = json['weight'];
      network =
          json['network'] != null ? Network.fromJson(json['network']) : null;
      webChannel = json['webChannel'];
      dvdCountry = json['dvdCountry'];
      externals = json['externals'] != null
          ? Externals.fromJson(json['externals'])
          : null;
      image = json['image'] != null ? Image.fromJson(json['image']) : null;
      summary = json['summary'];
      updated = json['updated'];
      lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
    }

}

class Schedule {
  String? time;
  List<String>? days;

  Schedule({required this.time, required this.days});

  Schedule.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    days = json['days'].cast<String>();
  }
}

class Rating {
  double? average;

  Rating({this.average});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
  }

}

class Network {
  int? id;
  String? name;
  Country? country;
  String? officialSite;

  Network({this.id, this.name, this.country, this.officialSite});

  Network.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    officialSite = json['officialSite'];
  }
}

class Country {
  String? name;
  String? code;
  String? timezone;

  Country({this.name, this.code, this.timezone});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    timezone = json['timezone'];
  }
}

class Externals {
  int? tvrage;
  int? thetvdb;
  String? imdb;

  Externals({this.tvrage, this.thetvdb, this.imdb});

  Externals.fromJson(Map<String, dynamic> json) {
    tvrage = json['tvrage'];
    thetvdb = json['thetvdb'];
    imdb = json['imdb'];
  }
}

class Image {
  String? medium;
  String? original;

  Image({this.medium, this.original});

  Image.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }
}

class Links {
  Self? self;
  Self? previousepisode;

  Links({this.self, this.previousepisode});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? Self.fromJson(json['self']) : null;
    previousepisode = json['previousepisode'] != null
        ? Self.fromJson(json['previousepisode'])
        : null;
  }

}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

}
