import 'dart:convert';
import 'package:crystal_solutions/Office%20Panel/Dashboard%20Screen/Customers/Add%20Bill/getBill.dart';
import 'package:crystal_solutions/Office%20Panel/Dashboard%20Screen/Customers/Collection/getCollection.dart';
import 'package:crystal_solutions/Office%20Panel/Dashboard%20Screen/Customers/Customer%20Profile/customerProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';
import 'Ledger/customerLedger.dart';

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
                            child: InkWell(
                              onTap: (){
                                _showBottomSheet(
                                    context,
                                    filterActiveCustomerList[
                                    index]);
                              },
                              child: Card(

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                shadowColor: Cosmic.app_color,
                                borderOnForeground: true,
                                surfaceTintColor: Colors.blue.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                  child: Text(filterActiveCustomerList[index].tCstDsc.toString()),
                                )
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
      // showDragHandle: true,
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
                Center(child: Text(getActiveCustomersModel.tCstDsc.toString(), style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500, color: Colors.red),)),
                Row(
                  children: [
                    Icon(Icons.person_outline_outlined),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerProfileUI(
                                      getActiveCustomersList:
                                      getActiveCustomersModel)));
                        },
                        child: Text(
                          'Customer Profile',
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
                          'Bill',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/collection.png',
                      height: 20,
                        color: Colors.black,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetCollectionUI(getActiveCustomersList: getActiveCustomersModel,)));
                        },
                        child: Text(
                          'Collection',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/ledger.png',
                      color: Colors.black,
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerLedgerUI(getActiveCustomersList: getActiveCustomersModel,)));
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
    var response = await http.get(Uri.parse(getActiveCust));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getActiveCustomerList.clear();
      for(Map i in result){
        _getActiveCustomerList.add(GetActiveCustomersModel.fromJson(i));
      }
      setState(() {
        filterActiveCustomerList = List.from(_getActiveCustomerList);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  void filterActiveCustomers(String query) {
    setState(() {
      filterActiveCustomerList = _getActiveCustomerList
          .where((category) =>
          category.tCstDsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
