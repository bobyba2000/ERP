import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/bloc/time_keeping/time_keeping_detail_bloc.dart';
import 'package:erp_app/common_widget/face_painter.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iconsax/iconsax.dart';

import '../services/service.dart';

class CameraDetectionPreview extends StatelessWidget {
  final TimeKeepingDetailBloc bloc;
  final Function onCapture;
  CameraDetectionPreview(
      {Key? key, required this.bloc, required this.onCapture})
      : super(key: key);

  final CameraService _cameraService =
      AppDependencies.injector<CameraService>();
  final FaceDetectorService _faceDetectorService =
      AppDependencies.injector<FaceDetectorService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            ),
          if (_faceDetectorService.faceDetected)
            Align(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: InkWell(
                  child: Container(
                    child: const Icon(
                      Iconsax.camera,
                      color: Colors.white,
                      size: 40,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.secondaryHeaderColor,
                          theme.primaryColor,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                  ),
                  onTap: () async {
                    EasyLoading.show();
                    XFile? picture = await _cameraService.takePicture();
                    onCapture.call();
                    if (picture == null) {
                      ToastUtils.showToast(
                        msg: tr('capture_unsuccess'),
                        isError: true,
                      );
                      return;
                    }
                    bool isSuccess = await bloc.checkin(picture);
                    EasyLoading.dismiss();
                    if (isSuccess) {
                      Navigator.of(context).pop(true);
                    } else {
                      ToastUtils.showToast(
                        msg: tr('checkin_failed'),
                        isError: true,
                      );
                    }
                  },
                ),
              ),
              alignment: Alignment.bottomCenter,
            )
        ],
      ),
    );
  }
}
