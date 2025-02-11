import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/database_helper.dart';
import '../models/employee_model.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  EmployeeBloc() : super(EmployeeInitial()) {
    on<LoadEmployees>((event, emit) async {
      emit(EmployeeLoading());
      try {
        final employees = await databaseHelper.fetchEmployees();
        emit(EmployeeLoaded(employees));
      } catch (e) {
        emit(EmployeeError("Failed to load employees"));
      }
    });

    on<AddEmployee>((event, emit) async {
      await databaseHelper.insertEmployee(event.employee);
      add(LoadEmployees());
    });

    on<UpdateEmployee>((event, emit) async {
      await databaseHelper.updateEmployee(event.employee);
      add(LoadEmployees());
    });

    on<DeleteEmployee>((event, emit) async {
      await databaseHelper.deleteEmployee(event.id);
      add(LoadEmployees());
    });
  }
}
