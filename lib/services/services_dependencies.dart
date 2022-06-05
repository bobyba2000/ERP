import 'package:erp_app/services/file/file_service.dart';
import 'package:erp_app/services/service.dart';
import 'package:erp_app/services/time_keeping/time_keeping_service.dart';
import 'package:get_it/get_it.dart';

class ServiceDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<CameraService>(() => CameraService());
    injector.registerLazySingleton<FaceDetectorService>(
        () => FaceDetectorService());
    injector.registerLazySingleton<LoginService>(() => LoginService());
    injector
        .registerLazySingleton<TimeKeepingService>(() => TimeKeepingService());
    injector.registerLazySingleton<FileService>(() => FileService());
  }
}
