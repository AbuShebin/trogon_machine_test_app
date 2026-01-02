import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/streak_controller.dart';
import '../../core/constants/app_colors.dart';

class StreakView extends StatelessWidget {
  const StreakView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StreakController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Streak'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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

        final data = controller.streakData.value;
        if (data == null) return const SizedBox();

        return Column(
          children: [
            _buildStreakHeader(data),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: data.days.length,
                itemBuilder: (context, index) {
                  final day = data.days[index];
                  final isLeft = index % 2 == 0;

                  return _buildPathNode(
                    day,
                    isLeft,
                    index == data.days.length - 1,
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStreakHeader(dynamic data) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Keep it up!',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 32)),
              const SizedBox(width: 10),
              Text(
                '${data.currentDay} Day Streak',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: LinearProgressIndicator(
              value: data.currentDay / data.totalDays,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.streakOrange,
              ),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathNode(dynamic day, bool isLeft, bool isLast) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: isLeft
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: isLeft ? 60 : 0,
                right: isLeft ? 0 : 60,
              ),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: day.isCompleted
                          ? AppColors.streakOrange
                          : (day.isCurrent ? AppColors.primary : Colors.white),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: day.isCompleted || day.isCurrent
                            ? Colors.transparent
                            : AppColors.border,
                        width: 2,
                      ),
                      boxShadow: day.isCurrent
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: day.isCompleted
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            )
                          : Text(
                              '${day.dayNumber}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: day.isCurrent
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    day.label,
                    style: TextStyle(
                      fontWeight: day.isCurrent
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: day.isCurrent
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast)
          CustomPaint(
            size: const Size(double.infinity, 60),
            painter: PathPainter(isLeft: isLeft),
          ),
      ],
    );
  }
}

class PathPainter extends CustomPainter {
  final bool isLeft;

  PathPainter({required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (isLeft) {
      // From Left to Right
      path.moveTo(size.width * 0.25, 0);
      path.quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.5,
        size.width * 0.5,
        size.height * 0.5,
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.5,
        size.width * 0.75,
        size.height,
      );
    } else {
      // From Right to Left
      path.moveTo(size.width * 0.75, 0);
      path.quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.5,
        size.width * 0.5,
        size.height * 0.5,
      );
      path.quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.5,
        size.width * 0.25,
        size.height,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
