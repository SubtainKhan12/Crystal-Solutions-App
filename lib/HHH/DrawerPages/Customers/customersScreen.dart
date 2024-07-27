import 'dart:convert';

import 'package:crystal_solutions/HHH/DrawerPages/Customers/addCustomers.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Customers/updateCustomers.dart';
import 'package:crystal_solutions/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Model/City/GetCityModel.dart';
import '../../../Model/Collectors/GetCollectorsModel.dart';
import '../../../Model/Customers/GetCustomersModel.dart';
import '../../../Model/Reference/GetReferenceModel.dart';
import '../../../Model/Type/GetType.dart';
import '../../../cosmos.dart';

class GetCustomersScreen extends StatefulWidget {
  const GetCustomersScreen({super.key});

  @override
  State<GetCustomersScreen> createState() => _GetCustomersScreenState();
}

class _GetCustomersScreenState extends State<GetCustomersScreen> {
  List<GetCustomersModel> _getCustomerListModel = [];
  List<GetCustomersModel> filterCustomerList = [];
  List<GetCityModel> _getCityList = [];
  List<GetReferenceModel> _getReferenceList = [];
  List<GetCollectorsModel> _getCollectorList = [];
  List<GetType> _getTypeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Customers();
    get_City();
    get_Collectors();
    get_Reference();
    get_Type();
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
                  MaterialPageRoute(builder: (context) =>  AddCustomers(getCityList: _getCityList,
                    getCollectorList: _getCollectorList,
                    getReferenceList: _getReferenceList,
                    getTypeList: _getTypeList,)))
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
                onChanged: (value){
                  filterCustomers(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
        Expanded(
          child: filterCustomerList.isEmpty
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            itemCount: filterCustomerList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                        filterCustomerList[index].tCstDsc.toString(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    const TextSpan(
                                      text: 'Mobile: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: filterCustomerList[index]
                                          .tMobNUm
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
                                      text: filterCustomerList[index]
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
                                      text: filterCustomerList[index]
                                          .tAdd001
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ])),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                          text: 'Email: ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: filterCustomerList[index]
                                              .tEmlAdd
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ])),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateCustomersScreen(
                                                    getCustomersModel: filterCustomerList[index],
                                                    getCityList: _getCityList,
                                                    getCollectorList: _getCollectorList,
                                                    getReferenceList: _getReferenceList,
                                                    getTypeList: _getTypeList,
                                                  ))).then(
                                              (value) => get_Customers());
                                    },
                                    child: Icon(Icons.edit,
                                      size: 20,
                                      color: Cosmic.app_color,
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                    const TextSpan(
                                      text: 'IP: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: filterCustomerList[index]
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
                                      text: filterCustomerList[index]
                                          .tShpNum
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ])),
                              RichText(
                                  text: TextSpan(children: [
                                    const TextSpan(
                                      text: 'Status: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: filterCustomerList[index]
                                          .tCstSts
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

  Future get_Customers() async {
    var response = await http.post(Uri.parse(getCust));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getCustomerListModel.clear();
      for (Map i in result) {
        _getCustomerListModel.add(GetCustomersModel.fromJson(i));
      }
      setState(() {
        filterCustomerList = List.from(_getCustomerListModel);
      });
    }
  }
  Future get_City() async {
    var response = await http.post(Uri.parse(getCity));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getCityList.clear();
      for (Map i in result) {
        _getCityList.add(GetCityModel.fromJson(i));
      }
      setState(() {});
    }
  }
  Future get_Reference() async {
    var response = await http.post(Uri.parse(getRef));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getReferenceList.clear();
      for (Map i in result) {
        _getReferenceList.add(GetReferenceModel.fromJson(i));
      }
      setState(() {});
    }
  }
  Future get_Collectors() async {
    var response = await http.get(Uri.parse(getCol));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getCollectorList.clear();
      for (Map i in result) {
        _getCollectorList.add(GetCollectorsModel.fromJson(i));
        print(response.body);
      }
      setState(() {
      });
    }
  }
  Future get_Type() async {
    var response = await http.post(Uri.parse(getType));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getTypeList.clear();
      for (Map i in result) {
        _getTypeList.add(GetType.fromJson(i));
      }
      setState(() {});
    }
  }

  filterCustomers(String query) {
    setState(() {
      filterCustomerList = _getCustomerListModel
          .where((element) =>
          element.tCstDsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
