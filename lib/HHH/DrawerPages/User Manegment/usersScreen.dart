import 'dart:convert';
import 'package:crystal_solutions/HHH/DrawerPages/User%20Manegment/updateUser.dart';
import 'package:http/http.dart' as http;
import 'package:crystal_solutions/apis.dart';
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';

import '../../../Model/Users/GetUsersModel.dart';
import 'addUser.dart';

class GetUsersScreen extends StatefulWidget {
  const GetUsersScreen({super.key});

  @override
  State<GetUsersScreen> createState() => _GetUsersScreenState();
}

class _GetUsersScreenState extends State<GetUsersScreen> {
  List<GetUsersModel> _getUsersListModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Users();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddUserScreen()))
              .then((value) => get_Users());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Users,
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
                child: _getUsersListModel.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _getUsersListModel.length,
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
                                      _getUsersListModel[index]
                                          .tUsrNam
                                          .toString(),
                                      style: FontSizeAndWeight.Heading1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_getUsersListModel[index]
                                            .tusrTyp
                                            .toString()),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateUserScreen(
                                                                getUsersModel:
                                                                    _getUsersListModel[
                                                                        index],
                                                              )))
                                                  .then((value) => get_Users());
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Cosmic.app_color,
                                            )),
                                      ],
                                    ),
                                    Text(_getUsersListModel[index]
                                        .tMobNum
                                        .toString()),
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

  Future get_Users() async {
    var response = await http.post(Uri.parse(getUsers));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getUsersListModel.clear();
      for (Map i in result) {
        _getUsersListModel.add(GetUsersModel.fromJson(i));
      }
      setState(() {});
    }
  }
}
