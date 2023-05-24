import 'package:flutter/material.dart';

import 'selected_city_screen.dart';
import 'selection_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  static const String routeName = '/tab-screen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          tabs: const [
            Tab(
              text: 'Cites',
            ),
            Tab(
              text: 'Select City',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SelectedCityScreen(),
          CitySelctionScreen(),
        ],
      ),
    );
  }
}
