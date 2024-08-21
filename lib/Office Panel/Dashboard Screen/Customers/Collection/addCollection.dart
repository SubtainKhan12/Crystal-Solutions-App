import 'dart:convert';
import 'dart:io';

import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import '../../../../Model/Bank/GetActiveBank.dart';
import '../../../../Model/Bill/GetBillModel.dart';
import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../apis.dart';

class AddCollectionUI extends StatefulWidget {
  GetActiveCustomersModel getActiveCustomersModel;
  List<GetActiveBank> getActiveBankList = [];

  AddCollectionUI({super.key, required this.getActiveCustomersModel, required this.getActiveBankList});

  @override
  State<AddCollectionUI> createState() => _AddCollectionUIState();
}

class _AddCollectionUIState extends State<AddCollectionUI> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _billDescriptionController = TextEditingController();
  TextEditingController _arrearChargesController = TextEditingController();
  TextEditingController _serverChargesController = TextEditingController();
  TextEditingController _monthlyChargesController = TextEditingController();
  TextEditingController _posChargesController = TextEditingController();
  TextEditingController _smsChargesController = TextEditingController();
  TextEditingController _advanceChargesController = TextEditingController();
  TextEditingController _otherChargesController = TextEditingController();
  TextEditingController _totalChargesController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  File? _image;
  String? selectBank;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomerData();
    // _updateTotalCharges();

    // Add listeners to update total charges
    // _arrearChargesController.addListener(_updateTotalCharges);
    // _serverChargesController.addListener(_updateTotalCharges);
    // _monthlyChargesController.addListener(_updateTotalCharges);
    // _posChargesController.addListener(_updateTotalCharges);
    // _smsChargesController.addListener(_updateTotalCharges);
    // _advanceChargesController.addListener(_updateTotalCharges);
    // _otherChargesController.addListener(_updateTotalCharges);
  }
  // @override
  // void dispose() {
  //   // Remove listeners to prevent memory leaks
  //   _arrearChargesController.removeListener(_updateTotalCharges);
  //   _serverChargesController.removeListener(_updateTotalCharges);
  //   _monthlyChargesController.removeListener(_updateTotalCharges);
  //   _posChargesController.removeListener(_updateTotalCharges);
  //   _smsChargesController.removeListener(_updateTotalCharges);
  //   _advanceChargesController.removeListener(_updateTotalCharges);
  //   _otherChargesController.removeListener(_updateTotalCharges);
  //
  //   _arrearChargesController.dispose();
  //   _serverChargesController.dispose();
  //   _monthlyChargesController.dispose();
  //   _posChargesController.dispose();
  //   _smsChargesController.dispose();
  //   _advanceChargesController.dispose();
  //   _otherChargesController.dispose();
  //   _totalChargesController.dispose();
  //   _billDescriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Collection',style: TextStyle(color: Cosmic.white_color),),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Opacity(
              opacity: 0.3, // Adjust the opacity as needed
              child: Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                child: Image.asset('assets/Crystal-Solutions-logo-removebg-preview.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: _image == null
                            ? const Center(child: Text(""))
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                                        _image!,
                                                        fit: BoxFit.cover,
                                                      ),
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.red,
                            size: 45,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 230),
                    child: InkWell(
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
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 0.3,
                    height: MediaQuery.of(context).size.height / 16,
                    child: TextField(
                      controller: _nameController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Customer Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 0.3,
                  //   height: MediaQuery.of(context).size.height / 16,
                  //   child: TextField(
                  //     controller: _arrearChargesController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       labelText: "Arrear Charges",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(3),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  //
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 0.3,
                  //   height: MediaQuery.of(context).size.height / 16,
                  //   child: TextField(
                  //     controller: _serverChargesController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       labelText: "Server Charges",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(3),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 0.3,
                  //   height: MediaQuery.of(context).size.height / 16,
                  //   child: TextField(
                  //     controller: _smsChargesController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       labelText: "SMS Charges",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(3),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 0.3,
                  //   height: MediaQuery.of(context).size.height / 16,
                  //   child: TextField(
                  //     controller: _posChargesController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       labelText: "POS Charges",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(3),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 0.3,
                  //   height: MediaQuery.of(context).size.height / 16,
                  //   child: TextField(
                  //     controller: _monthlyChargesController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       labelText: "Monthly Charges",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(3),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 0.3,
                  //   height: MediaQuery.of(context).size.height / 16,
                  //   child: TextField(
                  //     controller: _advanceChargesController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       labelText: "Advance Charges",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(3),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 0.3,
                  //   height: MediaQuery.of(context).size.height / 16,
                  //   child: TextField(
                  //     controller: _otherChargesController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       labelText: "Other Charges",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(3),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width / 0.3,
                    height: MediaQuery.of(context).size.height / 16,
                    child: TextField(
                      controller: _totalChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Total Charges",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 0.3,
                    height: MediaQuery.of(context).size.height / 16,
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
                      items: widget.getActiveBankList.map((collector) {
                        return DropdownMenuItem<String>(
                          value: collector.tbnkid ?? '',
                          child: Text(collector.tbnkdsc ?? ''),
                        );
                      }).toList() ??
                          [],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 0.3,
                    height: MediaQuery.of(context).size.height / 16,
                    child: TextField(
                      controller: _billDescriptionController,
                      decoration: InputDecoration(
                        labelText: "Bill Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 0.3,
                    height: MediaQuery.of(context).size.height / 16,
                    // Set the height
                    child: ElevatedButton(
                      onPressed: () {
                        post_addCollection();
                        Cosmos.waitingDialog(context, '         Please Wait');
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  // void _updateTotalCharges() {
  //   double arrearCharges = double.tryParse(_arrearChargesController.text) ?? 0;
  //   double serverCharges = double.tryParse(_serverChargesController.text) ?? 0;
  //   double monthlyCharges = double.tryParse(_monthlyChargesController.text) ?? 0;
  //   double posCharges = double.tryParse(_posChargesController.text) ?? 0;
  //   double smsCharges = double.tryParse(_smsChargesController.text) ?? 0;
  //   double advanceCharges = double.tryParse(_advanceChargesController.text) ?? 0;
  //   double otherCharges = double.tryParse(_otherChargesController.text) ?? 0;
  //
  //   double totalCharges = arrearCharges + serverCharges + monthlyCharges + posCharges + smsCharges + advanceCharges + otherCharges;
  //
  //   setState(() {
  //     _totalChargesController.text = totalCharges.toStringAsFixed(2);
  //   });
  // }

  setCustomerData(){
    _nameController.text = widget.getActiveCustomersModel.tCstDsc.toString() ?? '';
    // _serverChargesController.text = widget.getBillList.serverChg.toString() ?? '';
    // _smsChargesController.text = widget.getBillList.sMSChg.toString() ?? '';
    // _posChargesController.text = widget.getBillList.pSOChg.toString() ?? '';
    // _advanceChargesController.text = widget.getBillList.advacneChg.toString() ?? '';
    // _monthlyChargesController.text = widget.getBillList.monthlyChg.toString() ?? '';
    // _arrearChargesController.text = widget.getBillList.arrear.toString() ?? '';
    // _otherChargesController.text = widget.getBillList.otherChg.toString() ?? '';
  }

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
  void _showImageSourceDialog() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                _takePicture(ImageSource.camera);
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
                _takePicture(ImageSource.gallery);
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

  void _takePicture(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // void _takePicture() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }


  Future post_addCollection() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(addCollection));
    request.fields['FTrnDat'] = selectedDate.toString();
    request.fields['FRefId'] = selectBank.toString();
    request.fields['FCstId'] = widget.getActiveCustomersModel.tcstid.toString();
    request.fields['FTrnDsc'] = _billDescriptionController.text;
    // request.fields['FArrChg'] = _arrearChargesController.text.isEmpty? '0.00': _arrearChargesController.text;
    // request.fields['FSrvChg'] = _serverChargesController.text;
    // request.fields['FMthChg'] = _monthlyChargesController.text;
    // request.fields['FSmsChg'] = _smsChargesController.text;
    // request.fields['FPosChg'] = _posChargesController.text;
    // request.fields['FOthChg'] = _otherChargesController.text.isEmpty ? '0.00' : _otherChargesController.text;
    // request.fields['FAdvChg'] = _advanceChargesController.text;
    request.fields['FTrnTot'] = _totalChargesController.text;
    if (_image != null) {
    var picture = await http.MultipartFile.fromPath('FColImg', _image!.path);
    request.files.add(picture);
    };
    final response = await http.Response.fromStream(await request.send());

    var result = jsonDecode(response.body.toString());


    if (result["error"] == 200) {
      print(result["message"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print(result["error"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
    }
  }
}
