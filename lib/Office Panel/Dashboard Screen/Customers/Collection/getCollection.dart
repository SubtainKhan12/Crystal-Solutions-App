import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../Model/Collection/GetCollectionModel.dart';
import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../apis.dart';
import '../../../../cosmos.dart';
import 'addCollection.dart';

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
          widget.getActiveCustomersList.tCstDsc.toString(),
          style: TextStyle(color: Cosmic.white_color,fontSize: 18),
        ),
        // centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder:
                      (context) =>
                      AddCollectionUI(
                        getActiveCustomersModel:
                        widget.getActiveCustomersList,
                      ))).then((value)=>get_GetCollection());
        },
        child: Icon(Icons.add),
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
                    DateTime parsedDate = DateTime.parse(
                        filterCollectionList[index].date.toString());
                    String formattedDate =
                    DateFormat('dd-MM-yyyy').format(parsedDate);
                    final numberFormat = NumberFormat('#,###');
                    String formatAmount(String amount) {
                      final doubleAmount = double.tryParse(amount)?? 0.00;
                      return numberFormat.format(doubleAmount);
                    }
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
                          child: ListTile(
                            minTileHeight: 30,
                            title: Row(

                              children: [
                                Text(filterCollectionList[index].col.toString(),style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffF58634),
                                    fontWeight:
                                    FontWeight.bold)),
                                Text(' - '),
                                Text(formattedDate,style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold)),
                                Text(' - '),
                                Text(formatAmount(filterCollectionList[index].amount.toString()),style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold)),
                              ],
                            ),
                            subtitle: Text(
                          filterCollectionList[index]
                              .description
                              .toString(),
                          style: const TextStyle(fontSize: 14),
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
