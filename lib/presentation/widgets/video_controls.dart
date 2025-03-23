import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/video_player/video_player_bloc.dart';

class VideoControls extends StatelessWidget {
  final dynamic state;

  const VideoControls({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final playerBloc = context.read<VideoPlayerBloc>();
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous, color: Colors.white),
            onPressed: () => playerBloc.add(PreviousVideo()),
          ),
          IconButton(
            icon: Icon(
              state is VideoPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 48,
            ),
            onPressed: () {
              if (state is VideoPlaying) {
                playerBloc.add(PauseVideo());
              } else {
                playerBloc.add(ResumeVideo());
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.skip_next, color: Colors.white),
            onPressed: () => playerBloc.add(NextVideo()),
          ),
        ],
      ),
    );
  }
}
