class Employee {
  int? id;
  String employeeName;
  String employeeRole;
  String employeeStartDate;
  String employeeEndDate;

  Employee({
    this.id,
    required this.employeeName,
    required this.employeeRole,
    required this.employeeStartDate,
    required this.employeeEndDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeName': employeeName,
      'employeeRole': employeeRole,
      'employeeStartDate': employeeStartDate,
      'employeeEndDate': employeeEndDate,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      employeeName: map['employeeName'],
      employeeRole: map['employeeRole'],
      employeeStartDate: map['employeeStartDate'],
      employeeEndDate: map['employeeEndDate'],
    );
  }
}
