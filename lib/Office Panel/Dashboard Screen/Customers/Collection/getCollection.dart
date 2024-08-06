import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../Model/Collection/GetCollectionModel.dart';
import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../apis.dart';
import '../../../../cosmos.dart';

class GetCollectionUI extends StatefulWidget {
  GetActiveCustomersModel getActiveCustomersList;
  GetCollectionUI({super.key, required this.getActiveCustomersList});

  @override
  State<GetCollectionUI> createState() => _GetCollectionUIState();
}

class _GetCollectionUIState extends State<GetCollectionUI> {
  List<GetCollectionModel> getCollectionList = [];
  List<GetCollectionModel> filterCollectionList = [];

  @override
  void initState() {
    super.initState();
    get_GetCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collections',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: RefreshIndicator(
        onRefresh: get_GetCollection,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterCollection(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterCollectionList.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                  itemCount: filterCollectionList.length,
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
                              filterCollectionList[index]
                                  .description
                                  .toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(filterCollectionList[index].date.toString()),
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
                                                filterCollectionList[
                                                index]
                                                    .mobile
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ])),
                                        InkWell(
                                          onTap: () {
                                            // _showBottomSheet(
                                            //     context,
                                            //     filterActiveCustomerList[
                                            //     index]);
                                          },
                                          child: Icon(Icons
                                              .add_chart_outlined),
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
                                            text: filterCollectionList[index]
                                                .monthlyChg
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
                                            text: filterCollectionList[index]
                                                .address1
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
                                            text: filterCollectionList[index]
                                                .email
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Arrear Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterCollectionList[index]
                                                .arrear
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Server Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterCollectionList[index]
                                                .serverChg
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Sms Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterCollectionList[index]
                                                .sMSChg
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'POS Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterCollectionList[index]
                                                .pSOChg
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Monthly Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterCollectionList[index]
                                                .monthlyChg
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Advance Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterCollectionList[index]
                                                .advacneChg
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Other Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterCollectionList[index]
                                                .serverChg
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Total Charges: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: calculateTotalCharges(
                                                filterCollectionList[
                                                index])
                                                .toStringAsFixed(2),
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

  Future get_GetCollection() async {
    var response = await http.post(Uri.parse(getCollection),body: {
      'FCstId': widget.getActiveCustomersList.tcstid,
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getCollectionList.clear();
      for (var i in result) {
        getCollectionList.add(GetCollectionModel.fromJson(i));
      }
      setState(() {
        filterCollectionList = getCollectionList;
      });
    }
  }

  void filterCollection(String query) {
    List<GetCollectionModel> filteredList = [];
    for (var customer in getCollectionList) {
      if (customer.description!.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(customer);
      }
    }
    setState(() {
      filterCollectionList = filteredList;
    });
  }

  double calculateTotalCharges(GetCollectionModel collection) {
    double monthlyChg = double.tryParse(collection.monthlyChg.toString()) ?? 0;
    double arrear = double.tryParse(collection.arrear.toString()) ?? 0;
    double serverChg = double.tryParse(collection.serverChg.toString()) ?? 0;
    double sMSChg = double.tryParse(collection.sMSChg.toString()) ?? 0;
    double pSOChg = double.tryParse(collection.pSOChg.toString()) ?? 0;
    double advacneChg = double.tryParse(collection.advacneChg.toString()) ?? 0;
    double otherChg = double.tryParse(collection.otherChg.toString()) ?? 0;

    return monthlyChg + arrear + serverChg + sMSChg + pSOChg + advacneChg + otherChg;
  }
}
