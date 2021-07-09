import 'package:mygit/models/skill.dart';

class Profile {
  String function;
  List<Skill> skills = [];

  Profile({this.function, this.skills});

  Profile.fromMap(Map<String, dynamic> jsonData) {
    function = jsonData['function'];

    var skillsMap = jsonData['skills'];
    for (var item in skillsMap) skills.add(Skill.fromMap(item));
  }
}
