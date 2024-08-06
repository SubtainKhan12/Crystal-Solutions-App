import 'dart:convert';

import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../apis.dart';

class AddBillUI extends StatefulWidget {
  GetActiveCustomersModel getActiveCustomersList;
  AddBillUI({super.key,required this.getActiveCustomersList});

  @override
  State<AddBillUI> createState() => _AddBillUIState();
}

class _AddBillUIState extends State<AddBillUI> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomerData();
    _updateTotalCharges();

    // Add listeners to update total charges
    _arrearChargesController.addListener(_updateTotalCharges);
    _serverChargesController.addListener(_updateTotalCharges);
    _monthlyChargesController.addListener(_updateTotalCharges);
    _posChargesController.addListener(_updateTotalCharges);
    _smsChargesController.addListener(_updateTotalCharges);
    _advanceChargesController.addListener(_updateTotalCharges);
    _otherChargesController.addListener(_updateTotalCharges);
  }
  @override
  void dispose() {
    // Remove listeners to prevent memory leaks
    _arrearChargesController.removeListener(_updateTotalCharges);
    _serverChargesController.removeListener(_updateTotalCharges);
    _monthlyChargesController.removeListener(_updateTotalCharges);
    _posChargesController.removeListener(_updateTotalCharges);
    _smsChargesController.removeListener(_updateTotalCharges);
    _advanceChargesController.removeListener(_updateTotalCharges);
    _otherChargesController.removeListener(_updateTotalCharges);

    _arrearChargesController.dispose();
    _serverChargesController.dispose();
    _monthlyChargesController.dispose();
    _posChargesController.dispose();
    _smsChargesController.dispose();
    _advanceChargesController.dispose();
    _otherChargesController.dispose();
    _totalChargesController.dispose();
    _billDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Bill Generation',style: TextStyle(color: Cosmic.white_color),),
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
                  Container(
                    width: MediaQuery.of(context).size.width / 0.3,
                    height: MediaQuery.of(context).size.height / 16,
                    child: TextField(
                      controller: _arrearChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Arrear Charges",
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
                    child: TextField(
                      controller: _serverChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Server Charges",
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
                    child: TextField(
                      controller: _smsChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "SMS Charges",
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
                    child: TextField(
                      controller: _posChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "POS Charges",
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
                    child: TextField(
                      controller: _monthlyChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Monthly Charges",
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
                    child: TextField(
                      controller: _advanceChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Advance Charges",
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
                    child: TextField(
                      controller: _otherChargesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Other Charges",
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
                    child: TextField(
                      readOnly: true,
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
                        post_newBill();
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
  void _updateTotalCharges() {
    double arrearCharges = double.tryParse(_arrearChargesController.text) ?? 0;
    double serverCharges = double.tryParse(_serverChargesController.text) ?? 0;
    double monthlyCharges = double.tryParse(_monthlyChargesController.text) ?? 0;
    double posCharges = double.tryParse(_posChargesController.text) ?? 0;
    double smsCharges = double.tryParse(_smsChargesController.text) ?? 0;
    double advanceCharges = double.tryParse(_advanceChargesController.text) ?? 0;
    double otherCharges = double.tryParse(_otherChargesController.text) ?? 0;

    double totalCharges = arrearCharges + serverCharges + monthlyCharges + posCharges + smsCharges + advanceCharges + otherCharges;

    setState(() {
      _totalChargesController.text = totalCharges.toStringAsFixed(2);
    });
  }

  setCustomerData(){
    _nameController.text = widget.getActiveCustomersList.tCstDsc.toString() ?? '';
    _serverChargesController.text = widget.getActiveCustomersList.tsrvchg.toString() ?? '';
    _smsChargesController.text = widget.getActiveCustomersList.tsmschg.toString() ?? '';
    _posChargesController.text = widget.getActiveCustomersList.tposchg.toString() ?? '';
    _advanceChargesController.text = widget.getActiveCustomersList.tadvchg.toString() ?? '';
    _monthlyChargesController.text = widget.getActiveCustomersList.tmthChg.toString() ?? '';
    _arrearChargesController.text = widget.getActiveCustomersList.tarrchg.toString() ?? '';
    _otherChargesController.text = widget.getActiveCustomersList.tothchg.toString() ?? '';
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


  Future post_newBill()async{
    var response = await http.post(Uri.parse(addBill),body: {
      'FTrnDat': selectedDate.toString(),
      'FRefId': widget.getActiveCustomersList.tRefId.toString(),
      'FCstId': widget.getActiveCustomersList.tcstid.toString(),
      'FTrnDsc': _billDescriptionController.text,
      'FArrChg': _arrearChargesController.text.isEmpty? '0.00': _arrearChargesController.text,
      'FSrvChg': _serverChargesController.text,
      'FMthChg': _monthlyChargesController.text,
      'FSmsChg': _smsChargesController.text,
      'FPosChg': _posChargesController.text,
      'FOthChg': _otherChargesController.text.isEmpty ? '0.00' : _otherChargesController.text,
      'FAdvChg': _advanceChargesController.text,
      'FTrnTot': _totalChargesController.text,
    });
    var result = jsonDecode(response.body);
    if(result['error'] == 200){
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
    }
  }
}
