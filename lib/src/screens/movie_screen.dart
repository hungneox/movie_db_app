import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/src/provider/movie_provider.dart';
import 'package:movie_db_app/src/screens/movie_screen_args.dart';
import 'package:movie_db_app/src/screens/themes.dart';

class MovieScreen extends StatelessWidget {
  static const routeName = "/movie";

  Widget renderPoster(String posterPath) {
    if (posterPath == null) {
      return Text("No Poster");
    }

    return Image.network(
      'https://image.tmdb.org/t/p/w342${posterPath}',
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MovieScreenArguments args = ModalRoute.of(context).settings.arguments;
    final _movieBloc = MovieProvider.of(context);
    final movie = _movieBloc.findMovieById(args?.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: TextStyle(color: darkTheme.accentColor),
        ),
        backgroundColor: darkTheme.backgroundColor,
      ),
      backgroundColor: darkTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: renderPoster(movie.posterPath),
              ),
              Card(
                child: Text(movie.overview)
              )
            ],
          ),
        ),
      ),
    );
  }
}
