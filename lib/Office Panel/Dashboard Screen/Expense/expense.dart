import 'package:flutter/material.dart';

class ExpenseUI extends StatefulWidget {
  const ExpenseUI({super.key});

  @override
  State<ExpenseUI> createState() => _ExpenseUIState();
}

class _ExpenseUIState extends State<ExpenseUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Expense UI'),
      ),
    );
  }
}
