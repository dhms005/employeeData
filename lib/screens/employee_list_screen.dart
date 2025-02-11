import 'package:employeedata/utils/appStrings.dart';
import 'package:employeedata/widgetUI/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/employee_bloc.dart';
import '../bloc/employee_state.dart';
import 'add_edit_employee_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Employees")),
      appBar: CustomAppBar(
        appTitle: AppStrings.employeeList,
        appBar: AppBar(),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final employee = state.employees[index];
                return ListTile(
                  title: Text(employee.employeeName),
                  subtitle: Text(employee.employeeRole),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AddEditEmployeeScreen(employee: employee),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text("No Employees Found"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditEmployeeScreen()),
          );
        },
      ),
    );
  }
}
