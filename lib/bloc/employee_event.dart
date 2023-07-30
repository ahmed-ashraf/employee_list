import '../models/employee.dart';

abstract class EmployeeEvent {
  const EmployeeEvent();
}

class FetchEmployees extends EmployeeEvent {
  final EmployeeCategory category;

  const FetchEmployees(this.category);
}

class DeleteEmployee extends EmployeeEvent {
  final Employee employee;

  const DeleteEmployee(this.employee);
}

class RefreshEmployees extends EmployeeEvent {
  final EmployeeCategory category;

  const RefreshEmployees(this.category);
}
