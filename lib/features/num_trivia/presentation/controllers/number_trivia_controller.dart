import 'package:number_trivia/app/core/error/failures.dart';
import 'package:number_trivia/app/core/utils/usecase_helper.dart';
import 'package:number_trivia/app/core/utils/input_converter.dart';
import 'package:number_trivia/app/core/config/constants.dart';
import 'package:number_trivia/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/num_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/num_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:get/get.dart';

class NumberTriviaController extends GetxController
    with StateMixin<NumberTrivia> {
  var trivia = const NumberTrivia(text: '', number: 0);

  final getConcreteNumberTrivia = Get.find<GetConcreteNumberTrivia>();
  final getRandomNumberTrivia = Get.find<GetRandomNumberTrivia>();
  final inputConverter = Get.find<InputConverter>();

  NumberTriviaController() {
    change(null, status: RxStatus.empty());
  }

  void getTriviaForNumber(String inputStr) async {
    change(null, status: RxStatus.loading());
    var number = inputConverter.stringToUnsignedInteger(inputStr);

    number.fold(
      (failure) {
        change(null, status: RxStatus.error(_mapFailureToMessage(failure)));
      },
      (number) async => await _getConcreteNumberTrivia(number),
    );
  }

  Future<void> _getConcreteNumberTrivia(int number) async {
    var result = await getConcreteNumberTrivia(Params(number: number));

    result.fold(
      (failure) {
        change(null, status: RxStatus.error(_mapFailureToMessage(failure)));
      },
      (trivia) {
        this.trivia = trivia;
        change(trivia, status: RxStatus.success());
      },
    );
  }

  void getRandomTrivia() async {
    change(null, status: RxStatus.loading());
    final result = await getRandomNumberTrivia(NoParams());

    result.fold(
      (failure) {
        change(null, status: RxStatus.error(_mapFailureToMessage(failure)));
      },
      (trivia) {
        this.trivia = trivia;
        change(trivia, status: RxStatus.success());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InvalidInputFailure:
        return INVALID_INPUT_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
