import '../models/employee.dart';

abstract class EmployeeState {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  const EmployeeLoaded(this.employees);
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);
}

class EmployeeDeleted extends EmployeeState {
  final Employee employee;

  const EmployeeDeleted(this.employee);
}