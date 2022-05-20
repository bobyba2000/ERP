import 'package:erp_app/services/camera_service.dart';
import 'package:erp_app/services/face_detector_service.dart';
import 'package:get_it/get_it.dart';

class ServiceDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<CameraService>(() => CameraService());
    injector.registerLazySingleton<FaceDetectorService>(
        () => FaceDetectorService());
  }
}
