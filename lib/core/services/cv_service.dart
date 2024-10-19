import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/offer.dart';

class CvService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.56.1:3000',
    ),
  );

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('companyToken') ?? '';
  }

  Future<bool> applyToOffer({
    required String title,
    required String experience,
    required String education,
    required String formation,
    required int userId,
    required int offerId,
    required File file,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'experience': experience,
        'education': education,
        'formation': formation,
        'userId': userId,
        'offerId': offerId,
        'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
      });

      final response = await dio.post(
        '/cv/addResume',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        ),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error during applyToOffer: $e');
      return false;
    }
  }

  Future<Offer?> getOfferCvsById(int offerId) async {
    try {
      final response = await dio.get(
        '/offer/findById/$offerId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Offer.fromJson(response.data);
      } else {
        print('Error: Failed to fetch offer, status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Error fetching offer: $e');
      return null;
    }
  }

  Future<bool> addResponse({
    required int cvId,
    required String status,
  }) async {
    try {
      final response = await dio.put(
        '/app/updateApp/$cvId',
        data: {
          'status': status,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        ),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error during updateApplicationStatus: $e');
      return false;
    }
  }
}
