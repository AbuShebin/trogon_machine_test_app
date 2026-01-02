import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/constants/storage_keys.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final storage = GetStorage();

  final List<OnboardingContent> contents = [
    OnboardingContent(
      image:
          'https://img.freepik.com/free-vector/smarter-learning-concept-illustration_114360-7055.jpg', // Placeholder
      title: 'Smarter Learning Starts Here',
      description:
          'Unlock your potential with our expert-led courses and interactive learning experience.',
    ),
    OnboardingContent(
      image:
          'https://img.freepik.com/free-vector/learn-practice-succeed-concept-illustration_114360-7056.jpg', // Placeholder
      title: 'Learn. Practice. Succeed.',
      description:
          'Real-world skills, practical exercises, and personalized feedback to help you excel.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void next() {
    if (currentPage.value < contents.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skip() {
    completeOnboarding();
  }

  void completeOnboarding() {
    storage.write(StorageKeys.onboardingCompleted, true);
    Get.offAllNamed('/home');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}
