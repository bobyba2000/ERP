import 'package:erp_app/services/service.dart';
import 'package:get_it/get_it.dart';

class ServiceDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<CameraService>(() => CameraService());
    injector.registerLazySingleton<FaceDetectorService>(
        () => FaceDetectorService());
    injector.registerLazySingleton<LoginService>(() => LoginService());
  }
}
