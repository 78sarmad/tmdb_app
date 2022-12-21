import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.videoPlayerController,
    required this.looping,
    required this.autoplay,
  });

  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: AppColors.secondaryColor),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
