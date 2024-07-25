import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../apis.dart';
import '../../../cosmos.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _loginIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String? status, type;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User',
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
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                child: Image.asset('assets/Crystal-Solutions-logo-removebg-preview.png'),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text('Fill out the form bellow to create a \nnew user',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                      SizedBox(height: 15,),
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
                      // SizedBox(height: 5,),
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
                              post_addUser();
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      // SizedBox(height: 10,),
                      // RichText(text: TextSpan(
                      //     children: [
                      //       TextSpan(text: 'Your ',style: TextStyle(color: Colors.black)),
                      //       TextSpan(text: 'Privacy ',style: TextStyle(color: Colors.blue)),
                      //       TextSpan(text: 'is assured.',style: TextStyle(color: Colors.black)),
                      //     ]
                      // )),
                      // SizedBox(height: 25,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text("-------------------------> "),
                      //     Container(
                      //
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(100),
                      //           border: Border.all(color: Colors.black)
                      //       ),
                      //       child: CircleAvatar(
                      //         backgroundColor: Cosmic.white_color,
                      //         child: Text('OR'),
                      //       ),
                      //     ),
                      //     Text(' <-------------------------')
                      //   ],
                      // ),
                      // RichText(text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: 'Prefer to Talk a real,live person? \n',style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w500),
                      //       ),
                      //       TextSpan(
                      //         text: 'Give us a call for any problem.\n',style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w500),
                      //       ),
                      //       TextSpan(
                      //         text: '+92 42 35184077-8',style: TextStyle(color: Colors.deepOrange, fontSize: 20,fontWeight: FontWeight.bold),
                      //       ),
                      //     ]
                      // )),
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

  Future post_addUser() async {
    var response = await http.post(Uri.parse(addUser), body: {
      'FUsrId': _loginIdController.text,
      'FUsrPwd': _passwordController.text,
      'FUsrSts': 'Yes',
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
