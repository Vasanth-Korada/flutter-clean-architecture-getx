import 'package:number_trivia/features/num_trivia/presentation/controllers/number_trivia_controller.dart';
import 'package:get/get.dart';

class NumberTriviaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NumberTriviaController>(() => NumberTriviaController());
  }
}
