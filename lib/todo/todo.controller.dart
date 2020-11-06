import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todos_getx/auth/auth.controller.dart';
import 'package:todos_getx/todo/models/todo.model.dart';
import 'package:todos_getx/todo/todo.service.dart';

class TodoController extends GetxController {
  static TodoController to = Get.find();
  TextEditingController titleController;
  RxList todos = [].obs;
  RxBool isLoadingTodos = false.obs;
  RxBool isAddingTodo = false.obs;
  RxBool isLoadingDetails = false.obs;
  Todo activeTodo;
  TodoService _todoService;

  TodoController() {
    _todoService = TodoService();
  }

  @override
  void onReady() {
    todos.bindStream(loadTodos());
    titleController = TextEditingController();
    super.onReady();
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }

  Stream<Iterable<Todo>> loadTodos() {
    try {
      isLoadingTodos.value = true;
      AuthController authController = AuthController.to;
      Stream<Iterable<Todo>> result =
          _todoService.findAll(authController.user.value.uid);
      isLoadingTodos.value = false;
      return result;
    } catch (e) {
      isLoadingTodos.value = false;
      print(e);
    }
  }

  Future<void> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      activeTodo = await _todoService.findOne(id);
      isLoadingDetails.value = false;
    } catch (e) {
      isLoadingDetails.value = false;
      print(e);
    }
  }

  Future<void> addTodo(String title) async {
    try {
      AuthController authController = AuthController.to;
      print(authController.user.value);
      isAddingTodo.value = true;
      Todo todo =
          await _todoService.addOne(authController.user.value.uid, title);
      todos.add(todo);
      Get.snackbar("Success", todo.title, snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      isAddingTodo.value = true;
      await _todoService.updateOne(todo);
      int index = todos.value.indexWhere((element) => element.id == todo.id);

      todos[index] = todo;
      print(todo);
      Get.snackbar("Success", "updated", snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoService.deleteOne(id);
      int index = todos.value.indexWhere((element) => element.id == id);
      todos.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}
