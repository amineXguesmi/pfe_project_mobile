import 'package:mobile_app/core/models/employee.dart';

class CV {
  final int id;
  final String title;
  final String experience;
  final String education;
  final String formation;
  final String file;
  final int offerId;
  final String status;
  final int userId;
  Employee? employee;

  CV({
    required this.id,
    required this.title,
    required this.experience,
    required this.education,
    required this.formation,
    required this.file,
    required this.offerId,
    required this.status,
    required this.userId,
    this.employee,
  });

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      id: json['id'],
      title: json['title'],
      experience: json['experience'],
      education: json['education'],
      formation: json['formation'],
      file: json['file'],
      offerId: json['offerId'],
      status: json['status'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'experience': experience,
      'education': education,
      'formation': formation,
      'file': file,
      'offerId': offerId,
      'status': status,
      'userId': userId,
    };
  }

  set setEmployee(Employee? employee) {
    this.employee = employee;
  }
}
