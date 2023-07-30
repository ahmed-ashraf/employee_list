// lib/screens/home_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/employee_bloc.dart';
import '../../bloc/employee_event.dart';
import '../../bloc/employee_state.dart';
import '../../di/service_locator.dart';
import '../../models/employee.dart';
import '../widgets/progress_indicator.dart';
import 'employee_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    return BlocProvider<EmployeeBloc>(
      create: (context) =>
          EmployeeBloc(employeeRepository: serviceLocator.get())
            ..add(const FetchEmployees(EmployeeCategory.IT)),
      child: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is EmployeeDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Employee ${state.employee.firstName} deleted'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.read<EmployeeBloc>().add(RefreshEmployees(
                _selectedIndex == 0
                    ? EmployeeCategory.IT
                    : EmployeeCategory.HR));
          }
        },
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Employee List'),
                ),
                body: const Center(child: MyProgressIndicator()));
          } else if (state is EmployeeLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Employee List'),
                actions: [
                  if (kIsWeb)
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        _refreshIndicatorKey.currentState?.show();
                      },
                    ),
                ],
              ),
              bottomNavigationBar: !isWideScreen
                  ? BottomNavigationBar(
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.computer),
                          label: 'IT',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.engineering),
                          label: 'HR',
                        ),
                      ],
                      currentIndex: _selectedIndex,
                      onTap: (index) => _onDestinationSelected(context, index),
                    )
                  : null,
              body: Row(
                children: [
                  if (isWideScreen)
                    NavigationRail(
                      destinations: _buildDestinations(),
                      onDestinationSelected: (index) =>
                          _onDestinationSelected(context, index),
                      selectedIndex: _selectedIndex,
                      labelType: NavigationRailLabelType.selected,
                    ),
                  Expanded(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        _onDestinationSelected(context, _selectedIndex,
                            forceRefresh: true);
                      },
                      child: state.employees.isEmpty
                          ? const Center(child: Text('No items in the list'))
                          : ListView.builder(
                              itemCount: state.employees.length,
                              itemBuilder: (context, index) {
                                return EmployeeCard(
                                  employee: state.employees[index],
                                  onPressed: () {
                                    context.read<EmployeeBloc>().add(
                                        DeleteEmployee(state.employees[index]));
                                  },
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
              appBar: AppBar(
            title: const Text('Employee List'),
          ));
        },
      ),
    );
  }

  List<NavigationRailDestination> _buildDestinations() {
    return [
      const NavigationRailDestination(
        icon: Icon(Icons.computer),
        label: Text('IT'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.engineering),
        label: Text('HR'),
      ),
    ];
  }

  void _onDestinationSelected(BuildContext context, int index,
      {bool forceRefresh = false}) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      forceRefresh
          ? context
              .read<EmployeeBloc>()
              .add(const RefreshEmployees(EmployeeCategory.IT))
          : context
              .read<EmployeeBloc>()
              .add(const FetchEmployees(EmployeeCategory.IT));
    } else if (index == 1) {
      forceRefresh
          ? context
              .read<EmployeeBloc>()
              .add(const RefreshEmployees(EmployeeCategory.HR))
          : context
              .read<EmployeeBloc>()
              .add(const FetchEmployees(EmployeeCategory.HR));
    }
  }
}
