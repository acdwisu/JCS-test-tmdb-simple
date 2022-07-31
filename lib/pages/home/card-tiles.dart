import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jcs_test/services/utils/constant.dart';

class CardTiles extends StatelessWidget {
  final String title;
  final Iterable<CardTileItem>? items;
  final VoidCallback refreshTrigger;
  final VoidCallback moreTrigger;
  final bool bigItems;

  const CardTiles(
      {Key? key, required this.title, this.items, required this.refreshTrigger, required this.bigItems, required this.moreTrigger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasData = items != null && items!.isNotEmpty;
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: Text(
                title,
                style: textTheme.titleLarge,
              )),
              if(!hasData)
                InkResponse(
                  onTap: refreshTrigger,
                  child: const Icon(
                    Icons.refresh
                  ),
                ),
              InkResponse(
                child: Text(
                  'MORE',
                  style: textTheme.caption,
                ),
                onTap: () {

                },
              ),
            ],
          ),
          if(hasData)
            SizedBox(
              height: bigItems? 300 : 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final movie = items!.elementAt(index);

                  return Stack(
                    children: [
                      SizedBox(
                        width: bigItems? 170 : 130,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              // Navigator.pushNamed(
                              //   context,
                              //   MovieDetailPage.routeName,
                              //   arguments: movie.id,
                              // );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(6)
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: '$baseUrlImage/w500/${movie.posterUrl}',
                                      fit: BoxFit.fitHeight,
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.titleSmall?.copyWith(
                                          fontSize: bigItems? 15 : 13
                                        ),
                                      ),
                                      Text(
                                        movie.releaseDate,
                                        style: textTheme.caption?.copyWith(
                                          fontSize: bigItems? 12 : 10
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: bigItems? 18 : 13,
                        bottom: bigItems? 50 : 40,
                        child: Material(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: _rateToColor(movie.vote),
                              width: 3
                            )
                          ),
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: movie.vote.round().toString(),
                                      style: textTheme.labelSmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const TextSpan(
                                      text: '%',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontFeatures: [
                                          FontFeature.superscripts()
                                        ]
                                      ),
                                    )
                                  ]
                              ),
                            )
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: items!.length,
              ),
            ),
        ],
      ),
    );
  }
  
  Color _rateToColor(num rate) {
    if(rate < 50) {
      return Colors.red;
    } else if(rate < 70) {
      return Colors.orange;
    } else if(rate < 80) {
      return Colors.orangeAccent;
    } else if(rate < 90) {
      return Colors.greenAccent;
    } else {
      return Colors.green;
    }
  }
}

class CardTileItem {
  final String title;
  final String releaseDate;
  final String? posterUrl;
  final num vote;

  CardTileItem({required this.title,
    required this.releaseDate,
    required this.posterUrl,
    required this.vote});
}
