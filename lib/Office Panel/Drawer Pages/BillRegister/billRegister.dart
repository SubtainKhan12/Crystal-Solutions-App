import 'dart:convert';


import 'package:crystal_solutions/Model/BillRegister/BillRegisterModel.dart';
import 'package:crystal_solutions/Model/RegisterCollection/CollectionsRegisters.dart';
import 'package:http/http.dart'as http;
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../apis.dart';

class BillRegisterUi extends StatefulWidget {
  const BillRegisterUi({super.key});

  @override
  State<BillRegisterUi> createState() => _BillRegisterUiState();
}

class _BillRegisterUiState extends State<BillRegisterUi> {
  BillRegisterModel? billRegisterModel;
  // CollectionsRegistersModel? searchModel;
  DateTime selectedInitialDate = DateTime.now();
  DateTime selectedFinalDate = DateTime.now();
  double tableFontSize = 12;
  var f = NumberFormat("###,###.#", "en_US");

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bill Register',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: RefreshIndicator(
        onRefresh: post_BillRegister,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5),
                          child: Container(
                            height: _height * 0.04,
                            width: _width * 0.45,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Search",
                                labelStyle: TextStyle(
                                  fontSize: _height *
                                      0.02, // Adjust font size relative to TextField height
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: _height * 0.01,
                                  // Adjust vertical padding
                                  horizontal:
                                  _width * 0.02, // Adjust horizontal padding
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () => _intSelectDate(context, setState),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.green),
                                SizedBox(width: 8),
                                Text(
                                  "${selectedInitialDate.toLocal()}"
                                      .split(' ')[0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Makes the button rectangular
                                ),
                              ),
                              onPressed: () {
                                post_BillRegister();
                              },
                              child: Text('Submit')),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              _fnlSelectDate(context, setState);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  "${selectedFinalDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Total Amount: ${billRegisterModel?.totalAmount ?? '0'} PKR",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(children: [
                Table(
                  border: TableBorder(
                    verticalInside: BorderSide(width: 1, color: Colors.black),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(0.85),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(0.5),
                    3: FlexColumnWidth(0.8),
                    // 4: FlexColumnWidth(1),
                    // 5: FlexColumnWidth(1),
                    // 6: FlexColumnWidth(1),
                    // 7: FlexColumnWidth(1),
                    // 8: FlexColumnWidth(1),
                    // 9: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      // Header row
                      decoration: BoxDecoration(
                          color: Colors.indigo, border: Border.all(width: 0.5)),
                      children: [
                        TableCell(
                          child: Center(
                            child: Text('Date',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Description',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Trn#',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Collection',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0;
                    i < (billRegisterModel?.detail?.length ?? 0);
                    i++)
                      TableRow(
                        // Header row
                        decoration: BoxDecoration(border: Border.all(width: 0.5)),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                  billRegisterModel!.detail![i].date
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                  billRegisterModel!.detail![i].customer
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, right: 1),
                              child: Text(
                                  billRegisterModel!.detail![i].trn.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, right: 1),
                              child: Text(
                                  billRegisterModel!.detail![i].amount
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
  Future<void> _intSelectDate(BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
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
  Future<void> _fnlSelectDate(BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
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
  Future post_BillRegister() async {
    var response = await http.post(Uri.parse(BillRegister), body: {
      'FIntDat': selectedInitialDate.toString(),
      'FFnlDat': selectedFinalDate.toString(),
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      billRegisterModel?.detail?.clear();
      billRegisterModel = BillRegisterModel.fromJson(result);

      setState(() {
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

}
