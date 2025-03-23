import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/core/res/app_dimen.dart';
import 'package:flutter_video_player/core/res/app_string.dart';
import 'package:flutter_video_player/presentation/widgets/video_controls.dart';
import 'package:flutter_video_player/presentation/widgets/video_progress_bar.dart';
import 'package:video_player/video_player.dart';

import '../../data/blocs/video_player/video_player_bloc.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPlayerBloc = context.read<VideoPlayerBloc>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
          builder: (context, state) {
            if (state is VideoInitial) {
              videoPlayerBloc.add(
                InitializeVideo(videoPlayerBloc.videos[0]),
              );
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VideoLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VideoError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStr.fileLoadErr,
                      style: const TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: AppDim.md),
                    ElevatedButton(
                      onPressed: () {
                        videoPlayerBloc.add(
                          InitializeVideo(
                            videoPlayerBloc.videos[0],
                          ),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is VideoPlaying || state is VideoPaused) {
              final videoState = state as dynamic;
              final videoBloc = videoPlayerBloc;
              final controller = videoBloc.controller;

              if (controller == null) {
                return const Center(
                  child: Text(
                    'Video controller not initialized',
                  ),
                );
              }

              return Column(
                children: [
                  _buildVideoTitle(videoState.currentVideo.title),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                          width: controller.value.size.width,
                          height: controller.value.size.height,
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VideoControls(state: videoState),
                  VideoProgressBar(state: videoState),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildVideoTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black87,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
