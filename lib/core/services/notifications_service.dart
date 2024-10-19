import 'package:dio/dio.dart';

import '../models/noitifcation.dart';

class NotificationsService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.56.1:3000',
    ),
  );

  Future<List<NotificationModel>> getUserNotifications(int userId) async {
    try {
      final response = await dio.get(
        '/notification/getUserNotif/$userId',
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        print('Error: Failed to fetch user notifications.');
        return [];
      }
    } on DioException catch (e) {
      print('Error fetching user notifications: $e');
      return [];
    }
  }

  Future<List<NotificationModel>> getCompanyNotifications(int companyId) async {
    try {
      final response = await dio.get(
        '/notification/getCompanyNotif/$companyId',
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        print('Error: Failed to fetch company notifications.');
        return [];
      }
    } on DioException catch (e) {
      print('Error fetching company notifications: $e');
      return [];
    }
  }
}
