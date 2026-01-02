import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/constants/storage_keys.dart';
import 'views/onboarding/onboarding_view.dart';
import 'views/main/main_view.dart';
import 'views/video/video_view.dart';
import 'views/streak/streak_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final bool onboardingCompleted =
        storage.read(StorageKeys.onboardingCompleted) ?? false;

    return GetMaterialApp(
      title: 'Trogon Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      initialRoute: onboardingCompleted ? '/home' : '/onboarding',
      getPages: [
        GetPage(name: '/onboarding', page: () => const OnboardingView()),
        GetPage(name: '/home', page: () => const MainView()),
        GetPage(name: '/videos', page: () => const VideoView()),
        GetPage(name: '/streak', page: () => const StreakView()),
      ],
    );
  }
}
