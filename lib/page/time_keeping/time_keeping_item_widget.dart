import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/constants.dart';
import 'package:erp_app/model/time_keeping_model.dart';
import 'package:erp_app/style/my_color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TimeKeepingItemWidget extends StatelessWidget {
  final TimeKeepingModel value;
  const TimeKeepingItemWidget({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = value.logType == TimeKeeping.checkin
        ? MyColors.checkinColor
        : MyColors.checkoutColor;
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
              value.time == null ? '' : DateFormat('HH:mm').format(value.time!),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.logType ?? '',
                          style: theme.textTheme.headline4,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                value.employeeName ?? '',
                                style: theme.textTheme.subtitle2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                value.location ?? tr('other_place'),
                                style: theme.textTheme.subtitle2,
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      value.logType == TimeKeeping.checkin
                          ? Iconsax.login
                          : Iconsax.logout,
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
