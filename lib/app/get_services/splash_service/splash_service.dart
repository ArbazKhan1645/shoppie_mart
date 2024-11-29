import 'package:get/get.dart';

class SplashService extends GetxService {
  static bool _initialized = false;
  static late DateTime _startTime;

  Future<SplashService> init() async {
    initialize();
    return this;
  }

  static void initialize() {
    if (!_initialized) {
      _startTime = DateTime.now();
      _initialized = true;
    }
  }

  static int getRemainingDuration(int minimumDuration) {
    if (!_initialized) return minimumDuration;

    final elapsedMs = DateTime.now().difference(_startTime).inMilliseconds;
    return (minimumDuration - elapsedMs).clamp(0, minimumDuration);
  }
}