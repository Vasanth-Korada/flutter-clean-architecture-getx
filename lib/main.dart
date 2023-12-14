import 'package:flutter/material.dart';
import 'package:number_trivia/app/core/di/dependencies_binding.dart';
import 'package:get/get.dart';

import 'app/core/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependenciesBinding().dependencies();
  runApp(
    GetMaterialApp(
      title: "Number Trivia",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
