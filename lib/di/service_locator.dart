import 'package:get_it/get_it.dart';

import '../repositories/employee_repository.dart';
import '../services/employee_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<EmployeeService>(
      () => EmployeeService());
  serviceLocator.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepository(serviceLocator.get()));
}
