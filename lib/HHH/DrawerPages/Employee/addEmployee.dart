import 'dart:convert';
import 'dart:io';
import 'package:crystal_solutions/Model/Designation/GetDesignationModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/Designation/GetActiveDesignationModel.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class AddEmployee extends StatefulWidget {
  List<GetActiveDesignationModel> getActiveDesignationList = [];

  AddEmployee({super.key, required this.getActiveDesignationList});

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
  File? _frontCnic;
  File? backCnic;
  File? _cvPic;

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
                                    ? Center(
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        child: Image.asset(
                                          'assets/fronCnic.jpg',
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )))
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(
                                    _frontCnic!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: _showDialogeForBackCnic,
                              child: Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: backCnic == null
                                    ? Center(
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        child: Image.asset(
                                          'assets/backCnic.jpg',
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )))
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(
                                    backCnic!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
                              borderRadius: BorderRadius.circular(5)),
                          child: _cvPic == null
                              ?  Center(child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Text("")))
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(5),

                            child: Image.file(
                              _cvPic!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
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
            InkWell(
              onTap: (){
                FrontCnicFromCamera();
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/camera.png'),
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: (){
                FrontCnic();
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
  Future<void> _showDialogeForBackCnic() async {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            InkWell(
              onTap: (){
                BackCnicFromCamera();
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/camera.png'),
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: (){
                BackCnic();
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
  Future<void> _showDialogeForCv() async {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            InkWell(
              onTap: (){
                CvImageFromCamera();
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/camera.png'),
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: (){
                CvImage();
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



  Future post_addEmployee() async {
    var request = http.MultipartRequest('POST', Uri.parse(addEmployee));
    request.fields['FEmpNam'] = _nameController.text;
    request.fields['FEmpSts'] = 'Yes';
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

    if (_frontCnic != null) {
      var picture =
          await http.MultipartFile.fromPath('FCFront', _frontCnic!.path);
      request.files.add(picture);
    }
    if (backCnic != null) {
      var picture = await http.MultipartFile.fromPath('FCBack', backCnic!.path);
      request.files.add(picture);
    }
    if (_cvPic != null) {
      var picture = await http.MultipartFile.fromPath('FEmpCv', _cvPic!.path);
      request.files.add(picture);
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
}
