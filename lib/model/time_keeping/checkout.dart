class CheckoutRequest {
  String owner;
  String time;
  String employeeName;
  String employee;
  int? farLocation;
  String location;
  String name;
  String image;

  CheckoutRequest({
    required this.employee,
    required this.owner,
    required this.time,
    required this.employeeName,
    this.farLocation,
    required this.image,
    required this.location,
    required this.name,
  });

  Map toMap() => {
        'doc': {
          "docstatus": 0,
          "doctype": "Employee Checkin",
          "name": name,
          "__islocal": 1,
          "__unsaved": 1,
          "owner": owner,
          "log_type": "Checkout",
          "time": time,
          "skip_auto_attendance": 0,
          "employee_name": employeeName,
          "employee": employee,
          "image": image,
          "location": location,
          "far_location": farLocation,
        },
        'action': 'Save',
      };
}
