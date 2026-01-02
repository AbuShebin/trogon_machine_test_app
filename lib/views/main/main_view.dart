import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_view.dart';
import '../streak/streak_view.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/streak_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(StreakController());
    final controller = Get.put(MainController());

    final List<Widget> pages = [
      const HomeView(),
      const Center(child: Text('Courses Page (Coming Soon)')),
      const StreakView(),
      const Center(child: Text('Profile Page (Coming Soon)')),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: 'Streak',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
