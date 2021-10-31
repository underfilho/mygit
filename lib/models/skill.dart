class Skill {
  String title;
  String description;
  String urlIcon;

  Skill({required this.title, required this.description, required this.urlIcon});

  Skill.fromMap(Map<String, dynamic> json) :
    title = json['title'],
    description = json['description'],
    urlIcon = json['url_icon'];
}
