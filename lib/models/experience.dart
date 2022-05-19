import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygit/utils/enums.dart';

class Experience {
  String title;
  String description;
  ProjectType type;

  Experience(
      {required this.title, required this.description, required this.type});

  Experience.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        type = ProjectType.values[json['projectType']];

  IconData get icon {
    switch (type) {
      case ProjectType.job:
        return FontAwesomeIcons.briefcase;
      case ProjectType.extension:
        return FontAwesomeIcons.graduationCap;
      case ProjectType.personal:
        return FontAwesomeIcons.solidUserCircle;
    }
  }

  String get typeString {
    switch (type) {
      case ProjectType.job:
        return 'Trabalho';
      case ProjectType.extension:
        return 'Projeto de extensão';
      case ProjectType.personal:
        return 'Pessoal';
    }
  }
}
