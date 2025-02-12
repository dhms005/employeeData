import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/utils/appStrings.dart';
import 'package:employeedata/widgetUI/customAppBar.dart';
import 'package:employeedata/widgetUI/dark_fixed_button.dart';
import 'package:employeedata/widgetUI/date_selection_field.dart';
import 'package:employeedata/widgetUI/light_fixed_button.dart';
import 'package:employeedata/widgetUI/role_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../models/employee_model.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const AddEditEmployeeScreen({Key? key, this.employee}) : super(key: key);

  @override
  _AddEditEmployeeScreenState createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.employee?.employeeName ?? '');
    _roleController =
        TextEditingController(text: widget.employee?.employeeRole ?? '');
    _startDateController =
        TextEditingController(text: widget.employee?.employeeStartDate ?? '');
    _endDateController =
        TextEditingController(text: widget.employee?.employeeEndDate ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.employee?.id,
        employeeName: _nameController.text,
        employeeRole: _roleController.text,
        employeeStartDate: _startDateController.text,
        employeeEndDate: _endDateController.text,
      );

      final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
      if (widget.employee == null) {
        // Adding new employee
        employeeBloc.add(AddEmployee(employee));
      } else {
        // Updating existing employee
        employeeBloc.add(UpdateEmployee(employee));
      }

      Navigator.pop(context); // Close the screen
    }
  }

  void _deleteEmployee() {
    if (widget.employee != null) {
      BlocProvider.of<EmployeeBloc>(context)
          .add(DeleteEmployee(widget.employee!.id!));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double fieldWidth =
        (MediaQuery.of(context).size.width - 86) / 2; // Adjusting width
    final DateFormat dateFormat = DateFormat('d MMM yyyy');

    return Scaffold(
      appBar: CustomAppBar(
        appTitle: widget.employee == null
            ? AppStrings.addEmployeeDetails
            : AppStrings.editEmployeeDetails,
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Name
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: AppColors.editTextColor,
                        ),
                        decoration: InputDecoration(
                          // labelText: "Employee name",
                          hintText: AppStrings.employeeName,
                          hintStyle: TextStyle(
                            color: AppColors.editTextHintColor,
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          prefixIcon: Padding(
                            padding:
                                EdgeInsets.all(9), // Adjust padding if needed
                            child: SvgPicture.asset(
                              AppImagePath.imgPerson,
                              height: 15,
                              width: 15,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.mainColor, BlendMode.srcIn),
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          // User icon inside TextField
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(5), // Rounded corners
                            borderSide: BorderSide(
                                color: AppColors.editTextBorderColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: AppColors.editTextBorderColor,
                                width: 1), // Light grey border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: AppColors.editTextBorderColor,
                                width: 1), // Highlight on focus
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Colors.red, width: 1), // Red on focus
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        validator: (value) => value!.isEmpty
                            ? AppStrings.enterEmployeeName
                            : null,
                      ),
                      SizedBox(height: 23),
                      // Role
                      RoleSelectionField(controller: _roleController),
                      SizedBox(height: 23),

                      // Date Picker Start and End
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Start Date Picker
                            DateSelectionField(
                              placeholder: AppStrings.noDate,
                              width: fieldWidth,
                              initialDate: widget.employee == null
                                  ? null
                                  : dateFormat.parse(_startDateController.text),
                              onDateSelected: (date) {
                                print("Selected Date: $date");
                                // _startDateController.text = date.toString();
                                _startDateController.text =
                                    dateFormat.format(date!);
                              },
                            ),

                            // Arrow Icon in Center
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(Icons.arrow_forward,
                                  color: Colors.blue, size: 24),
                            ),

                            // End Date Picker
                            DateSelectionField(
                              placeholder: AppStrings.noDate,
                              width: fieldWidth,
                              initialDate: widget.employee == null
                                  ? null
                                  : (_endDateController.text.isEmpty
                                      ? null
                                      : dateFormat
                                          .parse(_endDateController.text)),
                              onDateSelected: (date) {
                                print("Selected Date: $date");
                                _endDateController.text =
                                    dateFormat.format(date!);
                              },
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: AppColors.editTextBorderColor,
              ),
              // SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ElevatedButton(
                    //   onPressed: _saveEmployee,
                    //   child: Text(widget.employee == null
                    //       ? "Add Employee"
                    //       : "Update Employee"),
                    // ),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: LightFixedButton(text: AppStrings.cancel),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: _saveEmployee,
                      child: DarkFixedButton(text: AppStrings.save),
                    )
                  ],
                ),
              ),
              if (widget.employee != null)
                TextButton(
                  onPressed: _deleteEmployee,
                  child: Text("Delete Employee",
                      style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
