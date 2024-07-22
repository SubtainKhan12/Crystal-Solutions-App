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
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String? status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setRefData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Reference',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField<String>(
              value: status,
              onChanged: (newValue) {
                setState(() {
                  status = newValue;
                });
              },
              items: <String>['Yes', 'No']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity, // Set the width
              height: 60, // Set the height
              child: ElevatedButton(
                onPressed: () {
                  Cosmos.waitingDialog(context, 'Please Wait        ');
                  post_updateReference();
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

