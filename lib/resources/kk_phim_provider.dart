import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:kk_phim/models/latest_list_movie_model.dart';

import '../models/list_movie_model.dart';
import '../models/movie_model.dart';

class KkPhimProvider {
  Client client = Client();
  static const baseUrl = "https://phimapi.com/";
  static const imgUrl = "https://phimimg.com";

  Future<LatestListMovieModel> getLatestListMovie([int pageIndex = 1]) async {
    final res = await client.get(
        Uri.parse("${baseUrl}danh-sach/phim-moi-cap-nhat?page=$pageIndex"));
    if (res.statusCode == 200) {
      return LatestListMovieModel.fromJson(json.decode(res.body));
    } else {
      throw Exception("Failed to load post: ${res.body}");
    }
  }

  Future<ListMovieModel> getListMovieByType(
      {required TypeMovie type, int limit = 10, int pageIndex = 1}) async {
    final res = await client.get(Uri.parse(
        "${baseUrl}v1/api/danh-sach/${type.category}?page=$pageIndex&limit=$limit"));
    if (res.statusCode == 200) {
      return ListMovieModel.fromJson(json.decode(res.body));
    } else {
      throw Exception("Failed to load post: ${res.body}");
    }
  }

  Future<ListMovieModel> getListMovieByKeyWord(
      {required String keyword, int limit = 10, int pageIndex = 1}) async {
    final res = await client
        .get(Uri.parse("${baseUrl}v1/api/tim-kiem?keyword=$keyword&page=$pageIndex"));
    if (res.statusCode == 200) {
      return ListMovieModel.fromJson(json.decode(res.body));
    } else {
      throw Exception("Failed to load post");
    }
  }

  Future<MovieModel> getDetailMovie(String slugMovie) async {
    final res = await client.get(Uri.parse("${baseUrl}phim/$slugMovie"));
    if (res.statusCode == 200) {
      return MovieModel.fromJson(json.decode(res.body));
    } else {
      throw Exception("Failed to load movie");
    }
  }
}
