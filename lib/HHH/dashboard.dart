import 'package:crystal_solutions/HHH/Drawer/drawerUi.dart';
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Positioned(
            top: 150,
            right: 0,
            bottom: 0,
            left: 0,
            child: Opacity(
              opacity: 0.3, // Adjust the opacity as needed
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/Crystal-Solutions-logo-removebg-preview.png'),
                    Text('Crystal Solutions', style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey, // Adjust the color as needed
                    ),),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
