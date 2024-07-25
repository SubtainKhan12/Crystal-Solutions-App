import 'dart:convert';

import 'package:crystal_solutions/Model/Reference/GetReferenceModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import '../../../apis.dart';
import '../../../cosmos.dart';

class UpdateReferenceScreen extends StatefulWidget {
  GetReferenceModel getReferenceList;
   UpdateReferenceScreen({super.key, required this.getReferenceList});

  @override
  State<UpdateReferenceScreen> createState() => _UpdateReferenceScreenState();
}

class _UpdateReferenceScreenState extends State<UpdateReferenceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String? status;
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
    setRefData();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Reference',
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
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: _height / 16,
                      width: _width / 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: "Description",
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
                      constraints: BoxConstraints.tightFor(height: _height / 14,width: _width / 0.3),
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
                      width: _width / 0.3, // Set the width
                      height: _height / 16, // Set the height
                      child: ElevatedButton(
                        onPressed: () {

                          if (_formKey.currentState!.validate()) {
                            Cosmos.waitingDialog(context, 'Please Wait        ');
                            post_updateReference();
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
        ],
      ),
    );
  }
  setRefData(){
    _descriptionController.text = widget.getReferenceList.trefdsc.toString() ?? '';
    _emailController.text = widget.getReferenceList.temladd.toString() ?? '';
    status = widget.getReferenceList.trefsts.toString() ?? '';
  }
  Future post_updateReference()async{
    var response = await http.post(Uri.parse(updateRef),body: {
      'FRefId': widget.getReferenceList.trefid.toString(),
      'FRefDsc': _descriptionController.text,
      'FRefSts': status.toString(),
      'FEmlAdd': _emailController.text,
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

