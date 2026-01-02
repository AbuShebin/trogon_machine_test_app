import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trogon_machine_test_app/core/widgets/custom_elevated_button.dart';
import '../../controllers/home_controller.dart';
import '../../core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    final controller = Get.find<HomeController>();

    return Obx(() {
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

      final data = controller.homeData.value;
      if (data == null) {
        return const Center(child: Text('No courses available at the moment.'));
      }
      // CustomScrollView(
      //     slivers: [
      //       _buildHeader(data),
      //       _buildHeroBanners(data),
      //       _buildActiveCourse(data),
      //       _buildCategories(controller),
      //       _buildPopularCourses(controller, data),
      //       _buildLiveSession(data),
      //       _buildCommunity(data),
      //       _buildTestimonials(data),
      //       _buildContact(),
      //       const SliverToBoxAdapter(child: SizedBox(height: 100)),
      //     ],
      //   ),

      return RefreshIndicator(
        onRefresh: controller.fetchHomeData,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.user.greeting,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'What would you like to learn today?',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/streak'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.streakOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Day ${data.user.streak.days}',
                            style: const TextStyle(
                              color: AppColors.streakOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(data.user.streak.icon),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Hero Banners section
            SizedBox(
              height: 180,
              child: PageView.builder(
                itemCount: data.heroBanners.length,
                itemBuilder: (context, index) {
                  final banner = data.heroBanners[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: banner.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[200]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            ),

            //active course section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    AppColors.activeCourseGradient1,
                    AppColors.activeCourseGradient2,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: h * 0.095,
                        width: w * 0.2,
                        child: CircularProgressIndicator(
                          value: data.activeCourse.progress / 100,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.activeCourseProgress,
                          ),
                          strokeWidth: 10,
                        ),
                      ),
                      Positioned(
                        top: h * 0.03,
                        right: w * 0.05,
                        child: Center(
                          child: Text(
                            '${data.activeCourse.progress}%',
                            style: const TextStyle(
                              color: AppColors.activeCourseProgress,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: w * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.activeCourse.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${data.activeCourse.testsCompleted}/${data.activeCourse.totalTests} Tests',
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: h * 0.01),
                      Row(
                        children: [
                          CustomElevatedButton(
                            onPressed: () {},
                            text: "Continue",
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: h * 0.02,
                            ),
                            height: h * 0.6,
                            width: w * 0.26,
                          ),
                          SizedBox(width: w * 0.03),
                          CustomElevatedButton(
                            onPressed: () {},
                            text: "Shift Course",
                            height: h * 0.6,
                            width: w * 0.26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                itemCount:
                    controller.homeData.value?.popularCourses.length ?? 0,
                itemBuilder: (context, index) {
                  final category =
                      controller.homeData.value!.popularCourses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: Obx(() {
                      final isSelected =
                          controller.selectedCategoryIndex.value == index;
                      return ChoiceChip(
                        label: Text(category.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) controller.selectCategory(index);
                        },
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(dynamic data) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.user.greeting,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'What would you like to learn today?',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Get.toNamed('/streak'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.streakOrange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      'Day ${data.user.streak.days}',
                      style: const TextStyle(
                        color: AppColors.streakOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(data.user.streak.icon),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  }
