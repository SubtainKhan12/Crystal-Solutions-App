import 'dart:convert';
import 'package:crystal_solutions/HHH/DrawerPages/Designation/addDesignation.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Designation/updateDesignation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../Model/Designation/GetDesignationModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class GetDesignationScreen extends StatefulWidget {
  const GetDesignationScreen({super.key});

  @override
  State<GetDesignationScreen> createState() => _GetDesignationScreenState();
}

class _GetDesignationScreenState extends State<GetDesignationScreen> {
  List<GetDesignationModel> _getDesignationList = [];
  List<GetDesignationModel> _filterDesignationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Designation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Designations',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDesignationScreen()))
              .then((value) => get_Designation());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Designation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterDesignation(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: _filterDesignationList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _filterDesignationList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              shadowColor: Cosmic.app_color,
                              borderOnForeground: true,
                              surfaceTintColor: Colors.blue.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _filterDesignationList[index]
                                          .tdsgdsc
                                          .toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_filterDesignationList[index]
                                            .tdsgsts
                                            .toString()),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateDesignationScreen(
                                                            getDesignationList:
                                                                _getDesignationList[
                                                                    index],
                                                          ))).then(
                                                  (value) => get_Designation());
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Cosmic.app_color,
                                            )),
                                      ],
                                    ),
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

  Future get_Designation() async {
    var response = await http.post(Uri.parse(getDesignation));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getDesignationList.clear();
      for (Map i in result) {
        _getDesignationList.add(GetDesignationModel.fromJson(i));
      }
      setState(() {
        _filterDesignationList = List.from(_getDesignationList);
      });
    }
  }

  filterDesignation(String query) {
    setState(() {
      _filterDesignationList = _getDesignationList
          .where((element) =>
              element.tdsgdsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
