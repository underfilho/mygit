import 'package:mygit/models/repository.dart';

class Skill {
  String title;
  String description;

  Skill({this.title, this.description});

  Skill.fromMap(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }
}
