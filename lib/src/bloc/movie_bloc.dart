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

  StreamController _topRatedController;
  StreamSink<ApiResponse<List<Movie>>> get topRatedSink =>
      _topRatedController.sink;
  Stream<ApiResponse<List<Movie>>> get topRatedStream =>
      _topRatedController.stream;

  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _topRatedController = StreamController<ApiResponse<List<Movie>>>();
    _api = TheMovieDbApi();
    fetchTopRated();
    fetchInTheater();
  }
  
  fetchInTheater() async {
    movieListSink.add(ApiResponse.loading('Fetching In Theater Movies'));
    try {
      List<Movie> movies = await _api.fetchInTheater();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTopRated() async {
    topRatedSink.add(ApiResponse.loading('Fetching Top Rated Movies'));
    try {
      List<Movie> movies = await _api.fetchTopRated();
      topRatedSink.add(ApiResponse.completed(movies));
    } catch (e) {
      topRatedSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController?.close();
    _topRatedController?.close();
  }
}
