import 'package:erp_app/bloc/bloc.dart';
import 'package:erp_app/bloc/time_keeping/time_keeping_detail_bloc.dart';
import 'package:erp_app/bloc/time_keeping/time_keeping_list_bloc.dart';
import 'package:get_it/get_it.dart';

class BlocDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<LoginBloc>(() => LoginBloc());
    injector.registerFactory<TimeKeepingListBloc>(() => TimeKeepingListBloc());
    injector
        .registerFactory<TimeKeepingDetailBloc>(() => TimeKeepingDetailBloc());
  }
}
