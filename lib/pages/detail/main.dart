import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jcs_test/models/movie-item.dart';
import 'package:jcs_test/models/request-state-enum.dart';
import 'package:jcs_test/pages/blocs/detail/detail_bloc.dart';
import 'package:jcs_test/services/utils/constant.dart';
import 'package:collection/collection.dart';

import '../../services/utils/common.dart';
import '../../shared/video-player-iframe.dart';

class DetailPage extends StatefulWidget {
  final MovieItemModel movieItem;

  const DetailPage({Key? key, required this.movieItem}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final textTheme = Theme.of(context).textTheme;

  @override
  void initState() {
    super.initState();

    context
        .read<DetailBloc>()
        .add(RequestDetailEvent(movieId: widget.movieItem.id));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final numberFormat = NumberFormat.currency();
    final vote = (widget.movieItem.voteAvg * 10).round();

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "$baseUrlImage/w500/${widget.movieItem.backdropPath ?? widget.movieItem.posterPath}"),
                            fit: BoxFit.fitHeight,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.darken))),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: ListTile(
                              title: Text(
                                widget.movieItem.title,
                                style: textTheme.titleLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10
                                ),
                                child: BlocBuilder<DetailBloc, DetailState>(
                                  builder: (context, state) {
                                    String? status;
                                    int? runtime;

                                    if (state is DetailLoaded) {
                                      status = state.model.status.name;
                                      runtime = state.model.runtime ?? 0;
                                    }

                                    return Text(
                                      "${widget.movieItem.releaseDate} ${status!=null? "• $status" : ''} ${runtime != null ? "• ${durationToString(runtime)}" : ''}",
                                      style: textTheme.labelSmall?.copyWith(
                                        color: Colors.white
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leading: Material(
                                shape: CircleBorder(
                                    side: BorderSide(
                                        color: rateToColor(vote), width: 3)),
                                color: Colors.black,
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: vote.toString(),
                                          style: textTheme.labelSmall?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: '%',
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: Colors.white,
                                          ),
                                        )
                                      ]),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Container(
                  color: const Color(0xffE6E6E6),
                ))
              ],
            ),
          ),
          BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              final hasVideo = state is DetailLoaded &&
                  state.videoStatus == RequestState.Loaded &&
                  state.video != null &&
                  state.video!.results.isNotEmpty;
              late final String idVideo;

              if (hasVideo) {
                final sorted = (state.video!.results.toList()
                  ..sort((a, b) => DateTime.parse(a.publishedAt)
                      .millisecondsSinceEpoch
                      .compareTo(DateTime.parse(b.publishedAt)
                          .millisecondsSinceEpoch)));

                idVideo = sorted
                        .where((element) =>
                            element.type == 'Trailer' && element.official)
                        .firstOrNull
                        ?.key ??
                    sorted.first.key;
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 160,
                    ),
                    if (hasVideo)
                      _tile(
                        'Trailers',
                        YoutubePlayerIframe(
                          youtubeId: idVideo,
                        ),
                      ),
                    _tile(
                      'Description',
                      Text(
                        widget.movieItem.overview,
                        style: textTheme.caption,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    if (state is DetailLoaded) ...[
                      _tile(
                          'Genres',
                          Text(
                            state.model.genres.map((e) => e.name).join(', '),
                            style: textTheme.caption,
                          )),
                      _tile(
                          'Budget',
                          Text(
                            numberFormat.format(state.model.budget),
                            style: textTheme.caption,
                          )),
                      _tile(
                          'Revenue',
                          Text(
                            numberFormat.format(state.model.revenue),
                            style: textTheme.caption,
                          ))
                    ]
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ));
  }

  Widget _tile(String title, Widget content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            content
          ],
        ),
      ),
    );
  }
}
