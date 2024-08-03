import 'dart:convert';
import 'dart:io';
import 'package:crystal_solutions/HHH/DrawerPages/Recipt/Generate%20Bill/generateBill.dart';
import 'package:crystal_solutions/Model/Bank/GetActiveBank.dart';
import 'package:crystal_solutions/apis.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../cosmos.dart';
import '../Customers/Customer PDF/pdf_file_handle.dart';
import 'Full Screen Image/fullScreenImage.dart';
import 'Reciept Pdf/customerReciept_Pdf.dart';

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
  DateTime selectedDate = DateTime.now();
  String? selectBank;
  File? _localImage;

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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                              InkWell(
                                                onTap: () {
                                                  _showBottomSheet(
                                                      context,
                                                      filterActiveCustomerList[
                                                          index]);
                                                },
                                                child: Icon(
                                                    Icons.add_chart_outlined),
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

  void _showBottomSheet(
      BuildContext context, GetActiveCustomersModel getActiveCustomersModel) {
    showModalBottomSheet(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BillGenerationUi(getActiveCustomersList: getActiveCustomersModel)));
                  }, child: Text('Monthly Bill Generation',style: TextStyle(fontSize: 20),)),
              TextButton(
                  onPressed: () async {
                    final pdfFile = await CustomerReciept_PDF.generate(
                        getActiveCustomersModel);
                    PdfFileHandle.openFile(pdfFile);
                  },
                  child: Text('PDF Bill', style: TextStyle(fontSize: 20),)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showDialog(context, getActiveCustomersModel);
                  },
                  child: Text('Add Collection',style: TextStyle(fontSize: 20),)),
              TextButton(onPressed: () async {}, child: Text('Ledger',style: TextStyle(fontSize: 20),)),
              TextButton(onPressed: () {}, child: Text('Complaints',style: TextStyle(fontSize: 20),)),
              TextButton(
                  onPressed: () async {}, child: Text('Profile',style: TextStyle(fontSize: 20),)),
            ],
          ),
        );
      },
    );
  }

  void _showDialog(
      BuildContext context, GetActiveCustomersModel getActiveCustomersModel) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

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

    void _takePictureFromGallery(StateSetter setState) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _localImage = File(pickedFile.path);
        });
      }
    }

    void _takePictureFromCamera(StateSetter setState) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _localImage = File(pickedFile.path);
        });
      }
    }

    Future<void> _showDialogeCameraAndGallery(
        BuildContext context, StateSetter setState) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose an option'),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  _takePictureFromCamera(setState);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: _height * 0.04,
                  child: Image.asset('assets/camera.png'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  _takePictureFromGallery(setState);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: _height * 0.04,
                  child: Image.asset('assets/gallery.png'),
                ),
              )
            ],
          );
        },
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Add Collection', style: TextStyle(fontSize: 16)),
                content: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: _localImage == null
                                  ? const Center(child: Text(""))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        _localImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                _showDialogeCameraAndGallery(context, setState);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getActiveCustomersModel.tCstDsc.toString(),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getActiveCustomersModel.tsrvchg.toString(),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getActiveCustomersModel.tadvchg.toString(),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getActiveCustomersModel.tsmschg.toString(),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getActiveCustomersModel.tposchg.toString(),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getActiveCustomersModel.tmthChg.toString(),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: getActiveCustomersModel.ttotamt.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: _height * 0.06,
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
                          height: _height * 0.06,
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
                          height: _height * 0.06,
                          child: DropdownButtonFormField<String>(
                            value: selectBank,
                            onChanged: (newValue) {
                              setState(() {
                                selectBank = newValue;
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
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        selectedDate = DateTime.now();
                        _amountController.clear();
                        _remarksController.clear();
                        selectBank = null;
                        _localImage = null;
                      });
                    },
                  ),
                  TextButton(
                    child: Text('Submit'),
                    onPressed: () {
                      post_newCollection(getActiveCustomersModel);
                      Cosmos.waitingDialog(context, '         Please wait');
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future post_newCollection(
      GetActiveCustomersModel getActiveCustomersModel) async {
    var request = http.MultipartRequest('POST', Uri.parse(newCollection));
    request.fields['FTrnDat'] = selectedDate.toString();
    request.fields['FCstId'] = getActiveCustomersModel.tcstid.toString();
    request.fields['FTrnTot'] = _amountController.text.toString();
    request.fields['FTrnDsc'] = _remarksController.text.toString();
    request.fields['FBnkId'] = selectBank.toString();

    if (_localImage != null) {
      var picture =
          await http.MultipartFile.fromPath('ColImg', _localImage!.path);
      request.files.add(picture);
    }

    final response = await http.Response.fromStream(await request.send());

    var result = jsonDecode(response.body.toString());

    if (result["error"] == 200) {
      print(getActiveCustomersModel.tcstid.toString());
      print(result["message"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
      setState(() {
        selectedDate = DateTime.now();
        _amountController.clear();
        _remarksController.clear();
        selectBank = null;
        _localImage = null;
      });
    } else {
      print(result["error"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      setState(() {
        selectedDate = DateTime.now();
        _amountController.clear();
        _remarksController.clear();
        selectBank = null;
        _localImage = null;
      });
    }
  }

  Future<void> get_ActiveCustomers() async {
    filterActiveCustomerList.clear();
    var response = await http.get(Uri.parse(getActiveCust));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      _getActiveCustomerList = List<GetActiveCustomersModel>.from(
          jsonData.map((model) => GetActiveCustomersModel.fromJson(model)));
      setState(() {
        filterActiveCustomerList = _getActiveCustomerList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> get_ActiveBank() async {
    var response = await http.get(Uri.parse(getActiveBank));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      _getActiveBankList = List<GetActiveBank>.from(
          jsonData.map((model) => GetActiveBank.fromJson(model)));
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterActiveCustomers(String query) {
    List<GetActiveCustomersModel> filteredList = [];
    for (var customer in _getActiveCustomerList) {
      if (customer.tCstDsc!.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(customer);
      }
    }
    setState(() {
      filterActiveCustomerList = filteredList;
    });
  }
}
