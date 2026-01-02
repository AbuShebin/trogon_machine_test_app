class VideoData {
  final String title;
  final List<VideoItem> videos;

  VideoData({required this.title, required this.videos});

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      title: json['title'],
      videos: (json['videos'] as List)
          .map((e) => VideoItem.fromJson(e))
          .toList(),
    );
  }
}

class VideoItem {
  final int id;
  final String title;
  final String description;
  final String status;
  final String icon;
  final String videoUrl;
  final bool hasPlayButton;

  VideoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.icon,
    required this.videoUrl,
    required this.hasPlayButton,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      icon: json['icon'],
      videoUrl: json['video_url'],
      hasPlayButton: json['has_play_button'],
    );
  }

  bool get isCompleted => status == 'completed';
  bool get isLocked => status == 'locked';
}
