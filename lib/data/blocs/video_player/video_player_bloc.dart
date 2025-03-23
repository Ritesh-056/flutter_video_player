import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../models/video_model.dart';

part 'video_player_event.dart';

part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerController? controller;
  Timer? _pauseTimer;
  final List<VideoModel> videos = [
    VideoModel(
      title: 'First Video Title - I',
      path: 'assets/videos/video1.mp4',
      pauseDuration: const Duration(seconds: 15),
    ),
    VideoModel(
      title: 'Second Video Title - II',
      path: 'assets/videos/video2.mp4',
      pauseDuration: const Duration(seconds: 20),
    ),
    VideoModel(
      title: 'Third Video Title - III',
      path: 'assets/videos/video3.mp4',
      pauseDuration: const Duration(seconds: 0),
      isLastVideo: true,
    ),
  ];
  int _currentIndex = 0;

  VideoPlayerBloc() : super(VideoInitial()) {
    on<InitializeVideo>(_onInitializeVideo);
    on<PlayVideo>(_onPlayVideo);
    on<PauseVideo>(_onPauseVideo);
    on<ResumeVideo>(_onResumeVideo);
    on<NextVideo>(_onNextVideo);
    on<PreviousVideo>(_onPreviousVideo);
  }

  Future<void> _onInitializeVideo(
      InitializeVideo event, Emitter<VideoPlayerState> emit) async {
    try {
      emit(VideoLoading());
      controller?.dispose();
      controller = VideoPlayerController.asset(event.video.path);
      await controller!.initialize();

      controller!.addListener(_updateVideoProgress);

      emit(VideoPlaying(
        event.video,
        Duration.zero,
        controller!.value.duration,
      ));

      controller!.play();
      _setupPauseTimer(event.video.pauseDuration);
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  void _setupPauseTimer(Duration duration) {
    _pauseTimer?.cancel();
    if (duration.inSeconds > 0) {
      _pauseTimer = Timer(duration, () {
        add(PauseVideo());
      });
    }
  }

  Future<void> _onPlayVideo(
      PlayVideo event, Emitter<VideoPlayerState> emit) async {
    if (controller != null && !controller!.value.isPlaying) {
      await controller!.play();
      emit(VideoPlaying(
        videos[_currentIndex],
        controller!.value.position,
        controller!.value.duration,
      ));
    }
  }

  Future<void> _onPauseVideo(
      PauseVideo event, Emitter<VideoPlayerState> emit) async {
    if (controller != null && controller!.value.isPlaying) {
      await controller!.pause();
      emit(VideoPaused(
        videos[_currentIndex],
        controller!.value.position,
        controller!.value.duration,
      ));
    }
  }

  Future<void> _onResumeVideo(
      ResumeVideo event, Emitter<VideoPlayerState> emit) async {
    if (controller != null && !controller!.value.isPlaying) {
      await controller!.play();
      emit(VideoPlaying(
        videos[_currentIndex],
        controller!.value.position,
        controller!.value.duration,
      ));
    }
  }

  Future<void> _onNextVideo(
      NextVideo event, Emitter<VideoPlayerState> emit) async {
    if (_currentIndex < videos.length - 1) {
      _currentIndex++;
      add(InitializeVideo(videos[_currentIndex]));
    } else {
      _currentIndex = 1;
      add(InitializeVideo(videos[_currentIndex]));
    }
  }

  Future<void> _onPreviousVideo(
      PreviousVideo event, Emitter<VideoPlayerState> emit) async {
    if (_currentIndex > 0) {
      _currentIndex--;
      add(InitializeVideo(videos[_currentIndex]));
    }
  }

  void _updateVideoProgress() {
    if (controller != null) {
      controller!.position.then((position) {
        if (state is VideoPlaying) {
          emit(VideoPlaying(
            videos[_currentIndex],
            position!,
            controller!.value.duration,
          ));
        } else if (state is VideoPaused) {
          emit(VideoPaused(
            videos[_currentIndex],
            position!,
            controller!.value.duration,
          ));
        }
      });
    }
  }

  @override
  Future<void> close() {
    controller?.removeListener(_updateVideoProgress);
    controller?.dispose();
    _pauseTimer?.cancel();
    return super.close();
  }
}
