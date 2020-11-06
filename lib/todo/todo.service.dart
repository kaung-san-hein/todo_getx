import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos_getx/todo/models/todo.model.dart';

class TodoService {
  final CollectionReference todoRefs = Firestore.instance.collection('todos');

  Stream<Iterable<Todo>> findAll(userId) {
    return todoRefs
        .where("user_id", isEqualTo: userId)
        .getDocuments()
        .then((value) {
      return value.documents.map((e) => Todo.fromSnapshot(e)).toList();
    }).asStream();
  }

  Future<Todo> findOne(String id) async {
    DocumentSnapshot result = await todoRefs.document(id).get();
    return Todo.fromSnapshot(result);
  }

  Future<Todo> addOne(String userId, String title, {bool done = false}) async {
    DocumentReference result =
        await todoRefs.add({"user_id": userId, "title": title, "done": done});
    return Todo(
        id: result.documentID, userId: userId, title: title, done: done);
  }

  Future<void> updateOne(Todo todo) async {
    await todoRefs.document(todo.id).updateData(todo.toJson());
  }

  Future<void> deleteOne(String id) async {
    await todoRefs.document(id).delete();
  }
}
