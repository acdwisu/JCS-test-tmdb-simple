import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jcs_test/models/movie-item.dart';
import 'package:jcs_test/shared/card-tile.dart';

import '../../injection.dart';
import '../../services/repository/movie-repository.dart';
import '../../services/utils/common.dart';
import '../../services/utils/constant.dart';
import '../models/paginated-data.dart';
import '../services/utils/failure.dart';

class TemplateMovies extends StatefulWidget {
  final Future<Either<Failure, PaginatedData<MovieItemModel>>> Function(int) dataFetcher;

  const TemplateMovies({Key? key, required this.dataFetcher}) : super(key: key);

  @override
  _TemplateMoviesState createState() => _TemplateMoviesState();
}

class _TemplateMoviesState extends State<TemplateMovies> {
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
      final result = await widget.dataFetcher(pageKey);

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
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      child: PagedGridView<int, MovieItemModel>(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (MediaQuery.of(context).size.width/165).round(),
            childAspectRatio: 1/2
          ),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieItemModel>(
            itemBuilder: (context, item, index) {
              return CardTile(
                item: item,
                bigItem: true,
              );
            },
          )
      ),
    );
  }
}
