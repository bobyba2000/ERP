import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/page/home/home_header.dart';
import 'package:erp_app/page/landing_page.dart';
import 'package:erp_app/preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "${tr('hi')} ${UserPreference}",
              style: theme.textTheme.button,
            ),
            centerTitle: false,
            backgroundColor: theme.primaryColor,
            actions: [
              GestureDetector(
                onTap: () async {
                  final _sharedPreferences =
                      await SharedPreferences.getInstance();
                  _sharedPreferences.remove('authToken');
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LandingPage(),
                    ),
                    (route) => false,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Iconsax.logout,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const HomeHeader(),
          SliverFixedExtentList(
            itemExtent: 1000,
            delegate: SliverChildListDelegate([
              _buildListWidget(Colors.white, ""),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildListWidget(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 48),
        ),
      ),
    );
  }
}
