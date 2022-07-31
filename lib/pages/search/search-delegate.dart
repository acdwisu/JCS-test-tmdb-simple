import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jcs_test/models/movie-item.dart';
import 'package:jcs_test/models/search-result.dart';
import 'package:jcs_test/pages/search/search-result.dart';

import '../../injection.dart';
import '../blocs/detail/detail_bloc.dart';
import '../detail/main.dart';

class MovieSearcher extends SearchDelegate<SearchResultModel?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(
      query: query,
      onSelected: (value) {
        Navigator.push(context, MaterialPageRoute(builder: (context2) {
          return BlocProvider(
            create: (context) => locator<DetailBloc>(),
            child: DetailPage(
              movieItem: MovieItemModel(
                video: value.video,
                releaseDate: value.releaseDate?? '',
                title: value.title,
                id: value.id,
                adult: value.adult,
                backdropPath: value.backdropPath,
                genreIds: value.genreIds,
                originalLang: value.oriLang,
                originalTitle: value.oriTitle,
                overview: value.overview,
                popularity: value.popularity,
                posterPath: value.posterPath,
                voteAvg: value.voteAvg,
                voteCount: value.voteCount,
              ),
            ),
          );
        }));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;

    return theme.copyWith(
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      ),
      hintColor: Colors.white,
      textTheme: theme.textTheme.copyWith(
        headline6: theme.textTheme.headline6?.copyWith(
          color: Colors.white
        )
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.black12,
        selectionHandleColor: Colors.black12,
      )
    );
  }

  @override
  String? get searchFieldLabel => 'Search Here..';
}