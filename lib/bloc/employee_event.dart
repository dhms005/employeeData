import 'package:equatable/equatable.dart';
import '../models/employee_model.dart';

abstract class EmployeeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;
  AddEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;
  UpdateEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

class DeleteEmployee extends EmployeeEvent {
  final int id;
  DeleteEmployee(this.id);

  @override
  List<Object?> get props => [id];
}
