
import 'dart:async';

import '../models/employee.dart';

class EmployeeService {
  List<Employee> employees = [
    Employee(firstName: 'Jason', lastName: 'Willcox', id: '1', category: EmployeeCategory.IT),
    Employee(firstName: 'Manish', lastName: 'Kiranagi', id: '2', category: EmployeeCategory.IT),
    Employee(firstName: 'Victoria', lastName: 'Znamenskaya', id: '3', category: EmployeeCategory.HR),
    Employee(firstName: 'Ahmed', lastName: 'Elsaadany', id: '4', category: EmployeeCategory.HR),
  ];

  Future<List<Employee>> fetchEmployees(EmployeeCategory category) async {
    await Future.delayed(const Duration(seconds: 2));

    List<Employee> filteredEmployees = employees.where((employee) => employee.category == category).toList();

    return filteredEmployees;
  }

  Future<void> deleteEmployee(Employee employee) async {
    await Future.delayed(const Duration(seconds: 2));

    employees.removeWhere((e) => e.id == employee.id);
  }
}