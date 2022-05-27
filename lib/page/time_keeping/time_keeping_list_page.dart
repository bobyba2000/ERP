import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/bloc/time_keeping/time_keeping_bloc.dart';
import 'package:erp_app/common_widget/page_header_widget.dart';
import 'package:erp_app/constants/constants.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/page/time_keeping/time_keeping_detail_page.dart';
import 'package:erp_app/page/time_keeping/time_keeping_item_widget.dart';
import 'package:erp_app/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TimeKeepingListPage extends StatefulWidget {
  const TimeKeepingListPage({Key? key}) : super(key: key);

  @override
  _TimeKeepingListPageState createState() => _TimeKeepingListPageState();
}

class _TimeKeepingListPageState extends State<TimeKeepingListPage> {
  TimeKeepingBloc bloc = AppDependencies.injector<TimeKeepingBloc>();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocProvider<TimeKeepingBloc>(
        create: (context) => bloc..getListTimeKeeping(DateTime.now()),
        child: BlocBuilder<TimeKeepingBloc, TimeKeepingState>(
            builder: (context, state) {
          return Column(
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
                      rightIcon: Icons.calendar_month,
                      onTapRightIcon: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2023),
                        );
                        if (date != null) {
                          bloc.getListTimeKeeping(date);
                          setState(() {
                            selectedDate = date;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    _WeekCalendar(
                      initialDate: selectedDate,
                      onChange: (DateTime value) {
                        if (value != selectedDate) {
                          bloc.getListTimeKeeping(value);
                          setState(() {
                            selectedDate = value;
                          });
                        }
                      },
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
                      Visibility(
                        visible: state.listTimeKeeping.isNotEmpty,
                        child: Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return TimeKeepingItemWidget(
                                  value: state.listTimeKeeping[index]);
                            },
                            itemCount: state.listTimeKeeping.length,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: state.listTimeKeeping.isEmpty,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                tr('no_timekeeping_data'),
                                style: theme.textTheme.headline5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class _WeekCalendar extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onChange;
  const _WeekCalendar({
    Key? key,
    required this.initialDate,
    required this.onChange,
  }) : super(key: key);

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
  void didUpdateWidget(covariant _WeekCalendar oldWidget) {
    if (oldWidget.initialDate != widget.initialDate) {
      final date = widget.initialDate;
      setState(() {
        _selectedDate = date;
        itemScrollController.scrollTo(
            index: listDates.any(
                    (element) => DateTimeUtils.isEqual(element, _selectedDate))
                ? listDates
                    .asMap()
                    .entries
                    .firstWhere(
                      (element) =>
                          DateTimeUtils.isEqual(element.value, _selectedDate),
                    )
                    .key
                : 0,
            duration: const Duration(milliseconds: 600));
        _setTime();
      });

      widget.onChange.call(date);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
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
                    widget.onChange.call(listDates[index]);
                  },
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color:
                          DateTimeUtils.isEqual(listDates[index], _selectedDate)
                              ? theme.primaryColor
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: DateTimeUtils.isEqual(
                                listDates[index], DateTime.now())
                            ? theme.primaryColor
                            : Colors.transparent,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
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
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('dd/MM').format(listDates[index]),
                          style: TextStyle(
                            color: DateTimeUtils.isEqual(
                                    listDates[index], _selectedDate)
                                ? Colors.white
                                : theme.accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: listDates.length,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _dateString,
          style: theme.textTheme.headline4,
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
