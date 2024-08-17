import 'dart:convert';
import 'package:crystal_solutions/Model/BillRegister/BillRegisterModel.dart';
import 'package:http/http.dart' as http;
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../HHH/DrawerPages/Customers/Customer PDF/pdf_file_handle.dart';
import '../../../apis.dart';
import 'billRegister_pdf.dart';

class BillRegisterUi extends StatefulWidget {
  const BillRegisterUi({super.key});

  @override
  State<BillRegisterUi> createState() => _BillRegisterUiState();
}

class _BillRegisterUiState extends State<BillRegisterUi> {
  BillRegisterModel? billRegisterModel;
  List<Detail>? _filteredDetails = [];
  DateTime selectedInitialDate = DateTime.now();
  DateTime selectedFinalDate = DateTime.now();
  double tableFontSize = 12;
  var f = NumberFormat("###,###.#", "en_US");
  final numberFormat = NumberFormat('#,###');

  String formatCollection(String amount) {
    final doubleAmount = double.tryParse(amount) ?? 0.00;
    return numberFormat.format(doubleAmount);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crystal Solutions',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
        actions: [
          IconButton(
              onPressed: () async {
                final pdfFile = await BillRegister_Pdf.generate(
                    billRegisterModel, selectedInitialDate, selectedFinalDate);
                PdfFileHandle.openFile(pdfFile);
              },
              icon: Icon(Icons.picture_as_pdf))
        ],
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
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.calendar_today, color: Colors.green),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              _fnlSelectDate(context, setState);
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  '     To: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(selectedFinalDate),
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(Icons.calendar_today, color: Colors.blue),
                              ],
                            ),
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
                                    borderRadius: BorderRadius.circular(
                                        5), // Makes the button rectangular
                                  ),
                                ),
                                onPressed: () {
                                  post_BillRegister();
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Cosmic.app_color),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.005,
                    ),
                  ],
                ),
              ),
              Column(children: [
                Table(
                  border: TableBorder(
                    verticalInside: BorderSide(width: 1, color: Colors.grey),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(0.85),
                    1: FlexColumnWidth(0.5),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(0.8),
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
                            child: Text('Trn#',
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
                            child: Text('Amount',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < (_filteredDetails?.length ?? 0); i++)
                      TableRow(
                        // Header row
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                  billRegisterModel!.detail![i].date.toString(),
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
                              child: Text(_filteredDetails![i].trn.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      )),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                _filteredDetails![i].customer.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 3.0, right: 1),
                              child: Text(
                                  formatCollection(
                                    _filteredDetails![i].amount.toString(),
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
              ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 115.0),
                    child: Table(
                      border: TableBorder(
                        verticalInside: BorderSide(width: 1, color: Colors.grey),
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(0.25),
                        1: FlexColumnWidth(0.1),

                      },
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5,color: Colors.grey)),
                            children: [
                              TableCell(
                                child: Text('Total Amount',
                                    style: TextStyle(
                                        fontSize: tableFontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              TableCell(
                                child: Text(
                                    billRegisterModel?.totalAmount.toString() ?? '0',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: tableFontSize,
                                    )),
                              ),
                            ])
                      ],
                    ),
                  ),
            ]),
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

  Future post_BillRegister() async {
    var response = await http.post(Uri.parse(BillRegister), body: {
      'FIntDat': selectedInitialDate.toString(),
      'FFnlDat': selectedFinalDate.toString(),
    });
    print(selectedInitialDate.toString());
    print(selectedFinalDate.toString());
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      billRegisterModel?.detail?.clear();
      billRegisterModel = BillRegisterModel.fromJson(result);

      setState(() {
        _filteredDetails = billRegisterModel?.detail;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
// void search(String query) {
//   if (query.isEmpty) {
//     _filteredDetails = billRegisterModel?.detail;
//   } else {
//     _filteredDetails = billRegisterModel?.detail?.where((detail) {
//       return detail.customer?.toLowerCase().contains(query.toLowerCase()) ?? false;
//     }).toList();
//   }
//   setState(() {
//   });
// }
}
