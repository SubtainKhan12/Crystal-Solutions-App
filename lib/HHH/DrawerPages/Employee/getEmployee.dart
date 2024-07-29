import 'dart:convert';

import 'package:crystal_solutions/HHH/DrawerPages/Employee/updateEmployee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Designation/GetDesignationModel.dart';
import '../../../Model/Employe/GetEmployeeModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';
import 'addEmployee.dart';

class GetEmployeeScreen extends StatefulWidget {
  const GetEmployeeScreen({super.key});

  @override
  State<GetEmployeeScreen> createState() => _GetEmployeeScreenState();
}

class _GetEmployeeScreenState extends State<GetEmployeeScreen> {
  List<GetEmployeeModel> _getEmployeeList = [];
  List<GetEmployeeModel> filterEmployeeList = [];
  List<GetDesignationModel> _getDesignationList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Employee();
    get_Designation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  AddEmployee(getDesignationList: _getDesignationList,)))
              .then((value) => get_Employee());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Employee,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  filterEmployee(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterEmployeeList.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                  itemCount: filterEmployeeList.length,
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
                              filterEmployeeList[index].tempnam.toString(),
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
                                            text: filterEmployeeList[index]
                                                .tmobnum
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'CNIC: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterEmployeeList[index]
                                                .tnicnum
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
                                            text: filterEmployeeList[index]
                                                .tadd001
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
                                                text: filterEmployeeList[index]
                                                    .temladd
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
                                                        UpdateEmployee(
                                                          getEmployeeList: _getEmployeeList[index],
                                                          getDesignationList: _getDesignationList,
                                                        ))).then(
                                                    (value) => get_Employee());
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
                                            text: 'Salary: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterEmployeeList[index]
                                                .tempsal
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(children: [
                                           TextSpan(
                                            text: '${filterEmployeeList[index].tbnknam.toString()}: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: filterEmployeeList[index]
                                                .tbnkacc
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
                                            text: filterEmployeeList[index]
                                                .tempsts
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

  Future get_Employee() async {
    var response = await http.post(Uri.parse(getEmployee));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getEmployeeList.clear();
      for (Map i in result) {
        _getEmployeeList.add(GetEmployeeModel.fromJson(i));
      }
      setState(() {
        filterEmployeeList = List.from(_getEmployeeList);
      });
    }
  }
  Future get_Designation() async {
    var response = await http.post(Uri.parse(getDesignation));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getDesignationList.clear();
      for (Map i in result) {
        _getDesignationList.add(GetDesignationModel.fromJson(i));
      }
      setState(() {
      });
    }
  }
  filterEmployee(String query) {
    setState(() {
      filterEmployeeList = _getEmployeeList
          .where((element) =>
          element.tempnam!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
