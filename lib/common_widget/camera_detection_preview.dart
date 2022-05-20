import 'package:camera/camera.dart';
import 'package:erp_app/common_widget/face_painter.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/services/camera_service.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../services/face_detector_service.dart';

class CameraDetectionPreview extends StatelessWidget {
  CameraDetectionPreview({Key? key}) : super(key: key);

  final CameraService _cameraService =
      AppDependencies.injector<CameraService>();
  final FaceDetectorService _faceDetectorService =
      AppDependencies.injector<FaceDetectorService>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_cameraService.cameraController!),
          if (_faceDetectorService.faceDetected)
            CustomPaint(
              painter: FacePainter(
                face: _faceDetectorService.faces[0],
                imageSize: _cameraService.getImageSize(),
              ),
            )
        ],
      ),
    );
  }
}
