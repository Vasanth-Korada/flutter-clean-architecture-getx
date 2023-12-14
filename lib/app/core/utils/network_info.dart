import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker = Get.find();

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
