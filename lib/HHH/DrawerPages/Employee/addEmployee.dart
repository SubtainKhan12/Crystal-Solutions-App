import 'dart:convert';
import 'dart:io';
import 'package:crystal_solutions/Model/Designation/GetDesignationModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../apis.dart';
import '../../../cosmos.dart';

class AddEmployee extends StatefulWidget {
  List<GetDesignationModel> getDesignationList = [];

  AddEmployee({super.key, required this.getDesignationList});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _cnicController = TextEditingController();
  TextEditingController _bankAccountController = TextEditingController();
  TextEditingController _bankAccountNumber = TextEditingController();
  TextEditingController _posChargesController = TextEditingController();
  TextEditingController _accountTitleController = TextEditingController();

  // String? status;
  String? designationIdDropDown;

  // String? SelectedCollector;
  // String? SelectedReference;
  // String? SelectedType;
  File? _image;

  // String? dropDown_selectArea;
  // String? dropDown_collector;
  // String? dropDown_package;

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

  String? validateCNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid CNIC';
    }
    if (!RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(value)) {
      return 'Invalid CNIC format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Employee',
          style: TextStyle(color: Cosmic.white_color),
        ),
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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Image.asset(
                    'assets/Crystal-Solutions-logo-removebg-preview.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   "Fill the Fields",
                      //   style: TextStyle(fontSize: 25),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 100,
                      //       width: 100,
                      //       decoration: BoxDecoration(
                      //           border: Border.all(color: Colors.black),
                      //           borderRadius: BorderRadius.circular(8)),
                      //       // child: _image == null
                      //       //     ? Image.network(
                      //       //   "https://crystalsolutions.com.pk/khan_j/itemimage//${widget.itemModel.tItmPic.toString()}",
                      //       //   fit: BoxFit.fill,
                      //       // )
                      //       //     : Image.file(
                      //       //   _image!,
                      //       //   fit: BoxFit.cover,
                      //       // )
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     InkWell(
                      //       onTap: _takePicture,
                      //       child: Container(
                      //         height: 100,
                      //         width: 100,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           border: Border.all(color: Colors.black),
                      //         ),
                      //         child: const Icon(
                      //           Icons.add,
                      //           color: Colors.red,
                      //           size: 45,
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
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
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _fatherNameController,
                          decoration: InputDecoration(
                            labelText: "Father Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          height: _height / 14,
                          width: _width / 0.3,
                        ),
                        child: TextFormField(
                          maxLength: 11,
                          controller: _mobileController,
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
                        height: _height / 16,
                        width: _width / 0.3,
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
                        height: 5,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
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
                        height: 5,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          height: _height / 14,
                          width: _width / 0.3,
                        ),
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
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextFormField(
                          maxLength: 15,
                          controller: _cnicController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.length == 5 || value.length == 13) {
                              _cnicController.text = value + '-';
                              _cnicController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: _cnicController.text.length));
                            } else if (value.length == 6 ||
                                value.length == 14) {
                              if (value.endsWith('-')) {
                                _cnicController.text =
                                    value.substring(0, value.length - 1);
                                _cnicController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _cnicController.text.length));
                              }
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "CNIC",
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          validator: validateCNIC,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextFormField(
                          controller: _bankAccountController,
                          decoration: InputDecoration(
                            labelText: "Bank Name",
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
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _bankAccountNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Bank Account Number",
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
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _salaryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Salary",
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
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _accountTitleController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Account Title",
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
                        height: _height / 16,
                        width: _width / 0.3,
                        child: DropdownButtonFormField<String>(
                          value: designationIdDropDown,
                          onChanged: (newValue) {
                            setState(() {
                              designationIdDropDown = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Designation",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          items: widget.getDesignationList.map((city) {
                                return DropdownMenuItem<String>(
                                  value: city.tdsgid ?? '',
                                  child: Text(city.tdsgdsc ?? ''),
                                );
                              }).toList() ??
                            [],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: _height / 16,
                        width: _width / 0.3, // Set the height
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Cosmos.waitingDialog(
                                  context, "       Please Wait");
                              post_addEmployee();
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
          ),
        ],
      ),
    );
  }

  ///-------------------> Image Picker Function <------------------///
  void _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Future post_addCust() async {
  //   var request = http.MultipartRequest('POST',
  //       Uri.parse(addCust));
  //   request.fields['FColId'] = _collectorController.text.toString();
  //   request.fields['FCstDsc'] = _description.text.toString();
  //   request.fields['FCstSts'] = 'Yes';
  //   request.fields['FCntPer'] = _nameController.text.toString();
  //   request.fields['FPhnNum'] = _phoneController.toString();
  //   request.fields['FMobNum'] = _mobileController.text.toString();
  //   request.fields['FAdd001'] = _address1Controller.text.toString();
  //   request.fields['FAdd002'] = _address2Controller.text.toString();
  //   request.fields['FEmlAdd'] = _emailController.text.toString();
  //   request.fields['FShpNum'] = _shopController.text.toString();
  //   request.fields['FMthChg'] = _monthlyChargesController.text.toString();
  //   request.fields['FRefId'] = reference.toString();
  //   request.fields['FTypId'] = _typeController.text.toString();
  //   request.fields['FCtyId'] = _cityController.text.toString();
  //   request.fields['FLatVal'] = _latitudeController.text.toString();
  //   request.fields['FLngVal'] = _longitudeController.text.toString();
  //   request.fields['FSrvIp'] = _ipController.text.toString();
  //
  //   // if (_image != null) {
  //   //   var picture = await http.MultipartFile.fromPath('pic', _image!.path);
  //   //   request.files.add(picture);
  //   // }
  //
  //   final response = await http.Response.fromStream(await request.send());
  //
  //   var result = jsonDecode(response.body.toString());
  //
  //
  //   if (result["error"] == 200) {
  //     print(result["message"]);
  //     Cosmos.snackBarToast(context, result["message"], 'ok', 2);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //   } else {
  //     print(result["error"]);
  //     Cosmos.snackBarToast(context, result["message"], 'ok', 2);
  //   }
  // }
  Future post_addEmployee() async {
    var response = await http.post(Uri.parse(addEmployee), body: {
      'FEmpNam': _nameController.text,
      'FEmpSts': 'Yes',
      'FFthNam': _fatherNameController.text,
      'FMobNum': _mobileController.text,
      'FAdd001': _address1Controller.text,
      'FAdd002': _address2Controller.text,
      'FEmlAdd': _emailController.text,
      'FNicNum': _cnicController.text,
      'FBnkNam': _bankAccountController.text,
      'FBnkAcc':
          _bankAccountNumber.text.isEmpty ? '0' : _bankAccountNumber.text,
      'FEmpSal': _salaryController.text.isEmpty ? '0' : _salaryController.text,
      'FDsgId': designationIdDropDown.toString(),
      'FAccTtl': _accountTitleController.text,
    });
    var result = jsonDecode(response.body);
    if (result['error'] == 200) {
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: result['message']);
      print(result['message']);
      Navigator.pop(context);
    }
  }
}
