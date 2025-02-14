import 'package:employeedata/bloc/employee_event.dart';
import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/utils/appStrings.dart';
import 'package:employeedata/widgetUI/customAppBar.dart';
import 'package:employeedata/widgetUI/employee_section_title.dart';
import 'package:employeedata/widgetUI/empty_employee.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/employee_bloc.dart';
import '../bloc/employee_state.dart';
import 'add_edit_employee_screen.dart';

/// 📌 EmployeeList UI
class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: AppStrings.employeeList,
        appBar: AppBar(),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            /// 📌 Empty state UI
            if (state.employees.isEmpty) {
              return EmptyEmployee(); //
            }

            /// 📌 Separate Employees into Current and Previous Lists
            final currentEmployees =
                state.employees.where((e) => e.employeeEndDate == "").toList();
            final previousEmployees =
                state.employees.where((e) => e.employeeEndDate != "").toList();

            /// 📌 List UI
            return SafeArea(
              child: Container(
                color: AppColors.lineColorColor,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        children: [
                          /// 📌  Current Employees Section
                          if (currentEmployees.isNotEmpty)

                            /// 📌 Employees Section
                            EmployeeSectionTitle(
                                title: AppStrings.currentEmployees),
                          ...currentEmployees.map(
                              (employee) => _employeeCard(context, employee)),

                          /// 📌 Previous Employees Section
                          if (previousEmployees.isNotEmpty)

                            /// 📌 Employees Section
                            EmployeeSectionTitle(
                                title: AppStrings.previousEmployees),
                          ...previousEmployees.map(
                              (employee) => _employeeCard(context, employee)),
                        ],
                      ),
                    ),
                    // SizedBox(height: 20),
                    /// 📌 Swipe Text
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        child: TextRobotoFont(
                          title: "Swipe left to delete",
                          fontColor: AppColors.editTextHintColor,
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
            );
          } else {
            /// 📌 Empty state UI
            return EmptyEmployee();
          }
        },
      ),

      /// 📌 FloatButton
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded Rectangle Shape
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditEmployeeScreen()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  /// 📌 UI for Employee Item with Swipe-to-Delete
  Widget _employeeCard(BuildContext context, employee) {
    return Dismissible(
      key: Key(employee.employeeName),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(14), // Adjust padding if needed
          child: SvgPicture.asset(
            AppImagePath.imgDelete,
            height: 24,
            width: 24,
            colorFilter: const ColorFilter.mode(AppColors.mainWhiteColor,
                BlendMode.srcIn), // Optional: Change color
          ),
        ),
      ),
      onDismissed: (direction) {
        BlocProvider.of<EmployeeBloc>(context).add(DeleteEmployee(employee.id));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextRobotoFont(
              title: AppStrings.employeeDataHasBeenDeleted,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontColor: AppColors.mainWhiteColor,
            ),
            action: SnackBarAction(
              label: AppStrings.undo,
              onPressed: () {
                BlocProvider.of<EmployeeBloc>(context)
                    .add(AddEmployee(employee));
              },
            ),
            duration: Duration(seconds: 3),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddEditEmployeeScreen(employee: employee)),
          );
        },

        /// 📌 Employee Item UI
        child: Container(
          color: AppColors.mainWhiteColor,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(vertical: 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextRobotoFont(
                title: employee.employeeName,
                fontColor: AppColors.editTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              TextRobotoFont(
                title: employee.employeeRole,
                fontColor: AppColors.lightTextColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              if (employee.employeeEndDate != "")
                TextRobotoFont(
                  title:
                      "${employee.employeeStartDate} - ${employee.employeeEndDate}",
                  fontColor: AppColors.lightTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                )
              else
                TextRobotoFont(
                  title: "From ${employee.employeeStartDate}",
                  fontColor: AppColors.lightTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
