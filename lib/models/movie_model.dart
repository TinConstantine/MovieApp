import 'list_movie_model.dart';

class MovieModel {
  bool? status;
  String? msg;
  Movie? movie;
  List<Episodes>? episodes;

  MovieModel({this.status, this.msg, this.movie, this.episodes});

  MovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    movie = json['movie'] != null ? new Movie.fromJson(json['movie']) : null;
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(new Episodes.fromJson(v));
      });
    }
  }
}

class Movie {
  Tmdb? tmdb;
  Imdb? imdb;
  Created? created;
  Created? modified;
  String? sId;
  String? name;
  String? slug;
  String? originName;
  String? content;
  String? type;
  String? status;
  String? posterUrl;
  String? thumbUrl;
  bool? isCopyright;
  bool? subDocquyen;
  bool? chieurap;
  String? trailerUrl;
  String? time;
  String? episodeCurrent;
  String? episodeTotal;
  String? quality;
  String? lang;
  String? notify;
  String? showtimes;
  int? year;
  int? view;
  List<String>? actor;
  List<String>? director;
  List<Category>? category;
  List<Country>? country;

  Movie(
      {this.tmdb,
        this.imdb,
        this.created,
        this.modified,
        this.sId,
        this.name,
        this.slug,
        this.originName,
        this.content,
        this.type,
        this.status,
        this.posterUrl,
        this.thumbUrl,
        this.isCopyright,
        this.subDocquyen,
        this.chieurap,
        this.trailerUrl,
        this.time,
        this.episodeCurrent,
        this.episodeTotal,
        this.quality,
        this.lang,
        this.notify,
        this.showtimes,
        this.year,
        this.view,
        this.actor,
        this.director,
        this.category,
        this.country});

  Movie.fromJson(Map<String, dynamic> json) {
    tmdb = json['tmdb'] != null ? new Tmdb.fromJson(json['tmdb']) : null;
    imdb = json['imdb'] != null ? new Imdb.fromJson(json['imdb']) : null;
    created =
    json['created'] != null ? new Created.fromJson(json['created']) : null;
    modified = json['modified'] != null
        ? new Created.fromJson(json['modified'])
        : null;
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    originName = json['origin_name'];
    content = json['content'];
    type = json['type'];
    status = json['status'];
    posterUrl = json['poster_url'];
    thumbUrl = json['thumb_url'];
    isCopyright = json['is_copyright'];
    subDocquyen = json['sub_docquyen'];
    chieurap = json['chieurap'];
    trailerUrl = json['trailer_url'];
    time = json['time'];
    episodeCurrent = json['episode_current'];
    episodeTotal = json['episode_total'];
    quality = json['quality'];
    lang = json['lang'];
    notify = json['notify'];
    showtimes = json['showtimes'];
    year = json['year'];
    view = json['view'];
    actor = json['actor'].cast<String>();
    director = json['director'].cast<String>();
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(new Country.fromJson(v));
      });
    }
  }

}

class Tmdb {
  String? type;
  String? id;
  num? season;
  num? voteAverage;
  num? voteCount;

  Tmdb({this.type, this.id, this.season, this.voteAverage, this.voteCount});

  Tmdb.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    season = json['season'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}

class Imdb {
  Null? id;

  Imdb({this.id});

  Imdb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

}

class Created {
  String? time;

  Created({this.time});

  Created.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

}


class Episodes {
  String? serverName;
  List<ServerData>? serverData;

  Episodes({this.serverName, this.serverData});

  Episodes.fromJson(Map<String, dynamic> json) {
    serverName = json['server_name'];
    if (json['server_data'] != null) {
      serverData = <ServerData>[];
      json['server_data'].forEach((v) {
        serverData!.add(new ServerData.fromJson(v));
      });
    }
  }

}

class ServerData {
  String? name;
  String? slug;
  String? filename;
  String? linkEmbed;
  String? linkM3u8;

  ServerData(
      {this.name, this.slug, this.filename, this.linkEmbed, this.linkM3u8});

  ServerData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    filename = json['filename'];
    linkEmbed = json['link_embed'];
    linkM3u8 = json['link_m3u8'];
  }
}
