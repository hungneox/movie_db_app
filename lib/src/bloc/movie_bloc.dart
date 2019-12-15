import 'dart:async';

import 'package:movie_db_app/src/api/api_response.dart';
import 'package:movie_db_app/src/api/themoviedb_api.dart';
import 'package:movie_db_app/src/models/movie_model.dart';


class MovieBloc {
  TheMovieDbApi _api;

  StreamController _movieListController;
  StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
      _movieListController.sink;
  Stream<ApiResponse<List<Movie>>> get movieListStream =>
      _movieListController.stream;
      

  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _api = TheMovieDbApi();
    fetchMovies();
  }

  fetchMovies([int movieType = 0]) async {
    movieListSink.add(ApiResponse.loading('Fetching In Theater Movies'));
    try {
      List<Movie> movies = (movieType == 0) ? await _api.fetchInTheater() : await _api.fetchTopRated();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController?.close();
  }
}