class CheckinRequest {
  String owner;
  String time;
  String employeeName;
  String employee;
  int farLocation;
  String logtype;
  // String name;

  CheckinRequest({
    required this.employee,
    required this.owner,
    required this.time,
    required this.employeeName,
    required this.farLocation,
    required this.logtype,
    // required this.name,
  });

  Map<String, dynamic> toMap() => {
        'doc':
            '{"doctype":"Employee Checkin","owner":"$owner","log_type":"$logtype","time":"$time","employee_name":"$employeeName","employee":"$employee","location":"Gigamall","far_location":0}',
        'action': 'Save',
      };
}
