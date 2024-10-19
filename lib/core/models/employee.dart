import 'dart:math';

class Employee {
  int? id;
  String? name;
  String? surname;
  String? email;
  String? image;
  bool? isActive;
  String? gender;
  String? dateOfBirth;
  String? location;
  int? roleId;

  // List of avatar image file names
  static const List<String> avatarImages = [
    'avatar_1.png',
    'avatar_2.png',
    'avatar_3.jpg',
  ];

  Employee({
    this.id,
    this.name,
    this.surname,
    this.email,
    String? image,
    this.isActive,
    this.gender,
    this.dateOfBirth,
    this.location,
    this.roleId,
  }) : image = image ?? avatarImages[Random().nextInt(avatarImages.length)];

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      image: json['image'],
      isActive: json['isActive'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      location: json['location'],
      roleId: json['roleId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'image': image,
      'isActive': isActive,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'location': location,
      'roleId': roleId,
    };
  }
}
