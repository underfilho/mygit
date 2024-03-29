import 'package:mygit/models/profile.dart';
import 'package:mygit/models/repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'enums.dart';

class GetApi {
  Future<List<Repository>?> getRepositories() async {
    final uri = Uri.https('api.github.com', 'users/underfilho/repos');
    final response = await http.get(uri, headers: {'User-Agent': 'underfilho'});
    List<Repository> repositories = [];

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      for (var item in jsonData) repositories.add(Repository.fromMap(item));

      repositories.sort((a, b) => b.stars.compareTo(a.stars));
    } else
      return null;

    return repositories;
  }

  Future<Profile?> getProfile(Language language) async {
    final uri = Uri.https('raw.githubusercontent.com', _endpoint(language));
    final response = await http.get(uri);
    Profile profile;

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      profile = Profile.fromMap(jsonData);
    } else
      return null;

    return profile;
  }

  String _endpoint(Language language) {
    switch (language) {
      case Language.pt_BR:
        return 'underfilho/mygit/master/me.json';
      case Language.en_US:
        return 'underfilho/mygit/master/me_en.json';
    }
  }
}
