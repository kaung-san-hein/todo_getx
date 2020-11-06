import 'package:get/get.dart';
import 'package:todos_getx/auth/views/login.dart';
import 'package:todos_getx/auth/views/register.dart';
import 'package:todos_getx/snap_sell.dart';
import 'package:todos_getx/splashscreen.dart';
import 'package:todos_getx/todo/views/add_todo.view.dart';
import 'package:todos_getx/todo/views/edit_todo.view.dart';
import 'package:todos_getx/todo/views/todo_list.view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/',
      page: () => SnapSell(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(
      name: '/todos',
      page: () => TodoList(),
    ),
    GetPage(
      name: '/todos/:id/edit',
      page: () => EditTodo(),
    ),
    GetPage(
      name: '/add-todo',
      page: () => AddTodo(),
    ),
  ];
}
