import 'package:camera/camera.dart';
import 'package:erp_app/bloc/time_keeping/time_keeping_detail_bloc.dart';
import 'package:erp_app/common_widget/camera_detection_preview.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/services/service.dart';
import 'package:flutter/material.dart';

class TimeKeepingCameraWidget extends StatefulWidget {
  final TimeKeepingDetailBloc bloc;
  const TimeKeepingCameraWidget({Key? key, required this.bloc})
      : super(key: key);

  @override
  _TimeKeepingCameraWidgetState createState() =>
      _TimeKeepingCameraWidgetState();
}

class _TimeKeepingCameraWidgetState extends State<TimeKeepingCameraWidget> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _faceDetectorService.dispose();
    super.dispose();
  }

  Future _start() async {
    setState(() => _isInitializing = true);
    await _cameraService.initialize();
    _faceDetectorService.initialize();
    setState(() => _isInitializing = false);
    _frameFaces();
  }

  _frameFaces() async {
    bool processing = false;
    _cameraService.cameraController!
        .startImageStream((CameraImage image) async {
      if (processing) return;
      processing = true;
      await _predictFacesFromImage(image: image);
      processing = false;
    });
  }

  Future<void> _predictFacesFromImage({@required CameraImage? image}) async {
    assert(image != null, 'Image is null');
    await _faceDetectorService.detectFacesFromImage(image!);
    if (mounted) setState(() {});
  }

  bool _isInitializing = false;

  final CameraService _cameraService =
      AppDependencies.injector<CameraService>();
  final FaceDetectorService _faceDetectorService =
      AppDependencies.injector<FaceDetectorService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          width: 12,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: _isInitializing
          ? const Center(child: CircularProgressIndicator())
          : CameraDetectionPreview(
              bloc: widget.bloc,
              onCapture: () {
                _frameFaces();
              }),
    );
  }
}
