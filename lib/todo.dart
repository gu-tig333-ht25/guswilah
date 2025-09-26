class Todo {
  final String id;
  final String title;
  bool done;

  Todo({required this.id, required this.title, this.done = false});

  // Används när vi skapar ny todo (utan id)
  factory Todo.create(String title) {
    return Todo(id: "", title: title, done: false);
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      title: json["title"],
      done: json["done"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "done": done,
    };
  }
}

enum FilterOption {all, done, undone}