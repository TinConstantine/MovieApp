import 'package:flutter/cupertino.dart';
import 'package:kk_phim/models/movie_model.dart';
import 'package:kk_phim/resources/kk_phim_provider.dart';

class DetailMovieViewmodel extends ChangeNotifier{
  MovieModel? movieModel;
  Future<void> getDetailMovie(String slugMovie)async{
      movieModel = await KkPhimProvider().getDetailMovie(slugMovie);
      print(movieModel.toString());
      notifyListeners();
  }
}