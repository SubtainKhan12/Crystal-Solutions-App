import 'dart:convert';

import 'package:crystal_solutions/HHH/DrawerPages/Reference/addReference.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Reference/updateReference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../Model/Reference/GetReferenceModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class GetReferenceScreen extends StatefulWidget {
  const GetReferenceScreen({super.key});

  @override
  State<GetReferenceScreen> createState() => _GetReferenceScreenState();
}

class _GetReferenceScreenState extends State<GetReferenceScreen> {
  List<GetReferenceModel> _getReferenceList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Reference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reference',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddReference()))
              .then((value) => get_Reference());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Reference,
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
                child: _getReferenceList.isEmpty
                    ? const Center( 
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: _getReferenceList.length,
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
                                  _getReferenceList[index]
                                      .trefdsc
                                      .toString(),
                               style: const TextStyle(fontSize: 14),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_getReferenceList[index]
                                        .trefsts
                                        .toString(), style: const TextStyle(fontSize: 12),),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateReferenceScreen(
                                                        getReferenceList:
                                                        _getReferenceList[
                                                        index],
                                                      )))
                                              .then((value) => get_Reference());
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Cosmic.app_color,
                                        )),
                                  ],
                                ),
                                Text(_getReferenceList[index]
                                    .temladd
                                    .toString(), style: const TextStyle(fontSize: 12),),
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
}

