import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crystal_solutions/HHH/DrawerPages/Collectors/addCollectors.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Collectors/updateCollector.dart';
import 'package:flutter/material.dart';
import '../../../Model/Collectors/GetCollectorsModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class CollectorsScreen extends StatefulWidget {
  const CollectorsScreen({super.key});

  @override
  State<CollectorsScreen> createState() => _CollectorsScreenState();
}

class _CollectorsScreenState extends State<CollectorsScreen> {
  List<GetCollectorsModel> _getCollectorList = [];
  List<GetCollectorsModel> filterCollectorsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Collectors(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collectors',
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
                      builder: (context) => const AddCollectors()))
              .then((value) => get_Collectors());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_Collectors,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterCollectors(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterCollectorsList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filterCollectorsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Card(
                              elevation: 2,
                              shadowColor: Cosmic.app_color,
                              borderOnForeground: true,
                              surfaceTintColor: Colors.blue,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: Text(
                                    filterCollectorsList[index]
                                        .tcoldsc
                                        .toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(filterCollectorsList[index].tcolsts.toString(), style: const TextStyle(fontSize: 12),),
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
                                                text: 'Phone: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    filterCollectorsList[index]
                                                        .tmobnum
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                )),
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
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: filterCollectorsList[
                                                            index]
                                                        .temladd
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
                                                      builder: (context) =>
                                                          UpdateCollector(getCollectorsModel: _getCollectorList[index],),
                                                    ),
                                                  ).then((value) =>
                                                      get_Collectors());
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
                                                text:
                                                    filterCollectorsList[index]
                                                        .tadd001
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
                                                text:
                                                    filterCollectorsList[index]
                                                        .tcolsts
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                )),
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

  Future get_Collectors() async {
    var response = await http.get(Uri.parse(getCol));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getCollectorList.clear();
      for (Map i in result) {
        _getCollectorList.add(GetCollectorsModel.fromJson(i));
        // print(response.body);
      }
      setState(() {
        filterCollectorsList = List.from(_getCollectorList);
      });
    }
  }

  filterCollectors(String query) {
    setState(() {
      filterCollectorsList = _getCollectorList
          .where((element) =>
              element.tcoldsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
