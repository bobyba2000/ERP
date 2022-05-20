import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/common_widget/navigation_bar_widget.dart';
import 'package:erp_app/page/home/home_page.dart';
import 'package:erp_app/page/time_keeping/time_keeping_list_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  int _currentIndex = 0;

  void onChangePage(int index) {
    setState(() {
      _currentIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: NavigationBarWidget(
        onSelect: (value) {
          pageController.jumpToPage(value);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Iconsax.home,
              size: 20,
            ),
            label: tr('home_page'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Iconsax.receipt,
              size: 20,
            ),
            label: tr('receipt_page'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Iconsax.box,
              size: 20,
            ),
            label: tr('goods_page'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Iconsax.notification,
              size: 20,
            ),
            label: tr('notification_page'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Iconsax.textalign_justifycenter,
              size: 20,
            ),
            label: tr('other_page'),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: onChangePage,
      ),
      backgroundColor: theme.backgroundColor,
      body: PageView(
        controller: pageController,
        children: [
          const HomePage(),
          Center(
            child: Text(
              'Receipt Page',
              style: theme.textTheme.headline4,
            ),
          ),
          Center(
            child: Text(
              'Goods Page',
              style: theme.textTheme.headline4,
            ),
          ),
          Center(
            child: Text(
              'Receipt Page',
              style: theme.textTheme.headline4,
            ),
          ),
          Center(
            child: Text(
              'Other Page',
              style: theme.textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
