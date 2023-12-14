import 'package:number_trivia/app/core/utils/network_info.dart';
import 'package:number_trivia/app/core/utils/input_converter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:number_trivia/features/num_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/num_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/num_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/num_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/num_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependenciesBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(() => SharedPreferences.getInstance());

    Get.lazyPut(() => http.Client());

    Get.lazyPut(() => InternetConnectionChecker());

    Get.lazyPut<NumberTriviaLocalDataSource>(
        () => NumberTriviaLocalDataSourceImpl());

    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl());

    Get.lazyPut<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl());

    Get.lazyPut(() => InputConverter());

    Get.lazyPut<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl());

    Get.lazyPut(() => GetRandomNumberTrivia());

    Get.lazyPut(() => GetConcreteNumberTrivia());
  }
}
