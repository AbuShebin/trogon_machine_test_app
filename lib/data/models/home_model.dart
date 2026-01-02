class HomeData {
  final User user;
  final List<HeroBanner> heroBanners;
  final ActiveCourse activeCourse;
  final List<PopularCourse> popularCourses;
  final LiveSession liveSession;
  final Community community;
  final List<Testimonial> testimonials;

  HomeData({
    required this.user,
    required this.heroBanners,
    required this.activeCourse,
    required this.popularCourses,
    required this.liveSession,
    required this.community,
    required this.testimonials,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      user: User.fromJson(json['user']),
      heroBanners: (json['hero_banners'] as List)
          .map((e) => HeroBanner.fromJson(e))
          .toList(),
      activeCourse: ActiveCourse.fromJson(json['active_course']),
      popularCourses: (json['popular_courses'] as List)
          .map((e) => PopularCourse.fromJson(e))
          .toList(),
      liveSession: LiveSession.fromJson(json['live_session']),
      community: Community.fromJson(json['community']),
      testimonials: (json['testimonials'] as List)
          .map((e) => Testimonial.fromJson(e))
          .toList(),
    );
  }
}

class User {
  final String name;
  final String greeting;
  final Streak streak;

  User({required this.name, required this.greeting, required this.streak});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      greeting: json['greeting'],
      streak: Streak.fromJson(json['streak']),
    );
  }
}

class Streak {
  final int days;
  final String icon;

  Streak({required this.days, required this.icon});

  factory Streak.fromJson(Map<String, dynamic> json) {
    return Streak(days: json['days'], icon: json['icon']);
  }
}

class HeroBanner {
  final int id;
  final String title;
  final String image;
  final bool isActive;

  HeroBanner({
    required this.id,
    required this.title,
    required this.image,
    required this.isActive,
  });

  factory HeroBanner.fromJson(Map<String, dynamic> json) {
    return HeroBanner(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      isActive: json['is_active'],
    );
  }
}

class ActiveCourse {
  final int id;
  final String title;
  final int progress;
  final int testsCompleted;
  final int totalTests;

  ActiveCourse({
    required this.id,
    required this.title,
    required this.progress,
    required this.testsCompleted,
    required this.totalTests,
  });

  factory ActiveCourse.fromJson(Map<String, dynamic> json) {
    return ActiveCourse(
      id: json['id'],
      title: json['title'],
      progress: json['progress'],
      testsCompleted: json['tests_completed'],
      totalTests: json['total_tests'],
    );
  }
}

class PopularCourse {
  final int id;
  final String name;
  final List<Course> courses;

  PopularCourse({required this.id, required this.name, required this.courses});

  factory PopularCourse.fromJson(Map<String, dynamic> json) {
    return PopularCourse(
      id: json['id'],
      name: json['name'],
      courses: (json['courses'] as List)
          .map((e) => Course.fromJson(e))
          .toList(),
    );
  }
}

class Course {
  final int id;
  final String title;
  final String image;
  final String action;

  Course({
    required this.id,
    required this.title,
    required this.image,
    required this.action,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      action: json['action'],
    );
  }
}

class LiveSession {
  final int id;
  final bool isLive;
  final String title;
  final Instructor instructor;
  final SessionDetails sessionDetails;
  final String action;

  LiveSession({
    required this.id,
    required this.isLive,
    required this.title,
    required this.instructor,
    required this.sessionDetails,
    required this.action,
  });

  factory LiveSession.fromJson(Map<String, dynamic> json) {
    return LiveSession(
      id: json['id'],
      isLive: json['is_live'],
      title: json['title'],
      instructor: Instructor.fromJson(json['instructor']),
      sessionDetails: SessionDetails.fromJson(json['session_details']),
      action: json['action'],
    );
  }
}

class Instructor {
  final String name;

  Instructor({required this.name});

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(name: json['name']);
  }
}

class SessionDetails {
  final int sessionNumber;
  final String date;
  final String time;

  SessionDetails({
    required this.sessionNumber,
    required this.date,
    required this.time,
  });

  factory SessionDetails.fromJson(Map<String, dynamic> json) {
    return SessionDetails(
      sessionNumber: json['session_number'],
      date: json['date'],
      time: json['time'],
    );
  }
}

class Community {
  final int id;
  final String name;
  final int activeMembers;
  final String description;
  final RecentActivity recentActivity;
  final String action;

  Community({
    required this.id,
    required this.name,
    required this.activeMembers,
    required this.description,
    required this.recentActivity,
    required this.action,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'],
      name: json['name'],
      activeMembers: json['active_members'],
      description: json['description'],
      recentActivity: RecentActivity.fromJson(json['recent_activity']),
      action: json['action'],
    );
  }
}

class RecentActivity {
  final int recentPosts;
  final String status;
  final List<Member> recentMembers;

  RecentActivity({
    required this.recentPosts,
    required this.status,
    required this.recentMembers,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      recentPosts: json['recent_posts'],
      status: json['status'],
      recentMembers: (json['recent_members'] as List)
          .map((e) => Member.fromJson(e))
          .toList(),
    );
  }
}

class Member {
  final int id;
  final String avatar;

  Member({required this.id, required this.avatar});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(id: json['id'], avatar: json['avatar']);
  }
}

class Testimonial {
  final int id;
  final Learner learner;
  final String review;
  final bool isActive;

  Testimonial({
    required this.id,
    required this.learner,
    required this.review,
    required this.isActive,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json['id'],
      learner: Learner.fromJson(json['learner']),
      review: json['review'],
      isActive: json['is_active'],
    );
  }
}

class Learner {
  final String name;
  final String avatar;

  Learner({required this.name, required this.avatar});

  factory Learner.fromJson(Map<String, dynamic> json) {
    return Learner(name: json['name'], avatar: json['avatar']);
  }
}
