import 'dart:io';

import 'package:mobile_app/core/models/skill.dart';

import '../models/category.dart';
import '../models/cv.dart';

class Offer {
  final String title;
  final String description;
  final String? imageUrl;
  final List<Category> categories;
  final int companyId;
  final File? file;
  final List<Skill> skills;
  final String contractType;
  final double salary;
  final String location;
  final String id;
  bool isFavorite;
  bool useFile = false;
  final List<CV> cvs;

  Offer({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.companyId,
    this.skills = const [],
    required this.contractType,
    required this.salary,
    required this.location,
    this.categories = const [],
    required this.id,
    this.isFavorite = false,
    this.file,
    this.cvs = const [],
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      title: json['title'],
      description: json['description'],
      imageUrl: json['logo'] ?? "assets/app_logo.jpeg",
      skills: json['skill'] == null ? [] : List<Skill>.from(json['skill'].map((skill) => Skill.fromJson(skill))),
      categories: json['category'] == null
          ? []
          : List<Category>.from(json['category'].map((category) => Category.fromJson(category))),
      companyId: json['companyId'] ?? 1,
      contractType: json['contractType'],
      salary: (json['salary'] is int) ? json['salary'].toDouble() : json['salary'],
      location: json['location'],
      id: json['id'].toString(),
      isFavorite: json['isFavorite'] ?? false,
      cvs: json['cvs'] == null ? [] : List<CV>.from(json['cvs'].map((cv) => CV.fromJson(cv))), // Parsing the CVs
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'companyId': companyId,
      'skills': skills,
      'contractType': contractType,
      'salary': salary,
      'location': location,
      'category': categories,
      'id': id,
      'isFavorite': isFavorite,
      'cvs': cvs.map((cv) => cv.toJson()).toList(), // Serializing the CVs
    };
  }

  String showCategories() {
    String result = '';
    for (int i = 0; i < categories.length; i++) {
      result += categories[i].title;
      if (i != categories.length - 1) {
        result += ', ';
      }
    }
    return result;
  }
}
