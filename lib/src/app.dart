import 'package:flutter/material.dart';
import 'package:movie_db_app/src/bloc/movie_bloc.dart';
import 'package:movie_db_app/src/provider/movie_provider.dart';
import 'package:movie_db_app/src/screens/movie_detail_screen.dart';
import 'package:movie_db_app/src/screens/movie_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      movieBloc: MovieBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.grey[850],
          accentColor: Colors.amber,
        ),
        home: MovieScreen(),
        routes: {
            MovieScreen.routeName: (_) => MovieScreen(),
            MovieDetailPage.routeName: (_) => MovieDetailPage()
          },
      ),
    );
  }
}
