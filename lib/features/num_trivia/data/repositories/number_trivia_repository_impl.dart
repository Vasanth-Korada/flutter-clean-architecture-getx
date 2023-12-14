import 'package:dartz/dartz.dart';
import 'package:number_trivia/app/core/error/exceptions.dart';
import 'package:number_trivia/app/core/error/failures.dart';
import 'package:number_trivia/app/core/utils/network_info.dart';
import 'package:get/get.dart';
import 'package:number_trivia/features/num_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/num_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/num_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/num_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource =
      Get.find<NumberTriviaRemoteDataSource>();

  final NumberTriviaLocalDataSource localDataSource =
      Get.find<NumberTriviaLocalDataSource>();

  final NetworkInfo networkInfo = Get.find<NetworkInfo>();

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
