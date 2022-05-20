import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/page/time_keeping/time_keeping_detail_page.dart';
import 'package:erp_app/page/time_keeping/time_keeping_list_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

final _backgroundHeight = 60;

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: HomeHeaderDelegate(),
      pinned: true,
      floating: false,
    );
  }
}

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  List<HeaderItem> listItem = [
    HeaderItem(
      icon: Iconsax.tick_square,
      name: tr('time_keeping'),
      onClick: (BuildContext context) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TimeKeepingListPage(),
          ),
        );
      },
    ),
    HeaderItem(
      icon: Icons.newspaper,
      name: tr('news'),
      onClick: (context) {},
    ),
    HeaderItem(
      icon: Iconsax.money,
      name: tr('salary'),
      onClick: (context) {},
    ),
    HeaderItem(
      icon: Icons.storage,
      name: tr('storage'),
      onClick: (context) {},
    ),
  ];

  HomeHeaderDelegate();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final paddingTop = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Opacity(
          opacity:
              shrinkOffset < _backgroundHeight ? 0 : shrinkOffset / maxExtent,
          child: Container(
            height: maxExtent + minExtent + paddingTop - shrinkOffset,
            color: theme.primaryColor,
            padding: EdgeInsets.fromLTRB(12, 12 + paddingTop, 12, 12),
            child: ListView.builder(
              itemExtent: 100,
              itemBuilder: (context, index) => buildItem(
                listItem[index],
                true,
                theme,
                context,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: listItem.length,
            ),
          ),
        ),
        Opacity(
          opacity: shrinkOffset > _backgroundHeight
              ? 0
              : 1 - shrinkOffset / _backgroundHeight,
          child: Container(
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            height: 60,
            width: double.infinity,
          ),
        ),
        Opacity(
          opacity: 1 - shrinkOffset / maxExtent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: listItem
                  .map(
                    (e) => Expanded(
                      child: buildItem(
                        e,
                        false,
                        theme,
                        context,
                      ),
                    ),
                  )
                  .toList(),
            ),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }

  Widget buildItem(
    HeaderItem value,
    bool isStickyBar,
    ThemeData theme,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        value.onClick(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            value.icon,
            size: 40,
            color: isStickyBar ? Colors.white : theme.primaryColor,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            value.name,
            style: isStickyBar
                ? theme.textTheme.subtitle1
                : theme.textTheme.subtitle2,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 124;

  @override
  double get minExtent => 124;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class HeaderItem {
  final IconData icon;
  final String name;
  final Function(BuildContext) onClick;
  HeaderItem({
    required this.icon,
    required this.name,
    required this.onClick,
  });
}
