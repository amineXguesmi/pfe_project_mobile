import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/company.dart';

class CompanyService {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://192.168.56.1:3000'));

  Future<Response> checkCompany(String companyName, String mf, String email) async {
    try {
      Response response = await dio.post(
        '/company/check-company',
        data: {
          'companyName': companyName,
          'mf': mf,
          'email': email,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } catch (e) {
      print('Error during checkCompany: $e');
      rethrow;
    }
  }

  Future<Company?> login(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await dio.post(
        '/company/login',
        data: {
          'email': email,
          'passord': password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        dio.options.headers['Authorization'] = 'Bearer ${response.data['token']}';
        Company company = Company.fromJson(response.data['company']);
        await prefs.setString('companyToken', response.data['accessToken']);
        await prefs.setInt('companyId', company.id!);
        return company;
      }
      return null;
    } on DioException catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  Future<bool> updatePassword(int id, String password) async {
    try {
      Response response = await dio.put(
        '/company/update/$id',
        data: {
          'passord': password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Company?> getCompanyById(String id) async {
    try {
      Response response = await dio.get(
        '/company/getOneCompany/$id',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        return Company.fromJson(response.data['company']);
      } else {
        print('Failed to get company by ID: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during getCompanyById: $e');
      return null;
    }
  }

  Future<List<Company>?> getAllCompanies() async {
    try {
      Response response = await dio.get(
        '/company/getCompanies',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        List<Company> companies = (response.data as List).map((companyJson) => Company.fromJson(companyJson)).toList();
        return companies;
      } else {
        print('Failed to get companies: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during getAllCompanies: $e');
      return null;
    }
  }
}
