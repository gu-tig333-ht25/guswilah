class Todo { //todo modell
  final String id; //unikt id
  final String title; //textbeskrivning
  bool done; //avckeckad eller inte

  Todo({required this.id, required this.title, this.done = false}); //konstruktor som kräver id, titel och status

  //Skapa ny todo
  factory Todo.create(String title) {
    return Todo(id: "", title: title, done: false); //servern skapar id
  }

  factory Todo.fromJson(Map<String, dynamic> json) { //skapa todo från JSON
    return Todo(
      id: json["id"],
      title: json["title"],
      done: json["done"],
    );
  }

  Map<String, dynamic> toJson() { //gör om todo till JSON
    return {
      "title": title,
      "done": done,
    };
  }
}

enum FilterOption {all, done, undone} //filteralternativ