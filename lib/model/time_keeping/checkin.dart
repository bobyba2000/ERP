class CheckinRequest {
  String owner;
  String time;
  String employeeName;
  String employee;
  int farLocation;
  String name;

  CheckinRequest(
      {required this.employee,
      required this.owner,
      required this.time,
      required this.employeeName,
      required this.farLocation,
      required this.name});

  Map toMap() => {
        'doc': {
          "docstatus": 0,
          "doctype": "Employee Checkin",
          "name": name,
          "__islocal": 1,
          "__unsaved": 1,
          "owner": owner,
          "log_type": "Checkin",
          "time": time,
          "skip_auto_attendance": 0,
          "employee_name": employeeName,
          "employee": employee,
          "far_location": farLocation,
        },
        'action': 'Save',
      };
}
