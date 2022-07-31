import 'package:flutter/material.dart';
import 'package:jcs_test/models/search-result.dart';
import 'package:jcs_test/pages/search/search-result.dart';

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
      onSelected: (value) => close(context, value),
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