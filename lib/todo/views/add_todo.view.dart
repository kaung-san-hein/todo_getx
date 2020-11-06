import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_getx/todo/todo.controller.dart';

class AddTodo extends StatelessWidget {
  final TodoController todoController =
      Get.put<TodoController>(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: todoController.titleController,
              decoration: InputDecoration(
                hintText: "Add title",
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (todoController.titleController.text != "") {
                    todoController.addTodo(todoController.titleController.text);
                    todoController.titleController.clear();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: 50.0,
                  child: Center(
                    child: Text(
                      "Save",
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
              () => todoController.isAddingTodo.value
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
        ),
      ),
    );
  }
}
