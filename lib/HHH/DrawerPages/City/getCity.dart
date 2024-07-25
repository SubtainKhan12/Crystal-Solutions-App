import 'dart:convert';
import 'package:crystal_solutions/HHH/DrawerPages/City/updateCity.dart';
import 'package:http/http.dart'as http;
import 'package:crystal_solutions/HHH/DrawerPages/City/addCity.dart';
import 'package:crystal_solutions/apis.dart';
import 'package:flutter/material.dart';

import '../../../Model/City/GetCityModel.dart';
import '../../../cosmos.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<GetCityModel> _getCityList = [];
  List<GetCityModel> _filterCityList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_City();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cities',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCity()))
              .then((value) => get_City());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_City,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  filterCity(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: _filterCityList.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: _filterCityList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                                  _filterCityList[index]
                                      .tctydsc
                                      .toString(),
                                  style: FontSizeAndWeight.Heading1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_filterCityList[index]
                                        .tctysts
                                        .toString()),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateCityScreen(
                                                        getCityList:
                                                        _getCityList[
                                                        index],
                                                      )))
                                              .then((value) => get_City());
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

  Future get_City() async {
    var response = await http.post(Uri.parse(getCity));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getCityList.clear();
      for (Map i in result) {
        _getCityList.add(GetCityModel.fromJson(i));
      }
      setState(() {
        _filterCityList = List.from(_getCityList);
      });
    }
  }
  filterCity(String query) {
    setState(() {
      _filterCityList = _getCityList
          .where((element) =>
          element.tctydsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
