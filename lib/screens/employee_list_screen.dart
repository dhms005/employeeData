import 'package:employeedata/bloc/employee_event.dart';
import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/utils/appStrings.dart';
import 'package:employeedata/widgetUI/customAppBar.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/employee_bloc.dart';
import '../bloc/employee_state.dart';
import 'add_edit_employee_screen.dart';

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
            // 🏷️ Separate Employees into Current and Previous Lists

            // Empty state UI
            if (state.employees.isEmpty) {
              return _buildEmptyState(); //
            }

            final currentEmployees =
                state.employees.where((e) => e.employeeEndDate == "").toList();
            final previousEmployees =
                state.employees.where((e) => e.employeeEndDate != "").toList();

            // List UI
            return SafeArea(
              child: Container(
                color: AppColors.lineColorColor,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        children: [
                          //  Current Employees Section
                          if (currentEmployees.isNotEmpty)
                            _sectionTitle(AppStrings.currentEmployees),
                          ...currentEmployees.map(
                              (employee) => _employeeCard(context, employee)),

                          // Previous Employees Section
                          if (previousEmployees.isNotEmpty)
                            _sectionTitle(AppStrings.previousEmployees),
                          ...previousEmployees.map(
                              (employee) => _employeeCard(context, employee)),
                        ],
                      ),
                    ),
                    // SizedBox(height: 20),
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
            return _buildEmptyState();
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

  /// 📌 Section Title Widget
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: TextRobotoFont(
        title: title,
        fontColor: AppColors.mainColor,
        fontSize: 16,
        fontWeight: FontWeight.values[5],
      ),
    );
  }

  /// 📌 Employee Card Widget with Swipe-to-Delete
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
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddEditEmployeeScreen(employee: employee)),
          );
        },
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
                fontWeight: FontWeight.values[5],
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

  /// 📌 UI for Empty Employee List
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: 250,
          //   height: 250,
          //   child:
          //       Image.asset('assets/images/not_data.png', fit: BoxFit.fitWidth),
          // ),
          SvgPicture.asset(
            AppImagePath.imgNoData,
            width: 250,
          ),
          TextRobotoFont(
            title: AppStrings.noEmployeeRecordsFound,
            fontColor: AppColors.editTextColor,
            fontWeight: FontWeight.values[5],
            fontSize: 17,
          )
        ],
      ),
    );
  }
}
