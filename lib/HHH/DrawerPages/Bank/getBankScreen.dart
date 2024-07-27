import 'dart:convert';

import 'package:crystal_solutions/HHH/DrawerPages/Bank/addBank.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Bank/updateBank.dart';
import 'package:crystal_solutions/Model/Bank/GetBankModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../apis.dart';
import '../../../cosmos.dart';

class GetBankScreen extends StatefulWidget {
  const GetBankScreen({super.key});

  @override
  State<GetBankScreen> createState() => _GetBankScreenState();
}

class _GetBankScreenState extends State<GetBankScreen> {
  List<GetBankModel> _getBankList = [];
  List<GetBankModel> filterBankList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Bank();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bank',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddBankScreen()))
              .then((value) => get_Bank());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Bank,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  filterBank(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterBankList.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: filterBankList.length,
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
                                  filterBankList[index]
                                      .tbnkdsc
                                      .toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(filterBankList[index]
                                        .tbnksts
                                        .toString(), style: const TextStyle(fontSize: 12),),

                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateBankScreen(
                                                        getBankList:
                                                        _getBankList[
                                                        index],
                                                      )))
                                              .then((value) => get_Bank());
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
  Future get_Bank() async {
    var response = await http.post(Uri.parse(getBank));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getBankList.clear();
      for (Map i in result) {
        _getBankList.add(GetBankModel.fromJson(i));
      }
      setState(() {
        filterBankList = List.from(_getBankList);
      });
    }
  }
  filterBank(String query) {
    setState(() {
      filterBankList = _getBankList
          .where((element) =>
          element.tbnkdsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}


