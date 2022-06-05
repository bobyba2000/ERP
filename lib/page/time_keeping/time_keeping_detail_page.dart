import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/bloc/time_keeping/time_keeping_detail_bloc.dart';
import 'package:erp_app/common_widget/network_image_widget.dart';
import 'package:erp_app/constants.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/model/time_keeping_model.dart';
import 'package:erp_app/page/time_keeping/time_keeping_camera_widget.dart';
import 'package:erp_app/preference/user_preference.dart';
import 'package:erp_app/style/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iconsax/iconsax.dart';

class TimeKeepingDetailPage extends StatefulWidget {
  final TimeKeepingModel? value;
  const TimeKeepingDetailPage({Key? key, this.value}) : super(key: key);

  @override
  _TimeKeepingDetailPageState createState() => _TimeKeepingDetailPageState();
}

class _TimeKeepingDetailPageState extends State<TimeKeepingDetailPage> {
  final String _dateString =
      "${tr('date')} ${DateTime.now().day}, ${tr('month')} ${DateTime.now().month} ${tr('year')} ${DateTime.now().year}";
  final String _timeString = DateFormat('HH:mm').format(DateTime.now());

  List<String> listCompany = [
    'Microsoft',
    'Viettel',
    'Mobiphone',
    'VNG',
    'FPT Software',
    'Google'
  ];

  List<String> listConstruction = [
    'Cầu Bình Lợi',
    'Cầu chữ Y',
    'Đại học Bách Khoa',
    'Đại học KHTN',
  ];

  bool isCheckin = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserPreference userPreference = AppDependencies.injector<UserPreference>();
  TimeKeepingDetailBloc bloc =
      AppDependencies.injector<TimeKeepingDetailBloc>();

  @override
  void initState() {
    super.initState();
    bloc.initValue(
      widget.value ??
          (TimeKeepingModel()
            ..owner = userPreference.userId
            ..employee = userPreference.employee
            ..employeeName = userPreference.employeeName
            ..logType = 'Checkin'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeKeepingDetailBloc>(
      create: (context) => bloc,
      child: BlocBuilder<TimeKeepingDetailBloc, TimeKeepingDetailState>(
        builder: (context, state) {
          return buildScreen(context, state.value);
        },
      ),
    );
  }

  Widget buildScreen(BuildContext context, TimeKeepingModel value) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final switchWidth = size.width - 12 * 2;
    return Container(
      padding: const EdgeInsets.all(12),
      width: size.width,
      height: size.height - 40,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    child: Icon(
                      Iconsax.arrow_left,
                      color: theme.accentColor,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text(
                    tr('time_keeping').toUpperCase(),
                    style: theme.textTheme.headlineLarge,
                  ),
                  const Spacer(),
                  Container(width: 30),
                ],
              ),
              const SizedBox(height: 12),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                    margin: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userPreference.fullName ?? '',
                          style: theme.textTheme.headline4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userPreference.userId ?? '',
                          style: theme.textTheme.headline5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Divider(
                          color: theme.dividerColor,
                        ),
                        Text(
                          _dateString,
                          style: theme.textTheme.headline4,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _timeString,
                          style: theme.textTheme.headline5,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: NetworkImageWidget(
                          url: userPreference.userImage ?? '',
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      name: '',
                      decoration: InputDecoration(
                        labelText: tr('company'),
                        hintText: tr('company_hint'),
                        border: InputBorder.none,
                      ),
                      allowClear: true,
                      items: listCompany
                          .map((company) => DropdownMenuItem(
                                value: company,
                                child: Text(
                                  company,
                                  style: theme.textTheme.headline5,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) async {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return tr('please_select_company');
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      name: '',
                      decoration: InputDecoration(
                        labelText: tr('construction'),
                        hintText: tr('construction_hint'),
                        border: InputBorder.none,
                      ),
                      allowClear: true,
                      items: listConstruction
                          .map((construction) => DropdownMenuItem(
                                value: construction,
                                child: Text(
                                  construction,
                                  style: theme.textTheme.headline5,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) async {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return tr('please_select_construction');
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _CheckSwitchWidget(
                value: isCheckin,
                onChanged: (value) {
                  setState(
                    () {
                      isCheckin = !isCheckin;
                      if (isCheckin) {
                        bloc.changeLogtype(TimeKeeping.checkin);
                      } else {
                        bloc.changeLogtype(TimeKeeping.checkout);
                      }
                    },
                  );
                },
                width: switchWidth,
              ),
              const SizedBox(height: 80),
              InkWell(
                child: Container(
                  child: const Icon(
                    Iconsax.camera,
                    color: Colors.white,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.secondaryHeaderColor,
                        theme.primaryColor,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                ),
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    bool? isSuccess = await showDialog(
                      context: context,
                      builder: (context) => TimeKeepingCameraWidget(
                        bloc: bloc,
                      ),
                    );
                    if (isSuccess == true) {
                      Navigator.of(context).pop(true);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckSwitchWidget extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  final double? width;
  const _CheckSwitchWidget({
    Key? key,
    this.value = false,
    required this.onChanged,
    this.width,
  }) : super(key: key);

  @override
  __CheckSwitchWidgetState createState() => __CheckSwitchWidgetState();
}

class __CheckSwitchWidgetState extends State<_CheckSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      splashColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: theme.primaryColor.withOpacity(0.6),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    tr('checkin').toUpperCase(),
                    style: theme.textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    tr('checkout').toUpperCase(),
                    style: theme.textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment:
                widget.value ? Alignment.centerLeft : Alignment.centerRight,
            curve: Curves.decelerate,
            child: Container(
              width: (widget.width ?? 100) / 2 + 20,
              decoration: BoxDecoration(
                color: widget.value
                    ? MyColors.checkinColor
                    : MyColors.checkoutColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(14),
              alignment: Alignment.center,
              child: Text(
                widget.value
                    ? tr('checkin').toUpperCase()
                    : tr('checkout').toUpperCase(),
                style: theme.textTheme.headline2,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        setState(
          () {
            widget.onChanged(!widget.value);
          },
        );
      },
    );
  }
}
