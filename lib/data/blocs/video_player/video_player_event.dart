part of 'video_player_bloc.dart';

abstract class VideoPlayerEvent {}

class InitializeVideo extends VideoPlayerEvent {
  final VideoModel video;
  InitializeVideo(this.video);
}

class PlayVideo extends VideoPlayerEvent {}

class PauseVideo extends VideoPlayerEvent {}

class ResumeVideo extends VideoPlayerEvent {}

class NextVideo extends VideoPlayerEvent {}

class PreviousVideo extends VideoPlayerEvent {}
