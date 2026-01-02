import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/home_model.dart';
import '../models/video_model.dart';
import '../models/streak_model.dart';

class ApiService {
  Future<Either<String, HomeData>> getHomeData() async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.homeEndpoint}'))
          .timeout(ApiConstants.timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(HomeData.fromJson(data));
      } else {
        return Left('Failed to load home data: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, VideoData>> getVideoDetails() async {
    try {
      final response = await http
          .get(
            Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.videoDetailsEndpoint}',
            ),
          )
          .timeout(ApiConstants.timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(VideoData.fromJson(data['videos']));
      } else {
        return Left('Failed to load video details: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, StreakData>> getStreakData() async {
    try {
      final response = await http
          .get(
            Uri.parse('${ApiConstants.baseUrl}${ApiConstants.streakEndpoint}'),
          )
          .timeout(ApiConstants.timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(StreakData.fromJson(data));
      } else {
        return Left('Failed to load streak data: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
