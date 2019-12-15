import 'dart:async';

import 'package:movie_db_app/src/helpers/api_helper.dart';
import 'package:movie_db_app/src/models/movie_model.dart';

class TheMovieDbApi {
  final String _apiKey = "1325cb6ab541d496586e5d0484247cb4";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchInTheater() async {
    List<Movie> movies = [];
    final response = await _helper.get("movie/now_playing?api_key=$_apiKey");
    final List results = response['results'];
    results.forEach((result) => movies.add(Movie.fromJson(result)));
    return movies;
  }

  Future<List<Movie>> fetchTopRated() async {
    List<Movie> movies = [];
    final response = await _helper.get("movie/top_rated?api_key=$_apiKey");
    final List results = response['results'];
    results.forEach((result) => movies.add(Movie.fromJson(result)));
    return movies;
  }
}
