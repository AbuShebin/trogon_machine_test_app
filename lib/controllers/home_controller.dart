import 'package:get/get.dart';
import '../../data/models/home_model.dart';
import '../../data/services/api_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();

  final Rx<HomeData?> homeData = Rx<HomeData?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxInt selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    isLoading.value = true;
    error.value = '';

    final result = await _apiService.getHomeData();

    result.fold(
      (errorMessage) {
        error.value = errorMessage;
        isLoading.value = false;
      },
      (data) {
        homeData.value = data;
        isLoading.value = false;
      },
    );
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void retry() {
    fetchHomeData();
  }
}
