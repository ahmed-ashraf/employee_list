enum EmployeeCategory { IT, HR }

class Employee {
  final String firstName;
  final String lastName;
  final String id;
  final EmployeeCategory category;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.category,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    String category = json['category'];
    EmployeeCategory employeeCategory;

    switch (category) {
      case 'IT':
        employeeCategory = EmployeeCategory.IT;
        break;
      case 'HR':
        employeeCategory = EmployeeCategory.HR;
        break;
      default:
        throw Exception('Invalid category');
    }

    return Employee(
      firstName: json['firstName'],
      lastName: json['lastName'],
      id: json['id'],
      category: employeeCategory,
    );
  }

  Map<String, dynamic> toJson() {
    String category;

    switch (this.category) {
      case EmployeeCategory.IT:
        category = 'IT';
        break;
      case EmployeeCategory.HR:
        category = 'HR';
        break;
    }

    return {
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'category': category,
    };
  }
}