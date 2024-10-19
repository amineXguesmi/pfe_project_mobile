import 'package:dio/dio.dart';

import '../models/skill.dart';

class SkillService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://192.168.56.1:3000/skill';

  Future<void> addManySkills(List<Skill> skills) async {
    try {
      final List<Map<String, dynamic>> skillList = skills.map((skill) => skill.toJson()).toList();
      final response = await _dio.post(
        '$_baseUrl/addMany',
        data: {'skills': skillList},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print('Skills added successfully: ${response.data}');
    } catch (e) {
      print('Error adding skills: $e');
    }
  }

  Future<List<Skill>> getSkills() async {
    try {
      final response = await _dio.get('$_baseUrl/get');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map<Skill>((skill) => Skill.fromJson(skill)).toList(); // Fixed here
      } else {
        throw Exception('Failed to fetch skills: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('Error fetching skills: ${e.response?.data}');
      return [];
    }
  }
}
