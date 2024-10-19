import 'package:flutter/material.dart';
import 'package:mobile_app/core/models/cv.dart';
import 'package:mobile_app/core/models/noitifcation.dart';
import 'package:mobile_app/core/services/company_services.dart';
import 'package:mobile_app/core/services/cv_service.dart';
import 'package:mobile_app/core/services/employee_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/company.dart';
import '../models/skill.dart';
import '../services/category_service.dart';
import '../services/notifications_service.dart';
import '../services/skill_service.dart';

class CompanyViewModel extends ChangeNotifier {
  final CompanyService _companyService = CompanyService();
  final CategoryService _categoryService = CategoryService();
  final SkillService _skillService = SkillService();
  final EmployeeService _employeeService = EmployeeService();
  final CvService _cvService = CvService();
  final NotificationsService _notificationsService = NotificationsService();
  late SharedPreferences _prefs;
  Company? _company;
  bool _isLoading = false;
  String? _errorMessage;
  String? _errorSignUpMessage;
  String companyToken = '';
  String companyId = '';
  List<Category> categories = [];
  List<Skill> skills = [];

  Company? get company => _company;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get errorSignUpMessage => _errorSignUpMessage;

  init() {
    _company = null;
    _isLoading = false;
    _errorMessage = null;
    loadPrefs();
    getAllCategories();
    getAllSkills();
  }

  void loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('companyToken') ?? '';
    _prefs.remove('companyId') ?? '';
  }

  Future<void> checkCompany(String companyName, String mf, String email) async {
    try {
      await _companyService.checkCompany(companyName, mf, email);
      _errorSignUpMessage = null;
    } catch (e) {
      _errorSignUpMessage = "Failed to check company: $e";
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      Company? result = await _companyService.login(email, password);
      if (result != null) {
        _company = result;
        companyToken = _prefs.getString('companyToken') ?? '';
        companyId = _prefs.getInt('companyId').toString();
        _errorMessage = null;
      } else {
        _errorMessage = "Login failed";
      }
    } catch (e) {
      _errorMessage = "Error during login: $e";
    }
  }

  Future<bool> updatePassword(int id, String password) async {
    return await _companyService.updatePassword(id, password);
  }

  Future<List<Category>> getAllCategories() async {
    categories = await _categoryService.getAllCategories();
    return categories;
  }

  Future<List<Skill>> getAllSkills() async {
    skills = await _skillService.getSkills();
    return skills;
  }

  Future<List<CV>> getCvsFromOffer(int offerId) async {
    final result = await _cvService.getOfferCvsById(offerId);
    for (var cv in result?.cvs ?? []) {
      cv.setEmployee = await _employeeService.getUserById(cv.userId.toString());
    }
    return result?.cvs ?? [];
  }

  Future<bool> respondToCv(int cvId, String response) async {
    return await _cvService.addResponse(status: response, cvId: cvId);
  }

  Future<List<NotificationModel>> getNotifications() async {
    return await _notificationsService.getCompanyNotifications(int.parse(companyId));
  }
}
