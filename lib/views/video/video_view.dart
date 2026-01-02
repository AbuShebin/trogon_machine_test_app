import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/video_controller.dart';
import '../../core/constants/app_colors.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoController controller;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(VideoController());
    _setupVideoPlayer();
  }

  void _setupVideoPlayer() {
    ever(controller.selectedVideo, (video) {
      if (video != null) {
        _videoPlayerController?.dispose();
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(video.videoUrl))
              ..initialize().then((_) {
                setState(() {});
                _videoPlayerController?.play();
              });
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.videoData.value?.title ?? 'Videos')),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final videoData = controller.videoData.value;
        final selectedVideo = controller.selectedVideo.value;

        if (videoData == null || videoData.videos.isEmpty) {
          return const Center(child: Text('No videos available.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child:
                    _videoPlayerController != null &&
                        _videoPlayerController!.value.isInitialized
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_videoPlayerController!),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _videoPlayerController!.value.isPlaying
                                    ? _videoPlayerController!.pause()
                                    : _videoPlayerController!.play();
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 30,
                              child: Icon(
                                _videoPlayerController!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: VideoProgressIndicator(
                              _videoPlayerController!,
                              allowScrubbing: true,
                            ),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedVideo?.title ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedVideo?.description ?? '',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: videoData.videos.length,
                itemBuilder: (context, index) {
                  final video = videoData.videos[index];
                  final isPlaying = selectedVideo?.id == video.id;

                  return ListBody(
                    children: [
                      ListTile(
                        leading: _buildVideoIcon(video),
                        title: Text(
                          video.title,
                          style: TextStyle(
                            color: video.isLocked
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                            fontWeight: isPlaying
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(video.description),
                        trailing: video.isCompleted
                            ? const Icon(
                                Icons.check_circle,
                                color: AppColors.success,
                              )
                            : video.isLocked
                            ? const Icon(
                                Icons.lock,
                                color: AppColors.textSecondary,
                              )
                            : const Icon(Icons.play_circle_outline),
                        onTap: () {
                          if (!video.isLocked) {
                            controller.selectVideo(video);
                          } else {
                            Get.snackbar(
                              'Locked',
                              'Please complete previous videos first',
                            );
                          }
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildVideoIcon(dynamic video) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: video.isLocked
            ? AppColors.border
            : AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        video.isCompleted ? Icons.check : Icons.play_arrow,
        color: video.isLocked ? Colors.grey : AppColors.primary,
        size: 20,
      ),
    );
  }
}
