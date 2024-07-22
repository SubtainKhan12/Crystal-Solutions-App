import 'package:flutter/material.dart';

import '../../../cosmos.dart';

class GetBankScreen extends StatefulWidget {
  const GetBankScreen({super.key});

  @override
  State<GetBankScreen> createState() => _GetBankScreenState();
}

class _GetBankScreenState extends State<GetBankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Banks',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
    );
  }
}


