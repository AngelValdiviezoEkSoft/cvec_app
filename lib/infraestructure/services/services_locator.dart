import 'package:get_it/get_it.dart';
import 'package:cve_app/ui/ui.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  
  //#Region Blocs 
  getIt.registerLazySingleton(() => GenericBloc());
  getIt.registerLazySingleton(() => AuthBloc());  
  //#EndRegion
}
