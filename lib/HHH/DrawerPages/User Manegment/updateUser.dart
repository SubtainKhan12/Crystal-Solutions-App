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
  String? status;

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text('Fill out the form bellow to Update    \n the user',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                      // SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16,
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
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 0.3,
                          height: MediaQuery.of(context).size.height / 14,),
                        child: TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          decoration: InputDecoration(
                            labelText: "Mobile No",
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          validator: validateMobile,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 0.3,
                          height: MediaQuery.of(context).size.height / 14,),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          validator: validateEmail,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16,
                        child: TextField(
                          controller: _loginIdController,
                          decoration: InputDecoration(
                            labelText: "Login Id",
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
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
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
                          value: type,
                          onChanged: (newValue) {
                            setState(() {
                              type = newValue;
                            });
                          },
                          items: <String>['Admin', 'Office', 'Collector', 'User']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: "Type",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
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
                      // DropdownButtonFormField<String>(
                      //   value: status,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       status = newValue;
                      //     });
                      //   },
                      //   items: <String>['Yes', 'No']
                      //       .map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     labelText: "Status",
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16, // Set the height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Cosmos.waitingDialog(context, 'Please Wait        ');
                              post_UpdateUser();
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
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
