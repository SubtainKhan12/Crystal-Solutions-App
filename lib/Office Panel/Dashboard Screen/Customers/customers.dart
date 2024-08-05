import 'package:flutter/material.dart';

class CustomersUI extends StatefulWidget {
  const CustomersUI({super.key});

  @override
  State<CustomersUI> createState() => _CustomersUIState();
}

class _CustomersUIState extends State<CustomersUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Customers UI'),
      ),
    );
  }
}
