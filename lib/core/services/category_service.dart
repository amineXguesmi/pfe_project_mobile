import 'package:dio/dio.dart';

import '../models/category.dart';

class CategoryService {
  final Dio dio = Dio();
  final String baseUrl = 'http://192.168.56.1:3000/category';

  Future<void> addCategory(Category category, String token) async {
    final url = '$baseUrl/addCategory';
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: category.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Category added successfully');
      } else {
        print('Failed to add category: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('Error adding category: ${e.response?.data}');
    }
  }

  Future<List<Category>> getAllCategories() async {
    final url = '$baseUrl/getAll';
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map<Category>((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to fetch categories: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('Error fetching categories: ${e.response?.data}');
      return [];
    }
  }
}
