import 'dart:convert';


import 'package:crystal_solutions/Model/BillRegister/BillRegisterModel.dart';
import 'package:crystal_solutions/Model/RegisterCollection/CollectionsRegisters.dart';
import 'package:http/http.dart'as http;
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import '../../../apis.dart';

class BillRegisterUi extends StatefulWidget {
  const BillRegisterUi({super.key});

  @override
  State<BillRegisterUi> createState() => _BillRegisterUiState();
}

class _BillRegisterUiState extends State<BillRegisterUi> {
  BillRegisterModel? billRegisterModel;
  // CollectionsRegistersModel? searchModel;
  DateTime selectedInitialDate = DateTime.now();
  DateTime selectedFinalDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Register', style: TextStyle(color: Cosmic.white_color),),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: RefreshIndicator(
        onRefresh: post_BillRegister,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                // onChanged: (value) {
                //   fil(value);
                // },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text("Total Amount: ${billRegisterModel?.totalAmount ??'0'} PKR", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: () => _intSelectDate(context, setState),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            "${selectedInitialDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: () { _fnlSelectDate(context, setState);

                      },
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            "${selectedFinalDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: (){
                    post_BillRegister();
                  },
                  child: Text('Submit')),
              Expanded(
                child: ListView.builder(
                  itemCount:  billRegisterModel?.detail?.length ??0,
                  itemBuilder: (context, index) {

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        elevation: 2,
                        shadowColor: Cosmic.app_color,
                        borderOnForeground: true,
                        surfaceTintColor: Colors.blue.shade100,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            minTileHeight: 30,
                            title: Text(
                              billRegisterModel!.detail![index].date.toString(), // Use the correct index here
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              billRegisterModel!.detail![index].customer.toString(), // Use the correct index here
                              style: const TextStyle(fontSize: 14),
                            ),
                            children: [
                              Divider(
                                color: Cosmic.app_color,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                              const TextSpan(
                                                text: 'TRN#: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: billRegisterModel!.detail![index].trn.toString(), // Use the correct index here
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ])),
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(Icons.picture_as_pdf),
                                        ),
                                      ],
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'Collection: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: billRegisterModel!.detail![index].amount.toString(), // Use the correct index here
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
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
  Future<void> _intSelectDate(BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedInitialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedInitialDate) {
      setState(() {
        selectedInitialDate = picked;
      });
    }
  }
  Future<void> _fnlSelectDate(BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFinalDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFinalDate) {
      setState(() {
        selectedFinalDate = picked;
      });
    }
  }
  Future post_BillRegister() async {
    var response = await http.post(Uri.parse(BillRegister), body: {
      'FIntDat': selectedInitialDate.toString(),
      'FFnlDat': selectedFinalDate.toString(),
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      billRegisterModel?.detail?.clear();
      billRegisterModel = BillRegisterModel.fromJson(result);

      setState(() {
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

}
