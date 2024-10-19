import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/offer.dart';
import '../utils/console_logger.dart';
import '../utils/response_status.dart';

class OfferService {
  final responseStatusInterceptor = ResponseStatusInterceptor();
  final consoleLoggerInterceptor = ConsoleLoggerInterceptor();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.56.1:3000',
    ),
  );

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('companyToken') ?? '';
  }

  Future<int> getCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('companyId') ?? 1;
  }

  Future<List<Offer>> getAllOffers() async {
    try {
      Response response = await dio.get(
        '/offer/fetch',
        options: Options(headers: {'Authorization': 'Bearer ${await getAccessToken()}'}),
      );
      List<Offer> offers = (response.data as List).map((offerJson) => Offer.fromJson(offerJson)).toList();
      return offers;
    } catch (e) {
      print('Error during getAllOffers: $e');
      rethrow;
    }
  }

  Future<List<Offer>> getCompanyOffers() async {
    try {
      Response response = await dio.get(
        '/offer/findCompanyoffer/${await getCompanyId()}',
        options: Options(headers: {'Authorization': 'Bearer ${await getAccessToken()}'}),
      );
      List<Offer> offers = (response.data as List).map((offerJson) => Offer.fromJson(offerJson)).toList();
      return offers;
    } catch (e) {
      print('Error during getAllOffers: $e');
      rethrow;
    }
  }

  Future<bool> deleteOffer(int id) async {
    try {
      await dio.delete(
        '/offer/deleteAnOffer/$id',
        options: Options(headers: {'Authorization': 'Bearer ${await getAccessToken()}'}),
      );
      return true;
    } catch (e) {
      print('Error during deleteOffer: $e');
      return false;
    }
  }

  Future<void> orderDownOffers() async {
    try {
      await dio.get(
        '/offer/orderDown',
        options: Options(headers: {'Authorization': 'Bearer ${await getAccessToken()}'}),
      );
    } catch (e) {
      print('Error during orderDownOffers: $e');
      rethrow;
    }
  }

  Future<bool> addOffer(Map<String, dynamic> data) async {
    dio.interceptors.addAll([responseStatusInterceptor, consoleLoggerInterceptor]);
    try {
      final response = await dio.post(
        '/offer/create',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('Error during addOffer: $e');
      return false;
    }
  }

  Future<bool> updateOffer(int offerId, Map<String, dynamic> updatedData) async {
    dio.interceptors.addAll([responseStatusInterceptor, consoleLoggerInterceptor]);
    try {
      final response = await dio.put(
        '/offer/updateAnOffer/$offerId',
        data: jsonEncode(updatedData),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('Error during updateOffer: $e');
      return false;
    }
  }
}
