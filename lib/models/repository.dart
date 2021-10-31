class Repository {
  String title;
  String description;
  String url;
  String language;
  int stars;

  Repository({required this.title, required this.description, required this.language, required this.url, required this.stars});

  Repository.fromMap(Map<String, dynamic> json) :
    title = json['name'],
    description = json['description'] ?? '',
    language = json['language'] ?? '',
    stars = json['stargazers_count'],
    url = json['html_url'];
}
