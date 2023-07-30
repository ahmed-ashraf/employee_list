import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;

  EmployeeBloc({required this.employeeRepository}) : super(EmployeeInitial()) {
    on<FetchEmployees>(fetchEmployeesHandler);
    on<RefreshEmployees>(refreshEmployeesHandler);
    on<DeleteEmployee>(deleteEmployeeHandler);
  }

  Future<void> fetchEmployeesHandler(
      FetchEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      final employees = await employeeRepository.fetchEmployees(event.category);
      emit(EmployeeLoaded(employees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  Future<void> refreshEmployeesHandler(
      RefreshEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      final employees = await employeeRepository.fetchEmployees(event.category,
          forceRefresh: true);
      emit(EmployeeLoaded(employees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  Future<void> deleteEmployeeHandler(
      DeleteEmployee event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      await employeeRepository.deleteEmployee(event.employee);
      emit(EmployeeDeleted(event.employee));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}
