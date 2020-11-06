import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_getx/auth/auth.controller.dart';
import 'package:todos_getx/todo/todo.controller.dart';
import 'package:todos_getx/todo/widgets/todo_item.dart';
import 'package:todos_getx/widgets/add_drawer.dart';

class TodoList extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final TodoController todoController =
      Get.put<TodoController>(TodoController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Obx(() => authController.user != null
            ? Text("${authController?.user?.value?.email}")
            : Container()),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState.openDrawer(),
          icon: Icon(Icons.menu),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => authController.handleSignOut(),
          )
        ],
      ),
      body: Obx(
        () {
          if (todoController.isLoadingTodos.value) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (todoController.todos.length == 0) {
            return Center(
              child: Text("Nothing to do"),
            );
          }
          return ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                return TodoItem(todoController.todos.elementAt(index));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/add-todo"),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
