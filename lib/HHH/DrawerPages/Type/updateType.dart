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
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
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
                  SizedBox(
                    width: _width / 0.3, // Set the width
                    height: _height / 16, // Set the height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {

                        Cosmos.waitingDialog(context, 'Please Wait        ');
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
          ),
        ],
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

