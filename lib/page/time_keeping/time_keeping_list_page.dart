import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/common_widget/date_picker_widget.dart';
import 'package:erp_app/common_widget/page_header_widget.dart';
import 'package:erp_app/constants/constants.dart';
import 'package:erp_app/model/time_keeping_model.dart';
import 'package:erp_app/page/time_keeping/time_keeping_detail_page.dart';
import 'package:erp_app/style/my_color.dart';
import 'package:erp_app/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TimeKeepingListPage extends StatefulWidget {
  const TimeKeepingListPage({Key? key}) : super(key: key);

  @override
  _TimeKeepingListPageState createState() => _TimeKeepingListPageState();
}

class _TimeKeepingListPageState extends State<TimeKeepingListPage> {
  List<TimeKeepingModel> listCheck = [
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: true),
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: false),
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: true),
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: false),
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: true),
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: false),
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: true),
    TimeKeepingModel(checkTime: DateTime.now(), isCheckin: false),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
              12,
              MediaQuery.of(context).padding.top + 12,
              12,
              12,
            ),
            child: Column(
              children: [
                PageHeaderWidget(
                  label: tr('time_keeping'),
                  textColor: theme.accentColor,
                ),
                const SizedBox(height: 24),
                _WeekCalendar(
                  initialDate: DateTime.now(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('timekeeping_history'),
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _TimeKeepingItemWidget(value: listCheck[index]);
                      },
                      itemCount: listCheck.length,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _WeekCalendar extends StatefulWidget {
  final DateTime initialDate;
  const _WeekCalendar({Key? key, required this.initialDate}) : super(key: key);

  @override
  __WeekCalendarState createState() => __WeekCalendarState();
}

class __WeekCalendarState extends State<_WeekCalendar> {
  late List<DateTime> listDates;
  late String _dateString;
  late String _timeString;

  late DateTime _selectedDate;
  final ItemScrollController itemScrollController = ItemScrollController();
  late Timer _timer;

  @override
  void initState() {
    listDates = DateTimeUtils.getListWeeks(
      DateTime(2022),
      DateTime(2023),
    );
    _timeString = DateFormat('HH:mm:ss').format(DateTime.now());
    _dateString =
        "${tr('date')} ${DateTime.now().day}, ${tr('month')} ${DateTime.now().month} ${tr('year')} ${DateTime.now().year}";
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _getTime());
    _selectedDate = widget.initialDate;
    super.initState();
  }

  void _getTime() {
    setState(() {
      _timeString = DateFormat('HH:mm:ss').format(DateTime.now());
      _dateString =
          "${tr('date')} ${DateTime.now().day}, ${tr('month')} ${DateTime.now().month} ${tr('year')} ${DateTime.now().year}";
    });
  }

  void _setTime() {
    if (DateTimeUtils.isEqual(_selectedDate, DateTime.now())) {
      _timer =
          Timer.periodic(const Duration(seconds: 1), (timer) => _getTime());
    } else {
      _dateString =
          "${tr('date')} ${_selectedDate.day}, ${tr('month')} ${_selectedDate.month} ${tr('year')} ${_selectedDate.year}";
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              initialScrollIndex: listDates.any((element) =>
                      DateTimeUtils.isEqual(element, _selectedDate))
                  ? listDates
                      .asMap()
                      .entries
                      .firstWhere(
                        (element) =>
                            DateTimeUtils.isEqual(element.value, _selectedDate),
                      )
                      .key
                  : 0,
              itemScrollController: itemScrollController,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedDate = listDates[index];
                      _setTime();
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color:
                          DateTimeUtils.isEqual(listDates[index], _selectedDate)
                              ? theme.primaryColor
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      WeekDay.weekDay[listDates[index].weekday - 1],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: DateTimeUtils.isEqual(
                                listDates[index], _selectedDate)
                            ? Colors.white
                            : theme.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
              itemCount: listDates.length,
            ),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2022),
              lastDate: DateTime(2023),
            );
            if (date != null) {
              setState(() {
                _selectedDate = date;
                itemScrollController.scrollTo(
                    index: listDates.any((element) =>
                            DateTimeUtils.isEqual(element, _selectedDate))
                        ? listDates
                            .asMap()
                            .entries
                            .firstWhere(
                              (element) => DateTimeUtils.isEqual(
                                  element.value, _selectedDate),
                            )
                            .key
                        : 0,
                    duration: const Duration(milliseconds: 600));
                _setTime();
              });
            }
          },
          child: Text(
            _dateString,
            style: theme.textTheme.headline4,
          ),
        ),
        const SizedBox(height: 8),
        Visibility(
          visible: DateTimeUtils.isEqual(DateTime.now(), _selectedDate),
          child: Text(
            _timeString,
            style: theme.textTheme.headline5,
          ),
        ),
        const SizedBox(height: 12),
        Visibility(
          visible: DateTimeUtils.isEqual(DateTime.now(), _selectedDate),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    width: 120,
                    alignment: Alignment.center,
                    child: Text(
                      tr('checkin'),
                      style: theme.textTheme.headline4,
                    ),
                  ),
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => const TimeKeepingDetailPage(),
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  }),
              const SizedBox(width: 12),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  width: 120,
                  child: Text(
                    tr('checkout'),
                    style: theme.textTheme.headline4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeKeepingItemWidget extends StatelessWidget {
  final TimeKeepingModel value;
  const _TimeKeepingItemWidget({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        value.isCheckin ? MyColors.checkinColor : MyColors.checkoutColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color,
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              DateFormat('HH:mm').format(value.checkTime),
              style: theme.textTheme.headline4,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value.isCheckin ? tr('checkin') : tr('checkout'),
                      style: theme.textTheme.headline4,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      value.isCheckin ? Iconsax.login : Iconsax.logout,
                      color: color,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
