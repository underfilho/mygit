import 'package:mygit/models/skill.dart';
import 'dart:convert' as convert;

class Profile {
  String function;
  List<Skill> skills;

  Profile({this.function, this.skills});

  Profile.fromMap(Map<String, dynamic> json) {
    function = json['function'];

    var skillsMap = convert.json.decode(json['skills']);
    for (var item in skillsMap) skills.add(Skill.fromMap(item));
  }
}
