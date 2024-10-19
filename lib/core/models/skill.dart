class Skill {
  final int id;
  final String skill;

  Skill({required this.id, required this.skill});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      skill: json['skill'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skill': skill,
    };
  }
}
