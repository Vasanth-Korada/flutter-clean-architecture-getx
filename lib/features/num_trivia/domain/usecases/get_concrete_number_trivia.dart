import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/app/core/error/failures.dart';
import 'package:number_trivia/app/core/utils/usecase_helper.dart';
import 'package:number_trivia/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:get/get.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final repository = Get.find<NumberTriviaRepository>();

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
