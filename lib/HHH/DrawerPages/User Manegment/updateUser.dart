import 'dart:convert';
import 'package:crystal_solutions/Model/Users/GetUsersModel.dart';
import 'package:http/http.dart'as http;
import 'package:crystal_solutions/apis.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../cosmos.dart';

class UpdateUserScreen extends StatefulWidget {
   GetUsersModel getUsersModel ;
   UpdateUserScreen({super.key, required this.getUsersModel});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _loginIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String? type;
  String? status = 'Yes';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update User',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: "Mobile No",
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: validateMobile,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  readOnly: true,
                  controller: _loginIdController,
                  decoration: InputDecoration(
                    labelText: "Login Id",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButtonFormField<String>(
                  value: type,
                  onChanged: (newValue) {
                    setState(() {
                      type = newValue;
                    });
                  },
                  items: <String>['Office', 'Ghauri']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding here
                          onChanged: (String? value) {
                            setState(() {
                              status = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('No'),
                          value: 'No',
                          groupValue: status,
                          contentPadding: EdgeInsets.symmetric(horizontal: -20), // Adjust padding here
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
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity, // Set the width
                  height: 60, // Set the height
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Cosmos.waitingDialog(context, 'Please Wait        ');
                        post_UpdateUser();
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setUserData(){
    _nameController.text = widget.getUsersModel.tUsrNam ?? '';
    _mobileController.text = widget.getUsersModel.tMobNum ?? '';
    _loginIdController.text = widget.getUsersModel.tusrId ?? '';
    _passwordController.text = widget.getUsersModel.tUsrPwd ?? '';
    _emailController.text = widget.getUsersModel.tUsrEml ?? '';
    status = widget.getUsersModel.tUsrSts ?? '';
    type = widget.getUsersModel.tusrTyp ?? '';
  }
  Future post_UpdateUser() async {
    var response = await http.post(Uri.parse(updateUser), body: {
      'FUsrId': _loginIdController.text,
      'FUsrPwd': _passwordController.text,
      'FUsrSts': status.toString(),
      'FUsrEml': _emailController.text,
      'FMobNum': _mobileController.text,
      'FUsrTyp': type.toString(),
      'FUsrNam': _nameController.text,
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
