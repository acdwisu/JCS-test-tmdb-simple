import 'package:flutter/material.dart';

import '../../injection.dart';
import '../../services/repository/movie-repository.dart';
import '../../shared/template-movies.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateMovies(
      dataFetcher: (int page) => locator<MovieRepository>().upcoming(
        page: page,
      ),
    );
  }
}
