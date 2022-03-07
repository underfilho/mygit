import 'package:mygit/models/experience.dart';

class Skill {
  String title;
  String urlIcon;
  List<Experience> experiences = [];

  Skill(
      {required this.title, required this.experiences, required this.urlIcon});

  Skill.fromMap(Map<String, dynamic> json)
      : title = json['title'],
        urlIcon = json['url_icon'] {
    var experiencesMap = json['experiences'] ?? [];
    for (var item in experiencesMap) experiences.add(Experience.fromJson(item));
  }
}
