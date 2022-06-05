import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/model/time_keeping/checkin.dart';
import 'package:erp_app/model/time_keeping_model.dart';
import 'package:erp_app/services/file/file_service.dart';
import 'package:erp_app/services/time_keeping/time_keeping_service.dart';
import 'package:erp_app/utils/toast_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeKeepingDetailState extends Equatable {
  final TimeKeepingModel value;
  final bool? isSuccess;

  @override
  List<Object?> get props => [];

  const TimeKeepingDetailState({
    required this.value,
    this.isSuccess,
  });
}

class TimeKeepingDetailBloc extends Cubit<TimeKeepingDetailState> {
  TimeKeepingDetailBloc()
      : super(TimeKeepingDetailState(value: TimeKeepingModel()));
  final FileService _fileService = AppDependencies.injector<FileService>();
  final TimeKeepingService _service =
      AppDependencies.injector<TimeKeepingService>();

  void initValue(TimeKeepingModel value) {
    emit(
      TimeKeepingDetailState(value: value),
    );
  }

  Future<bool> checkin(XFile image) async {
    String time = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    String name = 'EMP-${state.value.logType}-$time';
    bool isSuccess = await _fileService.uploadFile(image, name);
    if (!isSuccess) {
      return false;
    }
    final response = await _service.checkin(
      CheckinRequest(
        employee: state.value.employee ?? '',
        owner: state.value.owner ?? '',
        time: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
        employeeName: state.value.employeeName ?? '',
        farLocation: state.value.farLocation ?? 0,
        logtype: state.value.logType ?? '',
      ),
    );
    if (response) {
      ToastUtils.showToast(msg: '${state.value.logType} thành công');
      return true;
    } else {
      return false;
    }
  }

  void changeLogtype(String value) {
    emit(TimeKeepingDetailState(value: (state.value..logType = value)));
  }
}
