import 'package:flutter/material.dart';

import '../../models/employee.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback? onPressed;

  const EmployeeCard({super.key, required this.employee, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${employee.firstName} ${employee.lastName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'ID: ${employee.id}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Category: ${employee.category.toString().split('.').last}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}