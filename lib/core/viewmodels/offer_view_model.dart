import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/offer.dart';
import '../services/offer_services.dart';

class OfferViewModel extends ChangeNotifier {
  final OfferService _offerService = OfferService();
  final Map<String, List<Offer>> favoriteOffers = {};
  List<Offer> offers = [];

  late SharedPreferences _prefs;
  String? userToken = '';

  init() async {
    _prefs = await SharedPreferences.getInstance();
    userToken = _prefs.getString('userToken');
    if (userToken != null) {
      await getOffers();
      await loadFavoriteOffers();
    } else {
      getCompanyOffers();
    }
  }

  Future<void> getOffers() async {
    offers = await _offerService.getAllOffers();
    notifyListeners();
  }

  void getCompanyOffers() async {
    offers = await _offerService.getCompanyOffers();
    notifyListeners();
  }

  String _getCurrentDateKey() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  void addFavoriteOffer(Offer offer) {
    final String dateKey = _getCurrentDateKey();
    offers.firstWhere((element) => element.id == offer.id).isFavorite = true;
    if (favoriteOffers.containsKey(dateKey)) {
      favoriteOffers[dateKey]!.add(offer);
    } else {
      favoriteOffers[dateKey] = [offer];
    }
    notifyListeners();
    _saveFavoriteOffers();
  }

  void removeFavoriteOffer(Offer offer) {
    bool offerRemoved = false;
    offers.firstWhere((element) => element.id == offer.id).isFavorite = false;
    for (String dateKey in favoriteOffers.keys) {
      favoriteOffers[dateKey]!.removeWhere((existingOffer) => existingOffer.id == offer.id);

      if (favoriteOffers[dateKey]!.isEmpty) {
        favoriteOffers.remove(dateKey);
      }

      offerRemoved = true;
      break;
    }

    if (offerRemoved) {
      notifyListeners();
      _saveFavoriteOffers();
    }
  }

  void _saveFavoriteOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favoriteOffers', jsonEncode(favoriteOffers));
  }

  Future<void> loadFavoriteOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoriteOffersString = prefs.getString('favoriteOffers');
    if (favoriteOffersString != null) {
      Map<String, dynamic> favoriteOffersMap = jsonDecode(favoriteOffersString);
      favoriteOffers.clear();
      favoriteOffersMap.forEach((key, value) {
        favoriteOffers[key] = (value as List).map((e) => Offer.fromJson(e)).toList();
      });
      for (var offer in offers) {
        offer.isFavorite = favoriteOffers.values.any((list) => list.any((o) => o.id == offer.id));
      }
      notifyListeners();
    }
  }

  void deleteOffer(Offer offer) async {
    final result = await _offerService.deleteOffer(int.parse(offer.id));
    if (result) {
      offers.removeWhere((existingOffer) => existingOffer.id == offer.id);
      removeFavoriteOffer(offer);
      getCompanyOffers();
    }
  }

  void orderOfferBySalary() {
    offers.sort((a, b) => a.salary.compareTo(b.salary));
    offers = offers.reversed.toList();
    notifyListeners();
  }

  Future<bool> createOffer(Offer offer) async {
    if (offer.title.isNotEmpty && offer.description.isNotEmpty && offer.salary > 0) {
      final data = {
        'title': offer.title,
        'subject': offer.title,
        'description': offer.description,
        'contractType': offer.contractType,
        'location': offer.location,
        'salary': offer.salary,
        'companyId': _prefs.getInt('companyId')!,
        'skillIds': offer.skills.map((skill) => skill.id).toList(),
        'categoryIds': offer.categories.map((category) => category.id).toList(),
      };

      final result = await _offerService.addOffer(data);
      if (result) {
        offers.add(offer);
        notifyListeners();
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updateOffer(Offer offer) async {
    if (offer.title.isNotEmpty && offer.description.isNotEmpty && offer.salary > 0) {
      final data = {
        'title': offer.title,
        'subject': offer.title,
        'description': offer.description,
        'contractType': offer.contractType,
        'location': offer.location,
        'salary': offer.salary,
        'companyId': _prefs.getInt('companyId')!,
        'skillIds': offer.skills.map((skill) => skill.id).toList(),
        'categoryIds': offer.categories.map((category) => category.id).toList(),
      };

      final result = await _offerService.updateOffer(int.parse(offer.id), data);
      if (result) {
        offers[offers.indexWhere((o) => o.id == offer.id)] = offer;
        notifyListeners();
        return true;
      }
      return false;
    }
    return false;
  }
}
