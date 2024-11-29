import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  late final SharedPreferences _sharedPreferences;
  final RxList<ConnectivityResult> connectivityResults =
      <ConnectivityResult>[].obs;

  Future<AppService> init() async {
    await _init();
    return this;
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      connectivityResults.addAll(result);
      if (connectivityResults.length > 10) {
        connectivityResults.removeAt(0);
      }
    });
  }

  bool get isConnected {
    if (connectivityResults.isEmpty) return false;
    return connectivityResults.last != ConnectivityResult.none;
  }

  SharedPreferences get sharedPreferences => _sharedPreferences;
}
