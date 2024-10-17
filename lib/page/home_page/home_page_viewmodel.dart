import 'package:flutter/material.dart';
import 'package:kk_phim/models/latest_list_movie_model.dart';
import 'package:kk_phim/models/list_movie_model.dart';
import 'package:kk_phim/resources/kk_phim_provider.dart';

class HomePageViewmodel extends ChangeNotifier {
  KkPhimProvider api = KkPhimProvider();
  LatestListMovieModel? latestListMovieModel;
  void getListLatestMovie({int limit = 10, int pageIndex = 1}) async {
    latestListMovieModel = await api.getLatestListMovie(pageIndex);
    notifyListeners();
  }

  Future<ListMovieModel> getListMovieByType(
      {required TypeMovie type, int limit = 10, int pageIndex = 1}) async {
    switch (type) {
      case TypeMovie.tvShows:
        return await api.getListMovieByType(
            type: type, pageIndex: pageIndex, limit: limit);

      case TypeMovie.feature:
        return await api.getListMovieByType(
            type: type, pageIndex: pageIndex, limit: limit);

      case TypeMovie.cartoon:
        return await api.getListMovieByType(
            type: type, pageIndex: pageIndex, limit: limit);

      case TypeMovie.tvSeries:
        return await api.getListMovieByType(
            type: type, pageIndex: pageIndex, limit: limit);

    }
  }

  Future<ListMovieModel> getListMovieByKeyword({required String keyword, int limit = 10, int pageIndex = 1}) async {
    return await api.getListMovieByKeyWord(keyword: keyword, limit:  limit, pageIndex: pageIndex);
  }

}
