import 'package:easy_localization/easy_localization.dart';

class TimeKeepingModel {
  String? owner;
  String? employeeName;
  String? logType;
  DateTime? time;
  String? location;
  int? farLocation;
  String? image;
  String? employee;
  TimeKeepingModel();

  factory TimeKeepingModel.fromJson(dynamic json) {
    List<dynamic> timeJson = List.from(json);
    TimeKeepingModel res = TimeKeepingModel();
    res.owner = timeJson[1] as String;
    res.employeeName = timeJson[2] as String;
    res.logType = timeJson[3] as String;
    res.time = DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeJson[4] as String);
    res.location = timeJson[5] as String?;
    res.farLocation = timeJson[6] as int;
    res.image = timeJson[7] as String?;
    return res;
  }
}
