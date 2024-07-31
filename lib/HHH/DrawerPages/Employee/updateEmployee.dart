import 'dart:convert';
import 'dart:io';
import 'package:crystal_solutions/Model/Employe/GetEmployeeModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/Designation/GetActiveDesignationModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class UpdateEmployee extends StatefulWidget {
  GetEmployeeModel getEmployeeList;
  List<GetActiveDesignationModel> getActiveDesignationList = [];

  UpdateEmployee(
      {super.key,
      required this.getActiveDesignationList,
      required this.getEmployeeList});

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
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

  String? status;
  String? designationIdDropDown;
  File? _frontCnic;
  File? backCnic;
  File? _cvPic;

  // String? SelectedCollector;
  // String? SelectedReference;
  // String? SelectedType;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    setEmployeData();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Employee',
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
                          items: widget.getActiveDesignationList.map((city) {
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: -20),
                                // Adjust padding here
                                onChanged: (String? value) {
                                  setState(() {
                                    status = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text(
                                  'No',
                                ),
                                value: 'No',
                                groupValue: status,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: -20),
                                // Adjust padding here
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
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: _showDialogeForFrontCnic,
                              child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: _frontCnic == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            "https://crystalsolutions.com.pk/csnew/employeeimg//${widget.getEmployeeList.tnicfnt.toString()}",
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            _frontCnic!,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                            ),
                            InkWell(
                              onTap: _showDialogeForBackCnic,
                              child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: backCnic == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            "https://crystalsolutions.com.pk/csnew/employeeimg//${widget.getEmployeeList.tnicbak.toString()}",
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            backCnic!,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: _showDialogeForCv,
                        child: Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8)),
                            child: _cvPic == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      "https://crystalsolutions.com.pk/csnew/employeeimg//${widget.getEmployeeList.tcvpic.toString()}",
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      _cvPic!,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: _height / 16,
                        width: _width / 0.3, // Set the height
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Cosmos.waitingDialog(
                                  context, "       Please Wait");
                              post_updateEmployee();
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

  setEmployeData() {
    _nameController.text = widget.getEmployeeList.tempnam.toString() ?? '';
    _fatherNameController.text =
        widget.getEmployeeList.tfthnam.toString() ?? '';
    _mobileController.text = widget.getEmployeeList.tmobnum.toString() ?? '';
    _address1Controller.text = widget.getEmployeeList.tadd001.toString() ?? '';
    _address2Controller.text = widget.getEmployeeList.tadd002.toString() ?? '';
    _emailController.text = widget.getEmployeeList.temladd.toString() ?? '';
    _cnicController.text = widget.getEmployeeList.tnicnum.toString() ?? '';
    _bankAccountController.text =
        widget.getEmployeeList.tbnknam.toString() ?? '';
    _bankAccountNumber.text = widget.getEmployeeList.tbnkacc.toString() ?? '';
    _salaryController.text = widget.getEmployeeList.tempsal.toString() ?? '';
    _accountTitleController.text =
        widget.getEmployeeList.taccttl.toString() ?? '';
    designationIdDropDown = widget.getEmployeeList.tdsgid.toString() ?? '';
    status = widget.getEmployeeList.tempsts.toString() ?? '';
  }

  ///-------------------> Image Picker Function <------------------///
  void FrontCnic() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _frontCnic = File(pickedFile.path);
      });
    }
  }

  void BackCnic() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        backCnic = File(pickedFile.path);
      });
    }
  }

  void CvImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _cvPic = File(pickedFile.path);
      });
    }
  }

  void FrontCnicFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _frontCnic = File(pickedFile.path);
      });
    }
  }

  void BackCnicFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        backCnic = File(pickedFile.path);
      });
    }
  }

  void CvImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _cvPic = File(pickedFile.path);
      });
    }
  }

  Future<void> _showDialogeForFrontCnic() async {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone,
                  size: _height * 0.04, color: Color(0xff06D001)),
              onPressed: () {
                FrontCnicFromCamera();
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                FrontCnic();
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/whatsapplogo.png'),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _showDialogeForBackCnic() async {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone,
                  size: _height * 0.04, color: Color(0xff06D001)),
              onPressed: () {
                BackCnicFromCamera();
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                BackCnic();
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/whatsapplogo.png'),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _showDialogeForCv() async {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone,
                  size: _height * 0.04, color: Color(0xff06D001)),
              onPressed: () {
                CvImageFromCamera();
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                CvImage();
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/whatsapplogo.png'),
              ),
            )
          ],
        );
      },
    );
  }

  Future post_updateEmployee() async {
    var request = http.MultipartRequest('POST', Uri.parse(updateEmployee));
    request.fields['FEmpId'] = widget.getEmployeeList.tempid.toString();
    request.fields['FEmpNam'] = _nameController.text;
    request.fields['FEmpSts'] = status.toString();
    request.fields['FFthNam'] = _fatherNameController.text.toString();
    request.fields['FMobNum'] = _mobileController.text.toString();
    request.fields['FAdd001'] = _address1Controller.text.toString();
    request.fields['FAdd002'] = _address2Controller.text.toString();
    request.fields['FEmlAdd'] = _emailController.text.toString();
    request.fields['FNicNum'] = _cnicController.text.toString();
    request.fields['FBnkNam'] = _bankAccountController.text.toString();
    request.fields['FBnkAcc'] = _bankAccountNumber.text.toString();
    request.fields['FEmpSal'] = _salaryController.text.toString();
    request.fields['FDsgId'] = designationIdDropDown.toString();
    request.fields['FAccTtl'] = _accountTitleController.text.toString();
    request.fields['CnicFrontName'] = widget.getEmployeeList.tnicfnt.toString();
    request.fields['CnicBackName'] = widget.getEmployeeList.tnicbak.toString();
    request.fields['CvName'] = widget.getEmployeeList.tcvpic.toString();

    if (_frontCnic != null) {
      var picture1 =
          await http.MultipartFile.fromPath('FCFront', _frontCnic!.path);
      request.files.add(picture1);
    }
    if (backCnic != null) {
      var picture2 = await http.MultipartFile.fromPath('FCBack', backCnic!.path);
      request.files.add(picture2);
    }
    if (_cvPic != null) {
      var picture3 = await http.MultipartFile.fromPath('FEmpCv', _cvPic!.path);
      request.files.add(picture3);
    }

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
    }
  }
// Future post_updateEmployee() async {
//   var response = await http.post(Uri.parse(updateEmployee), body: {
//     'FEmpId': widget.getEmployeeList.tempid.toString(),
//     'FEmpNam': _nameController.text,
//     'FEmpSts': status.toString(),
//     'FFthNam': _fatherNameController.text,
//     'FMobNum': _mobileController.text,
//     'FAdd001': _address1Controller.text,
//     'FAdd002': _address2Controller.text,
//     'FEmlAdd': _emailController.text,
//     'FNicNum': _cnicController.text,
//     'FBnkNam': _bankAccountController.text,
//     'FBnkAcc': _bankAccountNumber.text.isEmpty ? '0' : _bankAccountNumber.text,
//     'FEmpSal': _salaryController.text.isEmpty ? '0' : _salaryController.text,
//     'FDsgId': designationIdDropDown.toString(),
//     'FAccTtl': _accountTitleController.text,
//   });
//   var result = jsonDecode(response.body);
//   if (result['error'] == 200) {
//     Fluttertoast.showToast(msg: result['message']);
//     Navigator.pop(context);
//     Navigator.pop(context);
//   } else {
//     Fluttertoast.showToast(msg: result['message']);
//     print(result['message']);
//     Navigator.pop(context);
//   }
// }
}
