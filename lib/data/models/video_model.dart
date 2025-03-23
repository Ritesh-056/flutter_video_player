class VideoModel {
  final String title;
  final String path;
  final Duration pauseDuration;
  final bool isLastVideo;

  VideoModel({
    required this.title,
    required this.path,
    required this.pauseDuration,
    this.isLastVideo = false,
  });

  VideoModel copyWith({
    String? title,
    String? path,
    Duration? pauseDuration,
    bool? isLastVideo,
  }) {
    return VideoModel(
      title: title ?? this.title,
      path: path ?? this.path,
      pauseDuration: pauseDuration ?? this.pauseDuration,
      isLastVideo: isLastVideo ?? this.isLastVideo,
    );
  }
}
