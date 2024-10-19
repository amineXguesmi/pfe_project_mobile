import 'dart:math';

class Company {
  int? id;
  String? companyName;
  String? mf;
  String? password;
  String? email;
  String? logo;

  static const List<String> logoImages = [
    '1.jpg',
    '2.png',
    '3.jpeg',
    '4.jpeg',
    '5.png',
    '6.png',
    '7.jpg',
  ];

  Company({
    this.id,
    this.companyName,
    this.mf,
    this.password,
    this.email,
    String? logo,
  }) : logo = logo ?? logoImages[Random().nextInt(logoImages.length)];

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['companyName'],
      mf: json['mf'],
      password: json['password'],
      email: json['email'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'mf': mf,
      'password': password,
      'email': email,
      'logo': logo,
    };
  }
}
