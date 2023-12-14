// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:number_trivia/features/num_trivia/presentation/bindings/number_trivia_binding.dart';
import 'package:number_trivia/features/num_trivia/presentation/pages/number_trivia_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NUMBER_TRIVIA_HOME;

  static final routes = [
    GetPage(
      name: _Paths.NUMBER_TRIVIA_HOME,
      page: () => const NumberTriviaPage(),
      binding: NumberTriviaBinding(),
    ),
  ];
}
