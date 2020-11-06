import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_getx/todo/models/todo.model.dart';
import 'package:todos_getx/todo/todo.controller.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  TodoItem(this.todo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed("/todos/${todo.id}/edit");
        },
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: todo.done ? Colors.grey : Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text("${todo.title}"),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          TodoController.to
                              .updateTodo(todo.copyWith(done: !todo.done));
                        },
                        child: !todo.done
                            ? Icon(Icons.check_box_outline_blank)
                            : Icon(Icons.check_box),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          TodoController.to.deleteTodo(todo.id);
                        },
                        child: Icon(
                          Icons.cancel,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
