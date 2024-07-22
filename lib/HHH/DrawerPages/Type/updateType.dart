import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:crystal_solutions/Model/Type/GetType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../apis.dart';
import '../../../cosmos.dart';

class UpdateTypeScreen extends StatefulWidget {
  GetType getTypeList;
   UpdateTypeScreen({super.key, required this.getTypeList});

  @override
  State<UpdateTypeScreen> createState() => _UpdateTypeScreenState();
}

class _UpdateTypeScreenState extends State<UpdateTypeScreen> {
  TextEditingController _descriptionController = TextEditingController();
  String? status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTypeData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Type',
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
                  Cosmos.waitingDialog(context, 'Please Wait          ');
                  post_updateType();
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
  setTypeData(){
    _descriptionController.text = widget.getTypeList.ttypdsc.toString() ??'';
    status = widget.getTypeList.ttypsts.toString() ??'';
  }
  Future post_updateType()async{
    var response = await http.post(Uri.parse(updateType),body: {
      'FTypId': widget.getTypeList.ttypid.toString(),
      'FTypDsc': _descriptionController.text,
      'FTypSts': status.toString(),

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

