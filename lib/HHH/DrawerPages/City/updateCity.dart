import 'dart:convert';

import 'package:crystal_solutions/Model/City/GetCityModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';
import 'package:http/http.dart'as http;

class UpdateCityScreen extends StatefulWidget {
  GetCityModel getCityList;
   UpdateCityScreen({super.key, required this.getCityList});

  @override
  State<UpdateCityScreen> createState() => _UpdateCityScreenState();
}

class _UpdateCityScreenState extends State<UpdateCityScreen> {
  TextEditingController _descriptionController = TextEditingController();
  String? status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCityData();
  }
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add City',
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
                    height: _height / 17,
                    width: _width / 1.5,
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
                    height: 15,
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
                    width: _width / 1.5, // Set the width
                    height: _height / 17, // Set the height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {

                        Cosmos.waitingDialog(context, 'Please Wait        ');
                        post_UpdateCity();

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
  setCityData(){
    _descriptionController.text = widget.getCityList.tctydsc.toString() ?? '';
    status = widget.getCityList.tctysts.toString() ?? '';
  }
  Future post_UpdateCity()async{
    var response = await http.post(Uri.parse(updateCity),body: {
      'FCtyId': widget.getCityList.tctyid.toString(),
      'FCtyDsc': _descriptionController.text,
      'FCtySts': status.toString(),
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
