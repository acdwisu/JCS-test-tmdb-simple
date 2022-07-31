import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jcs_test/models/movie-item.dart';
import 'package:jcs_test/shared/card-tile.dart';

import '../../injection.dart';
import '../../services/repository/movie-repository.dart';
import '../../services/utils/common.dart';
import '../../services/utils/constant.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  final PagingController<int, MovieItemModel> _pagingController =
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
      final result = await locator<MovieRepository>().upcoming(
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
  Widget build(BuildContext context) {
    return PagedGridView<int, MovieItemModel>(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1/2
        ),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieItemModel>(
          itemBuilder: (context, item, index) {
            final vote = (item.voteAvg * 10).round();

            return CardTile(
              item: CardTileItemModel(
                title: item.title,
                releaseDate: dateFormatter.format(DateTime.parse(item.releaseDate)),
                posterUrl: "$baseUrlImage/w500/${item.posterPath}",
                vote: vote),
              bigItem: true,
            );
          },
        )
    );
  }
}
