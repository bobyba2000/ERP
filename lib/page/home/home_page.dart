import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/page/home/home_header.dart';
import 'package:erp_app/preference/user_preference.dart';
import 'package:flutter/material.dart';

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
              "${tr('hi')} ${UserPreference.name}",
              style: theme.textTheme.button,
            ),
            centerTitle: false,
            backgroundColor: theme.primaryColor,
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
