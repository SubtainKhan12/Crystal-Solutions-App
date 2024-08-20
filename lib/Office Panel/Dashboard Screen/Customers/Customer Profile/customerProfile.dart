import 'package:flutter/material.dart';

import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../cosmos.dart';

class CustomerProfileUI extends StatefulWidget {
  GetActiveCustomersModel getActiveCustomersList;
   CustomerProfileUI({super.key, required this.getActiveCustomersList});

  @override
  State<CustomerProfileUI> createState() => _CustomerProfileUIState();
}

class _CustomerProfileUIState extends State<CustomerProfileUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Profile',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
    );
  }
}
