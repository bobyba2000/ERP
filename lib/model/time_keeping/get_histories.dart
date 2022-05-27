import 'package:erp_app/model/time_keeping_model.dart';

class GetHistoriesRequest {
  String doctype = 'Employee Checkin';
  List<String> fields = [
    '"`tabEmployee Checkin`.`name`"',
    '"`tabEmployee Checkin`.`owner`"',
    '"`tabEmployee Checkin`.`employee_name`"',
    '"`tabEmployee Checkin`.`log_type`"',
    '"`tabEmployee Checkin`.`time`"',
    '"`tabEmployee Checkin`.`location`"',
    '"`tabEmployee Checkin`.`far_location`"',
    '"`tabEmployee Checkin`.`image`"'
  ];
  List<String> filters;
  String orderBy =
      '`tabEmployee Checkin`.`modified` ASC, `tabEmployee Checkin`.`time` DESC';
  int start = 0;
  int pageLength = 200;
  String view = 'List';
  String groupBy = "`tabEmployee Checkin`.`name`";
  bool withCommentCount = false;

  GetHistoriesRequest({
    required this.filters,
  });

  Map<String, dynamic> toMap() => {
        'doctype': doctype,
        'fields': "[${fields.join(',')}]",
        'filters': "[${filters.join(',')}]",
        'order_by': orderBy,
        'start': start.toString(),
        'page_length': pageLength.toString(),
        'view': view,
        'group_by': groupBy,
        'with_comment_count': withCommentCount.toString(),
      };
}

class GetHistoriesResponse {
  List<TimeKeepingModel> listTimeKeeping;
  String? errorMessage;
  bool isSuccess;

  GetHistoriesResponse({
    required this.listTimeKeeping,
    this.errorMessage,
    required this.isSuccess,
  });

  factory GetHistoriesResponse.fromJson(dynamic json) {
    if (json['message']['values'] != null) {
      List<TimeKeepingModel> res = (json['message']['values'] as List)
          .map(
            (e) => TimeKeepingModel.fromJson(e),
          )
          .toList();
      return GetHistoriesResponse(
        listTimeKeeping: res,
        isSuccess: true,
      );
    }
    return GetHistoriesResponse(listTimeKeeping: [], isSuccess: true);
  }
}
