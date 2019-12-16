import 'package:flutter/widgets.dart';
import 'package:movie_db_app/src/bloc/movie_bloc.dart';


class MovieProvider extends InheritedWidget {
  final MovieBloc movieBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MovieBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<MovieProvider>().movieBloc);

  // Since the Provider wraps a widget we need to define a constructor
  MovieProvider({Key key, MovieBloc movieBloc, Widget child})
      : this.movieBloc = movieBloc ?? MovieBloc(),
        super(child: child, key: key);
}