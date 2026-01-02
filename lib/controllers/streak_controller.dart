import 'package:get/get.dart';
import '../../data/models/streak_model.dart';
import '../../data/services/api_service.dart';

class StreakController extends GetxController {
  final ApiService _apiService = ApiService();

  final Rx<StreakData?> streakData = Rx<StreakData?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStreakData();
  }

  Future<void> fetchStreakData() async {
    isLoading.value = true;
    error.value = '';

    final result = await _apiService.getStreakData();

    result.fold(
      (errorMessage) {
        error.value = errorMessage;
        isLoading.value = false;
      },
      (data) {
        streakData.value = data;
        isLoading.value = false;
      },
    );
  }

  void retry() {
    fetchStreakData();
  }
}
