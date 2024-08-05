import 'package:crystal_solutions/HHH/Drawer/drawerUi.dart';
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';

import 'DashboardPages/firstPage.dart';
import 'DashboardPages/secondPage.dart';
import 'DashboardPages/thirdPage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? costomerList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(color: Cosmic.white_color),
          ),
          centerTitle: true,
          backgroundColor: Cosmic.app_color,
          iconTheme: IconThemeData(color: Cosmic.white_color),
        ),
        drawer: DrawerUi(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Opacity(
                opacity: 0.3, // Adjust the opacity as needed
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                  child: Column(
                    children: [
                      Image.asset('assets/Crystal-Solutions-logo-removebg-preview.png'),
                      Text(
                        'Crystal Solutions',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  TabBar(
                    dividerColor: Colors.transparent,
                    // isScrollable: true,
                    labelColor: Colors.black,
                    // tabAlignment: TabAlignment.start,
                    indicatorColor: Cosmic.app_color,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: 'Customers'),
                      Tab(text: 'Expense'),
                      Tab(text: 'Tab 3'),
                    ],
                  ),
              Expanded(
                child: TabBarView(
                  children: [
                    FirstPage(),
                    SecondPage(),
                    ThirdPage(),
                  ],
                ),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
