import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/src/api/api_response.dart';
import 'package:movie_db_app/src/bloc/movie_bloc.dart';
import 'package:movie_db_app/src/models/movie_model.dart';
import 'package:movie_db_app/src/provider/movie_provider.dart';
import 'package:movie_db_app/src/screens/movie_screen.dart';
import 'package:movie_db_app/src/screens/movie_screen_args.dart';

class MovieListScreen extends StatefulWidget {
  static const routeName = "/movies";

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

const List<BottomNavigationBarItem> bottomNavigationBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.theaters),
    title: Text('In theater'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.star),
    title: Text('Top Rated'),
  ),
];

class _MovieListScreenState extends State<MovieListScreen> {
  int _selectedIndex = 0;

  Widget inTheaterList(MovieBloc _bloc) {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchInTheater(),
      child: StreamBuilder<ApiResponse<List<Movie>>>(
        stream: _bloc.movieListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return MovieList(movieList: snapshot.data.data);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchInTheater(),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget topRatedList(MovieBloc _bloc) {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchTopRated(),
      child: StreamBuilder<ApiResponse<List<Movie>>>(
        stream: _bloc.topRatedStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return MovieList(movieList: snapshot.data.data);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchTopRated(),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _movieBloc = MovieProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('TMDB App',
            style: TextStyle(color: Theme.of(context).accentColor)),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: IndexedStack(
        index: _selectedIndex,
        sizing: StackFit.expand,
        children: [inTheaterList(_movieBloc), topRatedList(_movieBloc)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        unselectedItemColor: Colors.grey,
        items: bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieScreen.routeName,
                    arguments: MovieScreenArguments(movieList[index].id),
                  );
                },
                child: Image.network(
                  'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Theme.of(context).backgroundColor,
            child: Text('Retry',
                style: TextStyle(color: Theme.of(context).accentColor)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          ),
        ],
      ),
    );
  }
}
