import 'package:camera/camera.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/services/camera_service.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';

class FaceDetectorService {
  final CameraService _cameraService =
      AppDependencies.injector<CameraService>();

  late FaceDetector _faceDetector;
  FaceDetector get faceDetector => _faceDetector;

  List<Face> _faces = [];
  List<Face> get faces => _faces;
  bool get faceDetected => _faces.isNotEmpty;

  void initialize() {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      const FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
  }

  Future<void> detectFacesFromImage(CameraImage image) async {
    InputImageData _firebaseImageMetadata = InputImageData(
      imageRotation:
          _cameraService.cameraRotation ?? InputImageRotation.Rotation_0deg,
      inputImageFormat:
          InputImageFormatMethods.fromRawValue(image.format.raw) ??
              InputImageFormat.NV21,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      planeData: image.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );

    InputImage _firebaseVisionImage = InputImage.fromBytes(
      bytes: image.planes[0].bytes,
      inputImageData: _firebaseImageMetadata,
    );
    _faces = await _faceDetector.processImage(_firebaseVisionImage);
  }

  dispose() {
    _faceDetector.close();
  }
}
