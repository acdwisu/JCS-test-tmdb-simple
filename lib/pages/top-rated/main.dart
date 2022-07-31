import 'package:flutter/material.dart';

import '../../injection.dart';
import '../../services/repository/movie-repository.dart';
import '../../shared/template-movies.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  _TopRatedPageState createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateMovies(
      dataFetcher: (int page) => locator<MovieRepository>().topRated(
        page: page,
      ),
    );
  }
}
