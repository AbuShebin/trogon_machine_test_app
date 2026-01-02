import 'package:get/get.dart';
import '../../data/models/video_model.dart';
import '../../data/services/api_service.dart';

class VideoController extends GetxController {
  final ApiService _apiService = ApiService();

  final Rx<VideoData?> videoData = Rx<VideoData?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<VideoItem?> selectedVideo = Rx<VideoItem?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchVideoDetails();
  }

  Future<void> fetchVideoDetails() async {
    isLoading.value = true;
    error.value = '';

    final result = await _apiService.getVideoDetails();

    result.fold(
      (errorMessage) {
        error.value = errorMessage;
        isLoading.value = false;
      },
      (data) {
        videoData.value = data;
        if (data.videos.isNotEmpty) {
          selectedVideo.value = data.videos.first;
        }
        isLoading.value = false;
      },
    );
  }

  void selectVideo(VideoItem video) {
    if (!video.isLocked) {
      selectedVideo.value = video;
    }
  }

  void retry() {
    fetchVideoDetails();
  }
}
