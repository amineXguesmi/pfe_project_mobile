import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/core/models/employee.dart';
import 'package:mobile_app/core/models/noitifcation.dart';
import 'package:mobile_app/core/services/cv_service.dart';
import 'package:mobile_app/core/services/employee_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/company.dart';
import '../services/company_services.dart';
import '../services/notifications_service.dart';

class EmployeeViewModel extends ChangeNotifier {
  final String emailRegEx =
      r'^(?!.*[&])(([^+<>()[\]\\.,;:\s@\"]+(\.[^+<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final RegExp passwordPattern = RegExp(r'^(?=.*[A-Z])(?=.*[a-z]).{8,}$');

  late SharedPreferences _prefs;
  bool isEmployeeSignedUp = false;

  final EmployeeService _employeeService = EmployeeService();
  final CompanyService _companyService = CompanyService();
  final CvService _cvService = CvService();
  final NotificationsService _notificationsService = NotificationsService();

  List<Company> companies = [];
  Employee? employee;
  String token = '';
  String loginError = '';
  String signUpError = '';
  File? selectedCv;

  init() {
    selectedCv = null;
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('userToken') ?? '';
    employee = await _employeeService.getLoggedUser(token);
    if (employee != null) {
      isEmployeeSignedUp = true;
      notifyListeners();
      companies = await _companyService.getAllCompanies() ?? [];
    } else {
      isEmployeeSignedUp = false;
    }

    notifyListeners();
    return;
  }

  set setSelectedCv(File? file) {
    selectedCv = file;
    notifyListeners();
  }

  Future<bool> signUp(String firstName, String lastName, String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      signUpError = 'Passwords do not match';
      notifyListeners();
      return false;
    }

    if (!RegExp(emailRegEx).hasMatch(email)) {
      signUpError = 'Please enter a valid email address.';
      notifyListeners();
      return false;
    }

    if (!passwordPattern.hasMatch(password)) {
      signUpError = 'Password must be at least 8 characters long and contain at least one uppercase letter.';
      notifyListeners();
      return false;
    }
    isEmployeeSignedUp = true;
    final result = await _employeeService.createAccount(
        name: firstName, surname: lastName, email: email, password: password, roleId: 1);
    if (!result) {
      signUpError = 'Failed to create account';
      notifyListeners();
      return false;
    }
    signUpError = '';
    notifyListeners();
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    if (email == '' || password == '') {
      loginError = 'Please complete the forms';
      notifyListeners();
      return false;
    }
    if (email != '' && password != '') {
      final result = await _employeeService.login(email: email, password: password);
      if (result != null) {
        employee = result;
        token = _prefs.getString('userToken')!;
        notifyListeners();
        return true;
      } else {
        loginError = 'Invalid email or password';
        notifyListeners();
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> signOut() async {
    isEmployeeSignedUp = false;
    employee = null;
    _prefs.remove('userToken');
    notifyListeners();
  }

  Future<bool> updateUserData({String? firstName, String? lastName, String? gender}) async {
    if ((firstName != null && firstName.isNotEmpty) ||
        (lastName != null && lastName.isNotEmpty) ||
        (gender != null && gender.isNotEmpty)) {
      final result = await _employeeService.updateProfile(employee!.id!, firstName ?? employee!.name!,
          lastName ?? employee!.surname!, gender ?? employee!.gender ?? 'male', employee!.location, token);

      if (result) {
        employee!.name = firstName;
        employee!.surname = lastName;
        employee!.gender = gender;
        employee!.location = employee!.location;
        notifyListeners();
      }
      return result;
    } else {
      return false;
    }
  }

  Future<bool> applyToOffer(
    int offerId,
  ) async {
    return await _cvService.applyToOffer(
      title: 'title',
      experience: 'experience',
      education: 'education',
      userId: employee!.id!,
      offerId: offerId,
      file: selectedCv!,
      formation: 'formation',
    );
  }

  Future<List<NotificationModel>> getNotifications() async {
    return await _notificationsService.getUserNotifications(employee!.id!);
  }

  Future<bool> updatePassword(String password) async {
    final result = await _employeeService.updateUserPasswordById(employee!.id!, password);
    if (result != null) {
      employee = result;
      return true;
    }
    return false;
  }
}
