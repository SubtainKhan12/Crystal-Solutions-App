import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crystal_solutions/Model/Collectors/GetCollectorsModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../apis.dart';
import '../../../cosmos.dart';

class UpdateCollector extends StatefulWidget {
  GetCollectorsModel getCollectorsModel;

  UpdateCollector({super.key, required this.getCollectorsModel});

  @override
  State<UpdateCollector> createState() => _UpdateCollectorState();
}

class _UpdateCollectorState extends State<UpdateCollector> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _description = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid mobile number';
    }
    if (!RegExp(r'^03[0-9]{2}[0-9]{7}$').hasMatch(value)) {
      return 'Invalid mobile number format';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid email';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCollectorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Collectors',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Cosmic.white_color),
        backgroundColor: Cosmic.app_color,
      ),
      body: SingleChildScrollView(
        child: Stack(
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
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Fill out the form bellow to Update\n the  collector',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 17,
                        child: TextField(
                          controller: _description,
                          decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 12,),
                        child: TextFormField(
                          maxLength: 11,
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Mobile",
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          validator: validateMobile,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 17,
                        child: TextField(
                          controller: _address1Controller,
                          decoration: InputDecoration(
                            labelText: "Address 1",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 17,
                        child: TextField(
                          controller: _address2Controller,
                          decoration: InputDecoration(
                            labelText: "Address 2",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 12,),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          validator: validateEmail,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          children: [
                            const Text(
                              'Status:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Yes'),
                                value: 'Yes',
                                groupValue: status,
                                contentPadding: EdgeInsets.symmetric(horizontal: -20), // Adjust padding here
                                onChanged: (String? value) {
                                  setState(() {
                                    status = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('No',),
                                value: 'No',
                                groupValue: status,
                                contentPadding: const EdgeInsets.symmetric(horizontal: -20), // Adjust padding here
                                onChanged: (String? value) {
                                  setState(() {
                                    status = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 17,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Cosmos.waitingDialog(context, "       Please Wait");
                              post_updateCol();
                            }
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
            ),
          ],
        ),
      ),
    );
  }

  setCollectorData() {
    _description.text = widget.getCollectorsModel.tcoldsc.toString() ?? '';
    _phoneController.text = widget.getCollectorsModel.tmobnum.toString() ?? '';
    _address1Controller.text =
        widget.getCollectorsModel.tadd002.toString() ?? '';
    _address2Controller.text =
        widget.getCollectorsModel.tadd001.toString() ?? '';
    _emailController.text = widget.getCollectorsModel.temladd.toString() ?? '';
    status = widget.getCollectorsModel.tcolsts.toString() ?? '';
  }

  Future post_updateCol() async {
    var response = await http.post(Uri.parse(updateCol), body: {
      'FColId': widget.getCollectorsModel.tcolid.toString(),
      'FColDsc': _description.text,
      'FColSts': status.toString(),
      'FAdd001': _address1Controller.text,
      'FAdd002': _address2Controller.text,
      'FMobNum': _phoneController.text,
      'FEmlAdd': _emailController.text,
    });
    var result = jsonDecode(response.body);
    if (result['error'] == 200) {
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
    }
  }
}
