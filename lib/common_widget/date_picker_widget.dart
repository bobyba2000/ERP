import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DatePickerWidget extends StatelessWidget {
  final String? hintText;
  final String label;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime?) onSelectDate;

  const DatePickerWidget({
    Key? key,
    this.hintText,
    required this.label,
    required this.onSelectDate,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);
  InputBorder _inputBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 4),
        FormBuilderDateTimePicker(
          inputType: InputType.date,
          format: DateFormat("dd-MM-yyyy"),
          onChanged: onSelectDate,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            border: _inputBorder(Colors.transparent),
            enabledBorder: _inputBorder(Colors.transparent),
            focusedBorder: _inputBorder(Theme.of(context).primaryColor),
            errorBorder: _inputBorder(Colors.red),
            focusedErrorBorder: _inputBorder(Colors.transparent),
            disabledBorder: _inputBorder(Colors.transparent),
            counterText: '',
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(41, 35, 63, 0.5),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          initialValue: DateTime.now(),
          name: '',
        ),
      ],
    );
  }
}
