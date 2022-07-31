import 'package:flutter/material.dart';

import '../../injection.dart';
import '../../services/repository/movie-repository.dart';
import '../../shared/template-movies.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateMovies(
      dataFetcher: (int page) => locator<MovieRepository>().popular(
        page: page,
      ),
    );
  }
}
