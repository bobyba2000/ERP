class TimeKeepingModel {
  bool isCheckin;
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  DateTime? modified_by;
  int? idx;
  String? employee_name;
  String? log_type;
  DateTime? time;
  DateTime checkTime;
  TimeKeepingModel({
    this.isCheckin = true,
    required this.checkTime,
  });
}
