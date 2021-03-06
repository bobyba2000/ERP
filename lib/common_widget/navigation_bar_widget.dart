import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/common_widget/network_image_widget.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NavigationBarWidget extends StatelessWidget {
  final Function(int) onSelect;
  NavigationBarWidget({Key? key, required this.onSelect}) : super(key: key);

  final UserPreference userPreference =
      AppDependencies.injector<UserPreference>();

  @override
  Widget build(BuildContext context) {
    final fullName = userPreference.fullName ?? '';
    final userId = userPreference.userId ?? '';
    final userImage = userPreference.userImage ?? '';

    final theme = Theme.of(context);
    return Drawer(
      child: Material(
        color: theme.primaryColor,
        child: Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: MediaQuery.of(context).padding.top,
          ),
          child: ListView(
            children: [
              _NavigationHeader(
                userId: userId,
                name: fullName,
                imageURL: userImage,
              ),
              const SizedBox(height: 12),
              Divider(
                color: theme.backgroundColor,
                thickness: 1.5,
              ),
              const SizedBox(height: 12),
              _NavigationBarItem(
                icons: Iconsax.tick_square,
                title: tr('time_keeping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationHeader extends StatelessWidget {
  final String name;
  final String userId;
  final String? imageURL;
  const _NavigationHeader(
      {Key? key, required this.name, required this.userId, this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: NetworkImageWidget(
            url: imageURL,
            width: 40,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.textTheme.headline1,
              ),
              const SizedBox(height: 4),
              Text(
                userId,
                style: theme.textTheme.headline2,
              )
            ],
          ),
        )
      ],
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  final IconData icons;
  final String title;
  const _NavigationBarItem({
    Key? key,
    required this.icons,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icons, color: Colors.white, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
