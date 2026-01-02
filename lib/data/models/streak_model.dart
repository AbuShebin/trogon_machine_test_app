class StreakData {
  final int currentDay;
  final int totalDays;
  final List<DayItem> days;

  StreakData({
    required this.currentDay,
    required this.totalDays,
    required this.days,
  });

  factory StreakData.fromJson(Map<String, dynamic> json) {
    return StreakData(
      currentDay: json['current_day'],
      totalDays: json['total_days'],
      days: (json['days'] as List).map((e) => DayItem.fromJson(e)).toList(),
    );
  }
}

class DayItem {
  final int id;
  final int dayNumber;
  final String label;
  final bool isCompleted;
  final bool isCurrent;
  final Topic topic;

  DayItem({
    required this.id,
    required this.dayNumber,
    required this.label,
    required this.isCompleted,
    required this.isCurrent,
    required this.topic,
  });

  factory DayItem.fromJson(Map<String, dynamic> json) {
    return DayItem(
      id: json['id'],
      dayNumber: json['day_number'],
      label: json['label'],
      isCompleted: json['is_completed'],
      isCurrent: json['is_current'],
      topic: Topic.fromJson(json['topic']),
    );
  }
}

class Topic {
  final String title;
  final List<Module> modules;

  Topic({required this.title, required this.modules});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      title: json['title'],
      modules: (json['modules'] as List)
          .map((e) => Module.fromJson(e))
          .toList(),
    );
  }
}

class Module {
  final String name;
  final String description;

  Module({required this.name, required this.description});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(name: json['name'], description: json['description']);
  }
}
