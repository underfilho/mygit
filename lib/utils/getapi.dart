import 'package:mygit/models/profile.dart';
import 'package:mygit/models/repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<Profile> getProfile() async {
    final url =
        "https://raw.githubusercontent.com/underfilho/mygit/master/me.json";
    final response = await http.get(url);
    Profile profile;

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      profile = Profile.fromMap(jsonData);
    } else
      return null;

    return profile;
  }
}
