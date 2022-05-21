import 'package:erp_app/bloc/bloc_dependencies.dart';
import 'package:erp_app/preference/user_preference.dart';
import 'package:erp_app/services/services_dependencies.dart';
import 'package:get_it/get_it.dart';

class AppDependencies {
  AppDependencies._();

  static GetIt get injector => GetIt.I;

  static Future initialize() async {
    ServiceDependencies.init(injector);
    BlocDependencies.init(injector);
    injector.registerLazySingleton<UserPreference>(() => UserPreference());
  }
}
