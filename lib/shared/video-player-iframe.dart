import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerIframe extends StatefulWidget {
  final String youtubeId;

  const YoutubePlayerIframe({Key? key, required this.youtubeId}) : super(key: key);

  @override
  _YoutubePlayerIframeState createState() => _YoutubePlayerIframeState();
}

class _YoutubePlayerIframeState extends State<YoutubePlayerIframe> {
  late final _controller = YoutubePlayerController(
    initialVideoId: widget.youtubeId,
    params: const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  @override
  void dispose() {
    Future.microtask(() {
      _controller.close();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
