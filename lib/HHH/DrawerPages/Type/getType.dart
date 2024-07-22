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
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: _getTypeList.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: _getTypeList.length,
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
                                  _getTypeList[index]
                                      .ttypdsc
                                      .toString(),
                                  style: FontSizeAndWeight.Heading1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_getTypeList[index]
                                        .ttypsts
                                        .toString()),
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
      setState(() {});
    }
  }
}

