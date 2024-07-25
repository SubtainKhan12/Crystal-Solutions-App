import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../apis.dart';

class AddCollectors extends StatefulWidget {
  const AddCollectors({super.key});

  @override
  State<AddCollectors> createState() => _AddCollectorsState();
}

class _AddCollectorsState extends State<AddCollectors> {

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
  // String? status;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Collectors',style: TextStyle(color: Cosmic.white_color),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Cosmic.white_color),
        backgroundColor: Cosmic.app_color,
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
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Fill out the form bellow to add the\n new collector',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 0.3,
                      height: MediaQuery.of(context).size.height / 16,
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
                      height: 5,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 14,),
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
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    Container(
                      width: MediaQuery.of(context).size.width / 0.3,
                      height: MediaQuery.of(context).size.height / 16,
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
                      width: MediaQuery.of(context).size.width / 0.3,
                      height: MediaQuery.of(context).size.height / 16,
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
                      constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 14,),
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
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 0.3,
                      height: MediaQuery.of(context).size.height / 16,
                      // Set the height
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Cosmos.waitingDialog(context, "       Please Wait");
                            post_addCol();
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
    );
  }
  Future post_addCol()async{
    var response = await http.post(Uri.parse(addCol),body: {
      'FColDsc': _description.text,
      'FColSts': 'Yes',
      'FAdd001': _address1Controller.text,
      'FAdd002': _address2Controller.text,
      'FMobNum': _phoneController.text,
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
