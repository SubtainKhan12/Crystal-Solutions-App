import 'dart:convert';
import 'dart:io';
import 'package:crystal_solutions/Model/Bank/GetActiveBank.dart';
import 'package:crystal_solutions/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../cosmos.dart';
import 'Full Screen Image/fullScreenImage.dart';

class CustomerCollectionScreen extends StatefulWidget {
  const CustomerCollectionScreen({super.key});

  @override
  State<CustomerCollectionScreen> createState() =>
      _CustomerCollectionScreenState();
}

class _CustomerCollectionScreenState extends State<CustomerCollectionScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  List<GetActiveCustomersModel> _getActiveCustomerList = [];
  List<GetActiveCustomersModel> filterActiveCustomerList = [];
  List<GetActiveBank> _getActiveBankList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ActiveCustomers();
    get_ActiveBank();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customers Collections',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: RefreshIndicator(
        onRefresh: get_ActiveCustomers,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterActiveCustomers(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterActiveCustomerList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filterActiveCustomerList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              shadowColor: Cosmic.app_color,
                              borderOnForeground: true,
                              surfaceTintColor: Colors.blue.shade100,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  minTileHeight: 30,
                                  title: Text(
                                    filterActiveCustomerList[index]
                                        .tCstDsc
                                        .toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  children: [
                                    Divider(
                                      color: Cosmic.app_color,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                 text: TextSpan(children: [
                                                   const TextSpan(
                                                     text: 'Mobile: ',
                                                     style: TextStyle(
                                                         color: Colors.black,
                                                         fontWeight:
                                                         FontWeight.bold),
                                                   ),
                                                   TextSpan(
                                                     text:
                                                     filterActiveCustomerList[
                                                     index]
                                                         .tMobNUm
                                                         .toString(),
                                                     style: const TextStyle(
                                                       color: Colors.black,
                                                     ),
                                                   ),
                                                 ])),
                                              SizedBox(
                                                width: 50,
                                                height: 30,
                                                child: PopupMenuButton<int>(
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        _showDialog(context, filterActiveCustomerList[index]);
                                                      },
                                                      value: 1,
                                                      child: Text(
                                                        "Update Status",
                                                        style: TextStyle(fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                  offset: const Offset(0, 30),
                                                  color: Colors.white,
                                                  elevation: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                                const TextSpan(
                                                  text: 'Monthly Charges: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: filterActiveCustomerList[
                                                  index]
                                                      .tmthChg
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ])),
                                          RichText(
                                              text: TextSpan(children: [
                                                const TextSpan(
                                                  text: 'Address1: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: filterActiveCustomerList[
                                                  index]
                                                      .tAdd001
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ])),
                                          RichText(
                                              text: TextSpan(children: [
                                                const TextSpan(
                                                  text: 'Email: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: filterActiveCustomerList[
                                                  index]
                                                      .tEmlAdd
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ])),
                                          RichText(
                                              text: TextSpan(children: [
                                                const TextSpan(
                                                  text: 'IP: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: filterActiveCustomerList[
                                                  index]
                                                      .tSrvIp
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ])),
                                          RichText(
                                              text: TextSpan(children: [
                                                const TextSpan(
                                                  text: 'Shops: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: filterActiveCustomerList[
                                                  index]
                                                      .tShpNum
                                                      .toString(),
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
  void _showDialog(BuildContext context, GetActiveCustomersModel customer) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    String? SelectBank;
    DateTime selectedDate = DateTime.now(); // Default date
    final TextEditingController _amountController = TextEditingController();
    File? _localImage;

    Future<void> _selectDate(BuildContext context, StateSetter setState) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    void _takePicture(StateSetter setState) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _localImage = File(pickedFile.path);
        });
      }
    }

    void _viewFullScreenImage(File image) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FullScreenImage(image: image)),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Update Collection Status', style: TextStyle(fontSize: 16)),
              content: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: _localImage != null
                                ? () => _viewFullScreenImage(_localImage!)
                                : null,
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
                      InkWell(
                        onTap: () => _selectDate(context, setState),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: customer.tCstDsc.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Server Charges: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: customer.tsrvchg.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Advance Charges: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: customer.tadvchg.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Sms Charges: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: customer.tsmschg.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Pso Charges: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: customer.tposchg.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Monthly Charges: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: customer.tmthChg.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Total Charges: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: customer.ttotamt.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: _height * 0.05,
                        child: TextField(
                          controller: _amountController,
                          decoration: InputDecoration(
                              labelText: 'Enter Collection Amount',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3))),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: _height * 0.05,
                        child: TextField(
                          controller: _remarksController,
                          decoration: InputDecoration(
                              labelText: 'Remarks',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3))),
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
                          }).toList() ?? [],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Submit'),
                  onPressed: () {
                    // Handle submit logic here
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }




  Future get_ActiveCustomers() async {
    var response = await http.post(Uri.parse(getActiveCust));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getActiveCustomerList.clear();
      for (Map i in result) {
        _getActiveCustomerList.add(GetActiveCustomersModel.fromJson(i));
      }
      setState(() {
        filterActiveCustomerList = List.from(_getActiveCustomerList);
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

  filterActiveCustomers(String query) {
    setState(() {
      filterActiveCustomerList = _getActiveCustomerList
          .where((element) =>
              element.tCstDsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
