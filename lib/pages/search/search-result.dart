import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jcs_test/injection.dart';
import 'package:jcs_test/services/repository/movie-repository.dart';

import '../../models/search-result.dart';

class SearchResult extends StatefulWidget {
  final String query;
  final void Function(SearchResultModel) onSelected;

  const SearchResult({Key? key, required this.query, required this.onSelected,}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final PagingController<int, SearchResultModel> _pagingController =
    PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final result = await locator<MovieRepository>().search(
        query: widget.query,
        page: pageKey,
      );

      result.fold(
        (l) => throw l,
        (r) {
          final items = r.data;

          final isLastPage = pageKey == r.totalPages;

          if (isLastPage) {
            _pagingController.appendLastPage(items.toList());
          } else {
            final nextPageKey = pageKey + 1;

            _pagingController.appendPage(items.toList(), nextPageKey);
          }

        }
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void didUpdateWidget(covariant SearchResult oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.query.isEmpty) {
      _pagingController..itemList = []..error = null..nextPageKey=1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, SearchResultModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<SearchResultModel>(
        itemBuilder: (context, item, index) => ListTile(
          title: Text(
            item.title
          ),
          onTap: () => widget.onSelected(item),
        ),
      )
    );
  }
}
