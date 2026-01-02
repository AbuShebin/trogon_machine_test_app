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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              spacing: h * 0.01,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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

                //Hero Banners section
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    itemCount: data.heroBanners.length,
                    itemBuilder: (context, index) {
                      final banner = data.heroBanners[index];
                      return Container(
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
                Text(
                  "Active Course",
                  style: TextStyle(
                    fontSize: h * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //active course section
                Container(
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
                //categories
                Text(
                  "Popular Course",
                  style: TextStyle(
                    fontSize: h * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 60,
                  child: ListView.builder(
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
                          return ElevatedButton(
                            onPressed: () {},
                            child: Text(category.name),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? AppColors.primary
                                  : Colors.white,
                              foregroundColor: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                //popular courses
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller
                      .homeData
                      .value
                      ?.popularCourses[0]
                      .courses
                      .length,
                  itemBuilder: (context, index) {
                    final course = controller
                        .homeData
                        .value
                        ?.popularCourses[0]
                        .courses[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed('/videos'),
                      child: Stack(
                        children: [
                          Container(
                            width: w * w / 2,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: course?.image ?? "",
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                placeholder: (context, url) =>
                                    Container(color: Colors.grey[200]),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 7,
                            child: Container(
                              width: w * 0.43,
                              height: h * 0.07,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                spacing: h * 0.01,
                                children: [
                                  Center(
                                    child: Text(
                                      course?.title ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "DM Sans",
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: h * 0.03,
                                    width: w * 0.4,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(course?.title ?? ""),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                //Live section
                Container(
                  height: h * 0.18,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, AppColors.liveSectionCard],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: w * 0.14,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            spacing: w * 0.01,
                            children: [
                              const CircleAvatar(radius: 3),
                              const Text(
                                'LIVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller
                                            .homeData
                                            .value
                                            ?.liveSession
                                            .title ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'with ${controller.homeData.value?.liveSession.instructor.name}',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFFF2B93B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                controller.homeData.value?.liveSession.action ??
                                    "",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //community
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 9,
                        offset: const Offset(0, 9),
                      ),
                    ],
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.homeData.value?.community.name ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.homeData.value?.community.description ?? "",
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: CustomElevatedButton(
                          text: "Join Discussion",
                          onPressed: () {},
                          height: h * 1,
                          width: w * 0.8,
                        ),
                      ),
                      Row(
                        children: [
                          ...controller
                              .homeData
                              .value!
                              .community
                              .recentActivity
                              .recentMembers
                              .take(3)
                              .map(
                                (m) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundImage: CachedNetworkImageProvider(
                                      m.avatar,
                                    ),
                                  ),
                                ),
                              ),
                          Text(
                            '+${controller.homeData.value?.community.activeMembers} Members',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCommunity(dynamic data) {
    final community = data.community;
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.orange.shade600],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              community.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              community.description,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ...community.recentActivity.recentMembers
                    .take(3)
                    .map(
                      (m) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: CachedNetworkImageProvider(m.avatar),
                        ),
                      ),
                    ),
                Text(
                  '+${community.activeMembers} Members',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContact() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            const Text(
              'Have any questions?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Our team is here to help you on your learning journey.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.headset_mic),
              label: const Text('Contact Support'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimonials(dynamic data) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'What our learners say',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: data.testimonials.length,
              itemBuilder: (context, index) {
                final t = data.testimonials[index];
                return Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Text(
                        t.review,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: CachedNetworkImageProvider(
                              t.learner.avatar,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            t.learner.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
