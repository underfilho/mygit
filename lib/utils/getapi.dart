import 'package:mygit/models/repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mygit/models/skill.dart';

class GetApi {
  Future<List<Repository>> getRepositories() async {
    final url = "https://api.github.com/users/underfilho/repos";
    final response = await http.get(url, headers: {'User-Agent': 'underfilho'});
    List<Repository> repositories = [];

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      for (var item in jsonData) repositories.add(Repository.fromMap(item));

      repositories.sort((a, b) => b.stars.compareTo(a.stars));
    } else
      return null;

    return repositories;
  }

  Future<List<Skill>> getSkills() async {
    final url =
        "https://raw.githubusercontent.com/underfilho/mygit/master/me.json";
    final responde = await http.get(url);
    List<Skill> skills = [];

    if (responde.statusCode == 200) {
      var jsonData = json.decode(responde.body);

      for (var item in jsonData) skills.add(Skill.fromMap(item));
    } else
      return null;

    return skills;
  }
}
