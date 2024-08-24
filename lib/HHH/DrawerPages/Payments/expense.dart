import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../Model/Expense/ExpenseRegisterModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';
import 'expensePayment.dart';

class ExpenseRegisterUi extends StatefulWidget {
  const ExpenseRegisterUi({super.key});

  @override
  State<ExpenseRegisterUi> createState() => _ExpenseRegisterUiState();
}

class _ExpenseRegisterUiState extends State<ExpenseRegisterUi> {
  ExpenseRegisterModel? expenseRegisterList;
  List<Detail>? _filteredDetails = [];
  DateTime selectedInitialDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime selectedFinalDate = DateTime.now();
  final numberFormat = NumberFormat('#,###');

  String formatCollection(String amount) {
    final doubleAmount = double.tryParse(amount) ?? 0.00;
    return numberFormat.format(doubleAmount);
  }

  bool _isloading = false;
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Register',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ExpensePaymentScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: post_ExpenseRegister,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                      ),
                      child: Center(
                          child: Text(
                        "Bill Register",
                        style: TextStyle(
                            fontSize: 16,
                            color: Cosmic.white_color,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () => _intSelectDate(context, setState),
                        child: Row(
                          children: [
                            SizedBox(width: 8),
                            Text('From: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(selectedInitialDate),
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(Icons.calendar_today, color: Colors.green),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _fnlSelectDate(context, setState);
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Text(
                                '        To: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(selectedFinalDate),
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.calendar_today, color: Colors.blue),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: _height * 0.035,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF58634),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isloading = true;
                                    _isSubmitted = true;
                                  });
                                  post_ExpenseRegister();
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Cosmic.app_color),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: _height * 0.005),
                  ],
                ),
              ),
              Expanded(
                child: _isloading
                    ? Center(child: CircularProgressIndicator())
                    : !_isSubmitted
                        ? SizedBox.shrink()
                        : _filteredDetails!.isEmpty
                            ? Center(
                                child: Text('No Expense Found',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)))
                            : ListView.builder(
                                itemCount: _filteredDetails?.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                _filteredDetails?[index]
                                                        .trn
                                                        .toString() ??
                                                    '0',
                                                style: const TextStyle(
                                                  color: Color(0xffF58634),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text('  -  ',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  )),
                                              Text(
                                                _filteredDetails?[index]
                                                        .date
                                                        .toString() ??
                                                    '0',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            _filteredDetails?[index]
                                                    .expense
                                                    .toString() ??
                                                '0',
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _filteredDetails?[index]
                                                        .description
                                                        .toString() ??
                                                    '0',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                formatCollection(
                                                    _filteredDetails?[index]
                                                            .amount
                                                            .toString() ??
                                                        '0'),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _intSelectDate(
      BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: 'From Date',
      initialDate: selectedInitialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedInitialDate) {
      setState(() {
        selectedInitialDate = picked;
      });
    }
  }

  Future<void> _fnlSelectDate(
      BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: 'To Date',
      initialDate: selectedFinalDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFinalDate) {
      setState(() {
        selectedFinalDate = picked;
      });
    }
  }

  Future post_ExpenseRegister() async {
    var response = await http.post(Uri.parse(ExpenseRegister), body: {
      'FIntDat': selectedInitialDate.toString(),
      'FFnlDat': selectedFinalDate.toString(),
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      expenseRegisterList?.detail?.clear();
      expenseRegisterList = ExpenseRegisterModel.fromJson(result);

      setState(() {
        _isloading = false;
        _filteredDetails = expenseRegisterList?.detail;
      });
    } else {
      setState(() {
        _isloading = false;
      });
      throw Exception('Failed to load data');
    }
  }
}
