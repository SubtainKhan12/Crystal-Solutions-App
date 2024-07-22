import 'dart:convert';

import 'package:crystal_solutions/HHH/DrawerPages/Customers/addCustomers.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Customers/updateCustomers.dart';
import 'package:crystal_solutions/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../Model/Customers/GetCustomersModel.dart';
import '../../../cosmos.dart';

class GetCustomersScreen extends StatefulWidget {
  const GetCustomersScreen({super.key});

  @override
  State<GetCustomersScreen> createState() => _GetCustomersScreenState();
}

class _GetCustomersScreenState extends State<GetCustomersScreen> {
  List<GetCustomersModel> _getCustomerListModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Customers();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCustomers()))
              .then((value) => get_Customers());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Customers,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: _getCustomerListModel.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: _getCustomerListModel.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getCustomerListModel[index]
                                      .tCstDsc
                                      .toString(),
                                  style: FontSizeAndWeight.Heading1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Phone: ${_getCustomerListModel[index]
                                        .tMobNUm
                                        .toString()}'),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateCustomersScreen(
                                                        getCustomersModel:
                                                        _getCustomerListModel[
                                                        index],
                                                      )))
                                              .then((value) => get_Customers());
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Cosmic.app_color,
                                        )),
                                  ],
                                ),
                                Text('${_getCustomerListModel[index]
                                    .tMthChg
                                    .toString()} RS'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future get_Customers() async {
    var response = await http.post(Uri.parse(getCust));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getCustomerListModel.clear();
      for (Map i in result) {
        _getCustomerListModel.add(GetCustomersModel.fromJson(i));
      }
      setState(() {});
    }
  }
}

