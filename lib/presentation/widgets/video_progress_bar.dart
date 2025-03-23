import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/time_utils.dart';
import '../../data/blocs/video_player/video_player_bloc.dart';

class VideoProgressBar extends StatelessWidget {
  final dynamic state;

  const VideoProgressBar({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      builder: (context, state) {
        if (state is VideoPlaying || state is VideoPaused) {
          final videoBloc = context.read<VideoPlayerBloc>();
          final controller = videoBloc.controller;
          if (controller == null) {
            return const SizedBox.shrink();
          }
          return StreamBuilder(
            stream: controller.position.asStream(),
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final duration = controller.value.duration;

              if (duration.inMilliseconds == 0) {
                return const SizedBox.shrink();
              }

              final double normalizedValue =
                  position.inMilliseconds / duration.inMilliseconds.toDouble();

              return Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black87,
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.grey[800],
                        thumbColor: Colors.white,
                        overlayColor: Colors.white.withOpacity(0.2),
                      ),
                      child: Slider(
                        value: normalizedValue.clamp(0.0, 1.0),
                        min: 0.0,
                        max: 1.0,
                        onChanged: (value) {
                          final newPosition = Duration(
                            milliseconds:
                                (value * duration.inMilliseconds).round(),
                          );
                          controller.seekTo(newPosition);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            TimeUtil.formatDuration(position),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            TimeUtil.formatDuration(duration),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
