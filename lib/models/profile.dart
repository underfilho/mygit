import 'package:mygit/models/skill.dart';

class Profile {
  String function;
  String profilePic;
  List<Skill> skills = [];

  Profile(
      {required this.function, required this.skills, required this.profilePic});

  Profile.fromMap(Map<String, dynamic> jsonData)
      : function = jsonData['function'],
        profilePic = jsonData['profile_pic'] {
    var skillsMap = jsonData['skills'];
    for (var item in skillsMap) skills.add(Skill.fromMap(item));
  }
}
