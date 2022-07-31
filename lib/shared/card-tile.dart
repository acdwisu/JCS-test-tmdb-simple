import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../services/utils/common.dart';
import '../services/utils/constant.dart';

class CardTile extends StatelessWidget {
  final CardTileItemModel item;
  final bool bigItem;

  const CardTile({Key? key, required this.item, required this.bigItem,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        SizedBox(
          width: bigItem? 165 : 130,
          child: Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
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
                          top: Radius.circular(4)
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '$baseUrlImage/w500/${item.posterUrl}',
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.black12,
                          child: const Center(child: Icon(Icons.broken_image)),
                        ),
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
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall?.copyWith(
                              fontSize: bigItem? 15 : 13
                          ),
                        ),
                        Text(
                          item.releaseDate ?? '-',
                          style: textTheme.caption?.copyWith(
                              fontSize: bigItem? 12 : 10
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
          left: bigItem? 18 : 13,
          bottom: bigItem? 50 : 40,
          child: Material(
            shape: CircleBorder(
                side: BorderSide(
                    color: rateToColor(item.vote),
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
                          text: item.vote.round().toString(),
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
  }
}

class CardTileItemModel {
  final String title;
  final String? releaseDate;
  final String? posterUrl;
  final num vote;

  CardTileItemModel({required this.title,
    required this.releaseDate,
    required this.posterUrl,
    required this.vote});
}

