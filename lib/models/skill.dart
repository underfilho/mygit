import 'package:mygit/models/repository.dart';

class Skill {
  String title;
  String description;
  String urlIcon;

  Skill({this.title, this.description});

  Skill.fromMap(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    urlIcon = json['urlIcon'];
  }
}
