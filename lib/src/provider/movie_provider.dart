import 'package:flutter/widgets.dart';
import 'package:movie_db_app/src/bloc/movie_bloc.dart';


class MovieProvider extends InheritedWidget {
  final MovieBloc movieBloc;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  //this static function basically takes the context of the widget that calls it then it looks up the
  // widget tree because every widget can look up every context above it in the widget tree, so the of function
  // is given a context then looks up the tree to find a widget of type/instance ImageProvider then it is casted back to type
  //  ImageProvider just to let dart know that it is of type ImageProvider. then we pulls the imageBloc property of that widget.
  static MovieBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MovieProvider) as MovieProvider)
          .movieBloc;

  // Since the Provider wraps a widget we need to define a constructor
  MovieProvider({Key key, MovieBloc movieBloc, Widget child})
      : this.movieBloc = movieBloc ?? MovieBloc(),
        super(child: child, key: key);
}