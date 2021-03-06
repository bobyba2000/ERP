import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/model/time_keeping/get_histories.dart';
import 'package:erp_app/model/time_keeping_model.dart';
import 'package:erp_app/preference/user_preference.dart';
import 'package:erp_app/services/time_keeping/time_keeping_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TimeKeepingListState extends Equatable {
  final List<TimeKeepingModel> listTimeKeeping;

  @override
  List<Object?> get props => [listTimeKeeping];

  const TimeKeepingListState({required this.listTimeKeeping});
}

class TimeKeepingListBloc extends Cubit<TimeKeepingListState> {
  final TimeKeepingService _timeKeepingService =
      AppDependencies.injector<TimeKeepingService>();
  TimeKeepingListBloc()
      : super(const TimeKeepingListState(listTimeKeeping: []));

  Future<void> getListTimeKeeping(DateTime date) async {
    EasyLoading.show();
    UserPreference user = AppDependencies.injector<UserPreference>();
    DateTime dateAfter = DateTime(date.year, date.month, date.day + 1);
    GetHistoriesResponse response = await _timeKeepingService.getHistories(
      GetHistoriesRequest(
        filters: [
          '["Employee Checkin","time", "Between", ["${DateFormat('yyyy-MM-dd').format(date)}", "${DateFormat('yyyy-MM-dd').format(dateAfter)}"]]',
          '["Employee Checkin","owner","=","${user.userId}"]'
        ],
      ),
    );
    EasyLoading.dismiss();
    emit(TimeKeepingListState(listTimeKeeping: response.listTimeKeeping));
  }
}
