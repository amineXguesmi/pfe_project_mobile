import 'package:dio/dio.dart';
import 'package:mobile_app/core/models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/console_logger.dart';
import '../utils/response_status.dart';

class EmployeeService {
  final responseStatusInterceptor = ResponseStatusInterceptor();
  final consoleLoggerInterceptor = ConsoleLoggerInterceptor();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.56.1:3000/user',
    headers: {'Content-Type': 'application/json'},
  ));

  Future<bool> createAccount({
    required String name,
    required String surname,
    required String email,
    required String password,
    required int roleId,
  }) async {
    try {
      final response = await _dio.post(
        '/createAccount',
        data: {
          'name': name,
          'surname': surname,
          'email': email,
          'password': password,
          'roleId': roleId,
        },
      );
      print('Account created: ${response.data}');
      return true;
    } on DioException catch (e) {
      print('Failed to create account: $e');
      return false;
    }
  }

  Future<Employee?> login({
    required String email,
    required String password,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print('Login successful: ${response.data}');
      if (response.data['token'] != null) {
        _dio.options.headers['Authorization'] = 'Bearer ${response.data['token']}';
        await prefs.setString('userToken', response.data['token']);
        Employee employee = Employee.fromJson(response.data['data']);
        return employee;
      }

      return null;
    } on DioException catch (e) {
      print('Login failed: $e');
      return null;
    }
  }

  Future<Employee?> getLoggedUser(String token) async {
    try {
      final response = await _dio.get(
        '/getLoggedUser',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Employee.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Error fetching logged user: ${e.message}');
      return null;
    }
  }

  Future<bool> updateProfile(
      int userId, String name, String surname, String gender, String? location, String token) async {
    try {
      final response = await _dio.put(
        '/updateProfile/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'name': name,
          'surname': surname,
          'gender': gender,
          'location': location ?? '',
        },
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully: ${response.data}');
        return true;
      } else {
        print('Failed to update profile: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return false;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<Employee?> getUserById(String userId) async {
    try {
      final response = await _dio.get(
        '/getUser/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Employee.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Error fetching  user: ${e.message}');
      return null;
    }
  }

  Future<Employee?> updateUserPasswordById(int userId, String newPassword) async {
    try {
      _dio.interceptors.addAll([responseStatusInterceptor, consoleLoggerInterceptor]);
      final response = await _dio.put(
        '/updatePass/$userId',
        data: {
          'password': newPassword,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Employee.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Error fetching  user: ${e.message}');
      return null;
    }
  }
}
