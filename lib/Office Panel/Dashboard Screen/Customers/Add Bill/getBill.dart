import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:crystal_solutions/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../HHH/DrawerPages/Customers/Customer PDF/pdf_file_handle.dart';
import '../../../../Model/Bill/GetBillModel.dart';
import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../cosmos.dart';
import '../PDF/officeCustomerPdf.dart';
import 'addBill.dart';

class GetBillUI extends StatefulWidget {
  GetActiveCustomersModel getActiveCustomersList;

  GetBillUI({super.key, required this.getActiveCustomersList});

  @override
  State<GetBillUI> createState() => _GetBillUIState();
}

class _GetBillUIState extends State<GetBillUI> {
  List<GetBillModel> getBillList = [];
  List<GetBillModel> filterBillList = [];

  final numberFormat = NumberFormat('#,###');

  String formatCollection(String amount) {
    final doubleAmount = double.tryParse(amount) ?? 0.00;
    return numberFormat.format(doubleAmount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post_getBill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.getActiveCustomersList.tCstDsc.toString(),
          style: TextStyle(color: Cosmic.white_color, fontSize: 18),
        ),
        // centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBillUI(
                          getActiveCustomersList:
                              widget.getActiveCustomersList)))
              .then((value) => post_getBill());
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: post_getBill,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterBill(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterBillList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filterBillList.length,
                        itemBuilder: (context, index) {
                          DateTime parsedDate = DateTime.parse(
                              filterBillList[index].date.toString());
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(parsedDate);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              shadowColor: Cosmic.app_color,
                              borderOnForeground: true,
                              surfaceTintColor: Colors.blue.shade100,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    filterBillList[index]
                                                        .inv
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xffF58634),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                // SizedBox(width: 5,),
                                                Text('  -  '),
                                                Text(formattedDate,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      final pdfFile =
                                                          await OfficeCustomerReciept_PDF
                                                              .generate(
                                                                  filterBillList[
                                                                      index]);
                                                      PdfFileHandle.openFile(
                                                          pdfFile);
                                                    },
                                                    icon: Icon(
                                                        Icons.picture_as_pdf)),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                filterBillList[index]
                                                    .description
                                                    .toString(),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                            Text(
                                              formatCollection(
                                                  calculateTotalCharges(
                                                          filterBillList[index])
                                                      .toString()),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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

  double calculateTotalCharges(GetBillModel bill) {
    double arrear = double.tryParse(bill.arrear ?? '0.00') ?? 0.00;
    double serverChg = double.tryParse(bill.serverChg ?? '0.00') ?? 0.00;
    double advacneChg = double.tryParse(bill.advacneChg ?? '0.00') ?? 0.00;
    double monthlyChg = double.tryParse(bill.monthlyChg ?? '0.00') ?? 0.00;
    double smsChg = double.tryParse(bill.sMSChg ?? '0.00') ?? 0.00;
    double psoChg = double.tryParse(bill.pSOChg ?? '0.00') ?? 0.00;
    double otherChg = double.tryParse(bill.otherChg ?? '0.00') ?? 0.00;

    return arrear +
        serverChg +
        advacneChg +
        monthlyChg +
        smsChg +
        psoChg +
        otherChg;
  }

  Future post_getBill() async {
    var response = await http.post(Uri.parse(getBill), body: {
      'FCstId': widget.getActiveCustomersList.tcstid.toString(),
    });
    print(widget.getActiveCustomersList.tcstid.toString());
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getBillList.clear();
      for (Map i in result) {
        getBillList.add(GetBillModel.fromJson(i));
      }
      setState(() {
        filterBillList = getBillList;
      });
    }
  }

  void filterBill(String query) {
    List<GetBillModel> filteredList = [];
    for (var customer in getBillList) {
      if (customer.description!.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(customer);
      }
    }
    setState(() {
      filterBillList = filteredList;
    });
  }
}
