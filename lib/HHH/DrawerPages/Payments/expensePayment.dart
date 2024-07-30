import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../Model/Bank/GetActiveBank.dart';
import '../../../Model/Expense/GetActiveExpense.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class ExpensePaymentScreen extends StatefulWidget {
  const ExpensePaymentScreen({super.key});

  @override
  State<ExpensePaymentScreen> createState() => _ExpensePaymentScreenState();
}

class _ExpensePaymentScreenState extends State<ExpensePaymentScreen> {
  List<GetActiveExpense> _getActiveExpensList = [];
  List<GetActiveExpense> filterActiveExpenseList = [];
  List<GetActiveBank> _getActiveBankList = [];
  String? SelectBank;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ActiveExp();
    get_ActiveBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: RefreshIndicator(
        onRefresh: get_ActiveExp,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterActiveExpense(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterActiveExpenseList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filterActiveExpenseList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          filterActiveExpenseList[index]
                                              .texpdsc
                                              .toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              _showBottomSheet(context);
                                            },
                                            child: Icon(
                                                Icons.align_vertical_bottom)),
                                      ],
                                    ),
                                    Text(
                                      filterActiveExpenseList[index]
                                          .texpsts
                                          .toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      filterActiveExpenseList[index]
                                          .tmthbgt
                                          .toString(),
                                      style: const TextStyle(fontSize: 12),
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

  void _showBottomSheet(BuildContext context) {
    File? _localImage;

    void _takePicture(StateSetter setState) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _localImage = File(pickedFile.path);
        });
      }
    }
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Expense Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _localImage == null
                            ? const Center(child: Text(""))
                            : Image.file(
                          _localImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => _takePicture(setState),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  height: _height * 0.05,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Remarks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: _height * 0.05,
                  child: DropdownButtonFormField<String>(
                    value: SelectBank,
                    onChanged: (newValue) {
                      setState(() {
                        SelectBank = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Bank",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    items: _getActiveBankList.map((collector) {
                          return DropdownMenuItem<String>(
                            value: collector.tbnkid ?? '',
                            child: Text(collector.tbnkdsc ?? ''),
                          );
                        }).toList() ??
                        [],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: _height * 0.05,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    // Handle the save action
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  Future get_ActiveExp() async {
    var response = await http.post(Uri.parse(getActiveExp));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getActiveExpensList.clear();
      for (Map i in result) {
        _getActiveExpensList.add(GetActiveExpense.fromJson(i));
      }
      setState(() {
        filterActiveExpenseList = List.from(_getActiveExpensList);
      });
    }
  }

  Future get_ActiveBank() async {
    var response = await http.post(Uri.parse(getActiveBank));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getActiveBankList.clear();
      for (Map i in result) {
        _getActiveBankList.add(GetActiveBank.fromJson(i));
      }
      setState(() {});
    }
  }

  filterActiveExpense(String query) {
    setState(() {
      filterActiveExpenseList = _getActiveExpensList
          .where((element) =>
              element.texpdsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
