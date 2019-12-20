import 'package:flutter/material.dart';
import 'package:movie_db_app/src/bloc/movie_bloc.dart';
import 'package:movie_db_app/src/provider/movie_provider.dart';
import 'package:movie_db_app/src/screens/movie_list_screen.dart';
import 'package:movie_db_app/src/screens/movie_screen.dart';
import 'package:movie_db_app/src/screens/themes.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      movieBloc: MovieBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: MovieListScreen(),
        initialRoute: MovieScreen.routeName,
        routes: {
            MovieListScreen.routeName: (_) => MovieListScreen(),
            MovieScreen.routeName: (_) => MovieScreen()
          },
      ),
    );
  }
}
