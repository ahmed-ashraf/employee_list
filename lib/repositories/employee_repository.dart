import '../models/employee.dart';
import '../services/employee_service.dart';

class EmployeeRepository {
  final EmployeeService _employeeService;
  List<Employee>? _itEmployees;
  List<Employee>? _hrEmployees;

  set itEmployees(List<Employee>? value) {
    _itEmployees = value;
  }

  List<Employee>? get itEmployees => _itEmployees;

  EmployeeRepository(this._employeeService);

  Future<List<Employee>> fetchEmployees(EmployeeCategory category,
      {bool forceRefresh = false}) async {
    if (!forceRefresh) {
      if (category == EmployeeCategory.IT && _itEmployees != null) {
        return _itEmployees!;
      } else if (category == EmployeeCategory.HR && _hrEmployees != null) {
        return _hrEmployees!;
      }
    }

    final employees = await _employeeService.fetchEmployees(category);

    if (category == EmployeeCategory.IT) {
      _itEmployees = employees;
    } else {
      _hrEmployees = employees;
    }

    return employees;
  }

  Future<void> deleteEmployee(Employee employee) async {
    await _employeeService.deleteEmployee(employee);

    _itEmployees?.remove(employee);
    _hrEmployees?.remove(employee);
  }

  set hrEmployees(List<Employee>? value) {
    _hrEmployees = value;
  }

  List<Employee>? get hrEmployees => _hrEmployees;
}
