import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  bool done;
  String userId;

  Todo({this.id, this.userId, this.title, this.done = false});

  copyWith({title, done}) {
    return Todo(
      id: this.id,
      title: title ?? this.title,
      userId: this.userId,
      done: done ?? this.done,
    );
  }

  factory Todo.fromSnapshot(DocumentSnapshot snapshot) {
    return Todo(
      id: snapshot.documentID,
      done: snapshot.data["done"],
      title: snapshot.data["title"],
    );
  }

  toJson() {
    return {
      "title": title,
      "done": done,
    };
  }
}
