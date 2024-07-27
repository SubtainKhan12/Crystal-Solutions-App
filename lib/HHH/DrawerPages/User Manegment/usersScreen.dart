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
  List<GetUsersModel> filterUsersList = [];

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
                  MaterialPageRoute(builder: (context) => const AddUserScreen()))
              .then((value) => get_Users());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Users,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  filterUsers(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterUsersList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filterUsersList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
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
                                  minTileHeight: 20,
                                  title: Text(
                                    filterUsersList[index]
                                        .tUsrNam
                                        .toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(filterUsersList[index].tusrTyp.toString(), style: const TextStyle(fontSize: 12),),
                                  children: [
                                    Divider(
                                      thickness: 1,
                                      color: Cosmic.app_color,
                                      endIndent: 25,
                                      indent: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                                text: 'Login Id: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: filterUsersList[index]
                                                    .tusrId
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                )),
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                                text: 'Password: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: filterUsersList[index]
                                                    .tUsrPwd
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                )),
                                          ])),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                const TextSpan(
                                                    text: 'Email: ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: filterUsersList[index]
                                                        .tUsrEml
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ])),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => UpdateUserScreen(
                                                        getUsersModel: filterUsersList[index],
                                                      ),
                                                    ),
                                                  ).then((value) => get_Users());
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Cosmic.app_color,
                                                ),
                                              ),
                                            ],
                                          ),

                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                                text: 'Mobile: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: filterUsersList[index]
                                                    .tMobNum
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                )),
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            const TextSpan(
                                                text: 'Status: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: filterUsersList[index]
                                                    .tUsrSts
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                )),
                                          ])),
                                          // Text(_getUsersListModel[index].tMobNum.toString()),
                                          // Text(_getUsersListModel[index].tUsrPwd.toString()),
                                          // Text(_getUsersListModel[index].tUsrEml.toString()),
                                          // Text(_getUsersListModel[index].tUsrSts.toString()),
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
              )
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
      setState(() {
        filterUsersList = List.from(_getUsersListModel);
      });
    }
  }
  filterUsers(String query) {
    setState(() {
      filterUsersList = _getUsersListModel
          .where((element) =>
          element.tUsrNam!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
