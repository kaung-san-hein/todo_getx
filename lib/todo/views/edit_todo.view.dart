import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_getx/todo/models/todo.model.dart';
import 'package:todos_getx/todo/todo.controller.dart';

class EditTodo extends StatelessWidget {
  final TodoController todoController =
      Get.put<TodoController>(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: GetX(
          initState: (state) =>
              todoController.loadDetails(Get.parameters["id"]),
          builder: (disposable) {
            if (todoController.isLoadingDetails.value) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            todoController.titleController.text =
                todoController.activeTodo.title;
            return Column(
              children: <Widget>[
                TextFormField(
                  controller: todoController.titleController,
                  decoration: InputDecoration(
                    hintText: "Add Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (todoController.titleController.text != "") {
                        Todo todo = TodoController.to.activeTodo;
                        todo.title = todoController.titleController.text;
                        TodoController.to.updateTodo(todo);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .6,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ),
                Obx(
                  () => TodoController.to.isAddingTodo.value
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
