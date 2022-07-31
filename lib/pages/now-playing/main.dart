import 'package:flutter/material.dart';
import 'package:jcs_test/shared/template-movies.dart';

import '../../injection.dart';
import '../../services/repository/movie-repository.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateMovies(
      dataFetcher: (int page) => locator<MovieRepository>().nowPlaying(
        page: page,
      ),
    );
  }
}
