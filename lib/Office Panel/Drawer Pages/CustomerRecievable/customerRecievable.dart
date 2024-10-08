import 'dart:convert';

import 'package:crystal_solutions/Model/CustomerRecieveable/CustomerReceivableModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../HHH/DrawerPages/Customers/Customer PDF/pdf_file_handle.dart';
import '../../../Model/Reference/GetActiveReference.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';
import 'cutomerRecieveable_pdf.dart';

class CustomerReceivableUi extends StatefulWidget {
  const CustomerReceivableUi({super.key});

  @override
  State<CustomerReceivableUi> createState() => _CustomerReceivableUiState();
}

class _CustomerReceivableUiState extends State<CustomerReceivableUi> {
  CustomerReceivableModel? customerReceivableModel;
  List<Detail>? _filteredDetails = [];
  List<GetActiveReference> _getActiveReferenceList = [];
  DateTime selectedInitialDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime selectedFinalDate = DateTime.now();
  double tableFontSize = 12;
  String? type = 'ALL';
  String? reference ;
  var f = NumberFormat("###,###.#", "en_US");
  final numberFormat = NumberFormat('#,###');

  String formatCollection(String amount) {
    final doubleAmount = double.tryParse(amount) ?? 0.00;
    return numberFormat.format(doubleAmount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ActiveReference();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crystal Solution',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
        actions: [
          IconButton(
              onPressed: () async {
                final pdfFile = await CustomerRecieveable_Pdf.generate(
                    customerReceivableModel,
                    selectedInitialDate,
                    selectedFinalDate);
                PdfFileHandle.openFile(pdfFile);
              },
              icon: Icon(Icons.picture_as_pdf))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: post_CustomerReceivable,
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
                        "Customer Recievable",
                        style: TextStyle(
                            fontSize: 16,
                            color: Cosmic.white_color,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => _intSelectDate(context, setState),
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                Text('From: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: DropdownButtonFormField<String>(
                                value: reference,
                                onChanged: (newValue) {
                                  setState(() {
                                    reference = newValue;
                                  });
                                },
                                items: _getActiveReferenceList.map((refernce) {
                                  return DropdownMenuItem<String>(
                                    value: refernce.trefid ?? '',
                                    child: Text(
                                      refernce.trefdsc ?? '',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018,
                                          // Adjust font size based on height
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black),
                                      maxLines: 1,
                                    ),
                                  );
                                }).toList(),
                                isDense: true,
                                // Make the dropdown more compact
                                decoration: InputDecoration(
                                  labelText: "Reference",
                                  labelStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018, // Adjust label font size
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          10), // Add padding inside the text field
                                ),
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  // Adjust font size for selected value
                                  overflow: TextOverflow
                                      .ellipsis, // Ensure selected value fits within the field
                                ),
                              ),
                            ),
                          ),
                        ],
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
                          padding: const EdgeInsets.only(top: 1, right: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: DropdownButtonFormField<String>(
                              value: type,
                              onChanged: (newValue) {
                                setState(() {
                                  type = newValue;
                                });
                              },
                              items: <String>[
                                'ALL',
                                'O/S'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                        // Adjust font size based on height
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black),
                                    maxLines: 1,
                                  ),
                                );
                              }).toList(),
                              isDense: true,
                              // Make the dropdown more compact
                              decoration: InputDecoration(
                                labelText: "Type",
                                labelStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018, // Adjust label font size
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        10), // Add padding inside the text field
                              ),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                                // Adjust font size for selected value
                                overflow: TextOverflow
                                    .ellipsis, // Ensure selected value fits within the field
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 235.0, top: 5),
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
                              post_CustomerReceivable();
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Cosmic.app_color),
                            )),
                      ),
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
                    0: FlexColumnWidth(0.3),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(0.4),
                    3: FlexColumnWidth(0.4),
                    4: FlexColumnWidth(0.4),
                  },
                  children: [
                    TableRow(
                      // Header row
                      decoration: BoxDecoration(
                          color: Colors.indigo, border: Border.all(width: 0.5)),
                      children: [
                        TableCell(
                          child: Center(
                            child: Text('Code',
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
                            child: Text('Bill Amt',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Col Amt',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Balance',
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
                              child: Text(_filteredDetails![i].code.toString(),
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
                                    _filteredDetails![i].billAmt.toString(),
                                  ),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: tableFontSize,
                                  )),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                formatCollection(
                                  _filteredDetails![i].collection.toString(),
                                ),
                                textAlign: TextAlign.right,
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
                                    _filteredDetails![i].balance.toString(),
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
                padding: const EdgeInsets.only(left: 42.0),
                child: Container(
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder(
                          verticalInside:
                              BorderSide(width: 1, color: Colors.grey),
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(0.25),
                          1: FlexColumnWidth(0.1),
                          2: FlexColumnWidth(0.1),
                          3: FlexColumnWidth(0.1),
                        },
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey)),
                              children: [
                                TableCell(
                                  child: Text('Total',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: tableFontSize,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                TableCell(
                                  child: Text(
                                      formatCollection(
                                        customerReceivableModel?.totalBill
                                                .toString() ??
                                            '0',
                                      ),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: tableFontSize,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                TableCell(
                                  child: Text(
                                      formatCollection(
                                        customerReceivableModel?.totalCollection
                                                .toString() ??
                                            '0',
                                      ),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: tableFontSize,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                TableCell(
                                  child: Text(
                                      formatCollection(
                                        customerReceivableModel?.balance
                                                .toString() ??
                                            '0',
                                      ),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: tableFontSize,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ])
                        ],
                      ),
                      //    Padding(
                    ],
                  ),
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

  Future post_CustomerReceivable() async {
    var response = await http.post(Uri.parse(CustomerReceivable), body: {
      'FIntDat': selectedInitialDate.toString(),
      'FFnlDat': selectedFinalDate.toString(),
      'FRefId': reference.toString(),
      'FRepTyp': type.toString(),
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      customerReceivableModel?.detail?.clear();
      customerReceivableModel = CustomerReceivableModel.fromJson(result);

      setState(() {
        _filteredDetails = customerReceivableModel?.detail;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future get_ActiveReference() async {
    var response = await http.post(Uri.parse(getActiveRef));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getActiveReferenceList.clear();
      for (Map i in result) {
        _getActiveReferenceList.add(GetActiveReference.fromJson(i));
      }
      setState(() {});
    }
  }
// void search(String query) {
//     if (query.isEmpty) {
//       _filteredDetails = customerReceivableModel?.detail;
//     } else {
//       _filteredDetails = customerReceivableModel?.detail?.where((detail) {
//         return detail.customer?.toLowerCase().contains(query.toLowerCase()) ?? false;
//       }).toList();
//     }
//     setState(() {
//     });
//   }
}
