import 'dart:convert';

import 'package:crystal_solutions/Office%20Panel/Dashboard%20Screen/Customers/Add%20Bill/getBill.dart';
import 'package:crystal_solutions/Office%20Panel/Dashboard%20Screen/Customers/Collection/getCollection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../HHH/DrawerPages/Customers/Customer PDF/pdf_file_handle.dart';
import '../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';
import 'Add Bill/addBill.dart';
import 'Collection/addCollection.dart';
import 'Ledger/customerLedger.dart';
import 'PDF/officeCustomerPdf.dart';

class CustomersUI extends StatefulWidget {
  const CustomersUI({super.key});

  @override
  State<CustomersUI> createState() => _CustomersUIState();
}

class _CustomersUIState extends State<CustomersUI> {
  List<GetActiveCustomersModel> _getActiveCustomerList = [];
  List<GetActiveCustomersModel> filterActiveCustomerList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ActiveCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customers',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: RefreshIndicator(
        onRefresh: get_ActiveCustomers,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterActiveCustomers(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterActiveCustomerList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filterActiveCustomerList.length,
                        itemBuilder: (context, index) {
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
                                child: ExpansionTile(
                                  minTileHeight: 30,
                                  title: Text(
                                    filterActiveCustomerList[index]
                                        .tCstDsc
                                        .toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  children: [
                                    Divider(
                                      color: Cosmic.app_color,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                const TextSpan(
                                                  text: 'Mobile: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text:
                                                      filterActiveCustomerList[
                                                              index]
                                                          .tMobNUm
                                                          .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ])),
                                              InkWell(
                                                onTap: () {
                                                  _showBottomSheet(
                                                      context,
                                                      filterActiveCustomerList[
                                                          index]);
                                                },
                                                child: Icon(
                                                    Icons.add_chart_outlined),
                                              ),
                                            ],
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                              text: 'Monthly Charges: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: filterActiveCustomerList[
                                                      index]
                                                  .tmthChg
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                              text: 'Address1: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: filterActiveCustomerList[
                                                      index]
                                                  .tAdd001
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                              text: 'Email: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: filterActiveCustomerList[
                                                      index]
                                                  .tEmlAdd
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                              text: 'IP: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: filterActiveCustomerList[
                                                      index]
                                                  .tSrvIp
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                              text: 'Shops: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: filterActiveCustomerList[
                                                      index]
                                                  .tShpNum
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ],
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

  void _showBottomSheet(
      BuildContext context, GetActiveCustomersModel getActiveCustomersModel) {
    showModalBottomSheet(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/bill.png',
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddBillUI(
                                      getActiveCustomersList:
                                          getActiveCustomersModel)));
                        },
                        child: Text(
                          'Add Bill',
                          style: TextStyle(fontSize: 20),
                        )),

                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/bill.png',
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetBillUI(
                                      getActiveCustomersList:
                                      getActiveCustomersModel)));
                        },
                        child: Text(
                          'Get Bill',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/bill.png',
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCollectionUI(
                                      getActiveCustomersList:
                                      getActiveCustomersModel)));
                        },
                        child: Text(
                          'Add Collection',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/bill.png',
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetCollectionUI(getActiveCustomersList: getActiveCustomersModel,)));
                        },
                        child: Text(
                          'Get Collection',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/bill.png',
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerLedgerUI()));
                        },
                        child: Text(
                          'Customer Ledger',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),

              ]),
        );
      },
    );
  }

  Future<void> get_ActiveCustomers() async {
    _getActiveCustomerList.clear();
    var response = await http.get(Uri.parse(getActiveCust));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      _getActiveCustomerList = List<GetActiveCustomersModel>.from(
          jsonData.map((model) => GetActiveCustomersModel.fromJson(model)));
      setState(() {
        filterActiveCustomerList = _getActiveCustomerList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterActiveCustomers(String query) {
    List<GetActiveCustomersModel> filteredList = [];
    for (var customer in _getActiveCustomerList) {
      if (customer.tCstDsc!.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(customer);
      }
    }
    setState(() {
      filterActiveCustomerList = filteredList;
    });
  }
}
