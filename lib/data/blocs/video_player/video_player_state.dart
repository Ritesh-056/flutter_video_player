part of 'video_player_bloc.dart';

abstract class VideoPlayerState {}

class VideoInitial extends VideoPlayerState {}

class VideoLoading extends VideoPlayerState {}

class VideoPlaying extends VideoPlayerState {
  final VideoModel currentVideo;
  final Duration position;
  final Duration duration;

  VideoPlaying(this.currentVideo, this.position, this.duration);
}

class VideoPaused extends VideoPlayerState {
  final VideoModel currentVideo;
  final Duration position;
  final Duration duration;

  VideoPaused(this.currentVideo, this.position, this.duration);
}

class VideoError extends VideoPlayerState {
  final String message;

  VideoError(this.message);
}
