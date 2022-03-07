class Experience {
  String title;
  String description;
  bool completed;

  Experience(
      {required this.title, required this.description, this.completed = false});

  Experience.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        completed = json['completed'] ?? false;
}
