import 'dart:convert';
import 'package:crystal_solutions/HHH/DrawerPages/Type/addType.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Type/updateType.dart';
import 'package:http/http.dart'as http;
import 'package:crystal_solutions/Model/Type/GetType.dart';
import 'package:flutter/material.dart';

import '../../../apis.dart';
import '../../../cosmos.dart';

class GetTypeScreen extends StatefulWidget {
  const GetTypeScreen({super.key});

  @override
  State<GetTypeScreen> createState() => _GetTypeScreenState();
}

class _GetTypeScreenState extends State<GetTypeScreen> {
  List<GetType> _getTypeList = [];
  List<GetType> _filterTypeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Type();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Types',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddType()))
              .then((value) => get_Type());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Type,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  filterType(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: _filterTypeList.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: _filterTypeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Card(
                          elevation: 2,
                          shadowColor: Cosmic.app_color,
                          borderOnForeground: true,
                          surfaceTintColor: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _filterTypeList[index]
                                      .ttypdsc
                                      .toString(),
                               style: const TextStyle(fontSize: 14),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_filterTypeList[index]
                                        .ttypsts
                                        .toString(), style: const TextStyle(fontSize: 12),),

                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateTypeScreen(
                                                        getTypeList:
                                                        _getTypeList[
                                                        index],
                                                      )))
                                              .then((value) => get_Type());
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

  Future get_Type() async {
    var response = await http.post(Uri.parse(getType));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getTypeList.clear();
      for (Map i in result) {
        _getTypeList.add(GetType.fromJson(i));
      }
      setState(() {
        _filterTypeList = List.from(_getTypeList);
      });
    }
  }
  filterType(String query) {
    setState(() {
      _filterTypeList = _getTypeList
          .where((element) =>
          element.ttypdsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}

