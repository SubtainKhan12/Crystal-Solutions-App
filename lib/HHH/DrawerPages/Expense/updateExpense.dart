import 'dart:convert';

import 'package:crystal_solutions/Model/Expense/GetExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import '../../../apis.dart';
import '../../../cosmos.dart';

class UpdateExpenseScreen extends StatefulWidget {
  GetExpenseModel getExpenseList;
   UpdateExpenseScreen({super.key, required this.getExpenseList});

  @override
  State<UpdateExpenseScreen> createState() => _UpdateExpenseScreenState();
}

class _UpdateExpenseScreenState extends State<UpdateExpenseScreen> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _monthlyBudgetController = TextEditingController();
  String? status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setExpenseData();
  }
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Expense',
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
                  Container(
                    height: _height / 16,
                    width: _width / 0.3,
                    child: TextField(
                      controller: _monthlyBudgetController,
                      decoration: InputDecoration(
                        labelText: "Monthly Budget",
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
                        post_updateExp();

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
  setExpenseData(){
    _descriptionController.text = widget.getExpenseList.texpdsc.toString() ?? '';
    _monthlyBudgetController.text = widget.getExpenseList.tmthbgt.toString() ?? '';
    status = widget.getExpenseList.texpsts.toString() ?? '';
  }
  Future post_updateExp()async{
    var response = await http.post(Uri.parse(updateExp),body: {
      'FExpId': widget.getExpenseList.texpid.toString(),
      'FExpDsc': _descriptionController.text,
      'FExpSts': status.toString(),
      'FMthBgt': _monthlyBudgetController.text

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
