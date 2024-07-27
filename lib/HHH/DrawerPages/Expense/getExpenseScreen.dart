import 'dart:convert';

import 'package:crystal_solutions/HHH/DrawerPages/Expense/addExpense.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Expense/updateExpense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../Model/Expense/GetExpenseModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<GetExpenseModel> _getExpensList = [];
  List<GetExpenseModel> filterExpenseList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Exp();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddExpenseScreen()))
              .then((value) => get_Exp());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Exp,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  filterExpense(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterExpenseList.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: filterExpenseList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          elevation: 2,
                          shadowColor: Cosmic.app_color,
                          borderOnForeground: true,
                          surfaceTintColor: Colors.blue.shade100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filterExpenseList[index]
                                      .texpdsc
                                      .toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(filterExpenseList[index]
                                        .texpsts
                                        .toString(), style: const TextStyle(fontSize: 12),),

                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateExpenseScreen(
                                                        getExpenseList:
                                                        _getExpensList[
                                                        index],
                                                      )))
                                              .then((value) => get_Exp());
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Cosmic.app_color,
                                        )),
                                  ],
                                ),
                                Text(filterExpenseList[index]
                                    .tmthbgt
                                    .toString(), style: const TextStyle(fontSize: 12),),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future get_Exp() async {
    var response = await http.post(Uri.parse(getExp));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getExpensList.clear();
      for (Map i in result) {
        _getExpensList.add(GetExpenseModel.fromJson(i));
      }
      setState(() {
        filterExpenseList = List.from(_getExpensList);
      });
    }
  }
  filterExpense(String query) {
    setState(() {
      filterExpenseList = _getExpensList
          .where((element) =>
          element.texpdsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
