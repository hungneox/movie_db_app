class Movie {
  int id;
  String title;
  String overview;
  String backdropPath;
  String posterPath;

  Movie(this.id, this.title, this.overview, this.backdropPath);

  Movie.fromJson(Map parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    overview = parsedJson['overview'];
    backdropPath = parsedJson['backdrop_path'];
    posterPath = parsedJson['poster_path'];
  }
}
