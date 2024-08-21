import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Model/Bill/GetBillModel.dart';
import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../Model/Cutomer Ledger/CustomerLedgerModel.dart';
import '../../../../apis.dart';
import 'package:http/http.dart' as http;

import '../../../../cosmos.dart';

class CustomerLedgerUI extends StatefulWidget {
  GetActiveCustomersModel getActiveCustomersList;

  CustomerLedgerUI({super.key, required this.getActiveCustomersList});

  @override
  State<CustomerLedgerUI> createState() => _CustomerLedgerUIState();
}

class _CustomerLedgerUIState extends State<CustomerLedgerUI> {
  List<CustomerLedgerModel> getCustomerLedger = [];
  double tableFontSize = 12;
  var f = NumberFormat("###,###.#", "en_US");
  final numberFormat = NumberFormat('#,###');

  String formatAmount(String amount) {
    final doubleAmount = double.tryParse(amount) ?? 0.00;
    return numberFormat.format(doubleAmount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_customerLedger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Ledger',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Name: ${widget.getActiveCustomersList.tCstDsc}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Address: ${widget.getActiveCustomersList.tAdd001}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Phone No: ${widget.getActiveCustomersList.tMobNUm}',
                  style: TextStyle(fontSize: 16),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Table(
                    border: TableBorder(
                      verticalInside: BorderSide(width: 1, color: Colors.grey),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(0.4),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(0.6),
                      4: FlexColumnWidth(0.6),
                    },
                    children: [
                      TableRow(
                        // Header row
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            border: Border.all(width: 0.5)),
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
                              child: Text('Trn#',
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
                              child: Text('Debit',
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text('Credit',
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      for (var i = 0; i < (getCustomerLedger.length ?? 0); i++)
                        TableRow(
                          // Header row
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          children: [
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, left: 1),
                                child: Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(getCustomerLedger[i]
                                            .date
                                            .toString())),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: tableFontSize,
                                    )),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 3.0, left: 1),
                                child: Text(
                                    getCustomerLedger[i].trn.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: tableFontSize,
                                    )),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, left: 1),
                                child: Text(
                                    getCustomerLedger[i].description.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: tableFontSize,
                                    )),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, right: 1),
                                child: getCustomerLedger[i].debit.toString() ==
                                        'null'
                                    ? Container()
                                    : Text(
                                        formatAmount(
                                          getCustomerLedger[i].debit.toString(),
                                        ),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: tableFontSize,
                                        )),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, right: 1),
                                child: getCustomerLedger[i].credit.toString() ==
                                        'null'
                                    ? Container()
                                    : Text(
                                        formatAmount(
                                          getCustomerLedger[i]
                                              .credit
                                              .toString(),
                                        ),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: tableFontSize,
                                        )),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }

  Future get_customerLedger() async {
    var response = await http.post(Uri.parse(customerLedger), body: {
      'FCstId': widget.getActiveCustomersList.tcstid.toString(),
    });
    // print(widget.getBillList.custId.toString());
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getCustomerLedger.clear();
      for (Map i in result) {
        getCustomerLedger.add(CustomerLedgerModel.fromJson(i));
      }
      setState(() {});
    }
  }
}
