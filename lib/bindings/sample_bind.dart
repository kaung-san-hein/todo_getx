import 'package:get/get.dart';
import 'package:todos_getx/auth/auth.controller.dart';
import 'package:todos_getx/todo/todo.controller.dart';

class SampleBind extends Bindings {
  @override
  void dependencies() {
    print("binding");
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
