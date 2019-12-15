import 'package:flutter/material.dart';
import 'package:movie_db_app/src/screens/movie_screen.dart';


class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Network Handling Demo',
      home: MovieScreen(),
    );
  }
}
