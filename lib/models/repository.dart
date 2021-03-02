class Repository {
  String title;
  String description;
  String url;
  String language;
  int stars;

  Repository({this.title, this.description, this.language, this.stars});

  Repository.fromMap(Map<String, dynamic> json) {
    title = json['name'];
    description = json['description'];
    language = json['language'];
    stars = json['stargazers_count'];
    url = json['html_url'];
  }
}
