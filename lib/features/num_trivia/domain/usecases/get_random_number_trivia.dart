import 'package:dartz/dartz.dart';
import 'package:number_trivia/app/core/error/failures.dart';
import 'package:number_trivia/app/core/utils/usecase_helper.dart';
import 'package:number_trivia/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:get/get.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final repository = Get.find<NumberTriviaRepository>();

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
