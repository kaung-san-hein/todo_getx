import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_getx/auth/auth.controller.dart';
import 'package:todos_getx/get_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController =
      Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Todo App with Get Package",
      defaultTransition: Transition.rightToLeft,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/splashscreen",
      getPages: AppRoutes.routes,
    );
  }
}
