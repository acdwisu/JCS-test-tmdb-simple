import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jcs_test/shared/card-tile.dart';

class CardTiles extends StatelessWidget {
  final String title;
  final Iterable<CardTileItemModel>? items;
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0
                    ),
                    child: const Icon(
                      Icons.refresh
                    ),
                  ),
                ),
              InkResponse(
                onTap: moreTrigger,
                child: Text(
                  'MORE',
                  style: textTheme.caption,
                ),
              ),
            ],
          ),
          if(hasData)
            SizedBox(
              height: bigItems? 300 : 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = items!.elementAt(index);

                  return CardTile(item: item, bigItem: bigItems);
                },
                itemCount: items!.length,
              ),
            )
          else
            const SizedBox(
              height: 100,
              child: Center(
                child: Text('Loading..'),
              ),
            )
        ],
      ),
    );
  }
}