import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../apis.dart';
import '../../../cosmos.dart';

class AddCustomers extends StatefulWidget {
  const AddCustomers({super.key});

  @override
  State<AddCustomers> createState() => _AddCustomersState();
}

class _AddCustomersState extends State<AddCustomers> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _description = TextEditingController();
  TextEditingController _cntPersonController = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _ipController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _monthlyChargesController = TextEditingController();
  TextEditingController _shopController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _collectorController = TextEditingController();

  String? reference, status;
  File? _image;

  // String? dropDown_selectArea;
  // String? dropDown_collector;
  // String? dropDown_package;

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
          'Add Customer',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Fill the Fields",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 100,
                //       width: 100,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black),
                //           borderRadius: BorderRadius.circular(8)),
                //       // child: _image == null
                //       //     ? Image.network(
                //       //   "https://crystalsolutions.com.pk/khan_j/itemimage//${widget.itemModel.tItmPic.toString()}",
                //       //   fit: BoxFit.fill,
                //       // )
                //       //     : Image.file(
                //       //   _image!,
                //       //   fit: BoxFit.cover,
                //       // )
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     InkWell(
                //       onTap: _takePicture,
                //       child: Container(
                //         height: 100,
                //         width: 100,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(color: Colors.black),
                //         ),
                //         child: const Icon(
                //           Icons.add,
                //           color: Colors.red,
                //           size: 45,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _description,
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
                  controller: _cntPersonController,
                  decoration: InputDecoration(
                    labelText: "Contact Person",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLength: 11,
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Mobile",
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
                  maxLength: 11,
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone",
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
                TextField(
                  controller: _address1Controller,
                  decoration: InputDecoration(
                    labelText: "Address 1",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _address2Controller,
                  decoration: InputDecoration(
                    labelText: "Address 2",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: _shopController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Shops",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _monthlyChargesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Monthly Charges",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 170,
                      child: TextField(
                        controller: _latitudeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Latitude",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: TextField(
                        controller: _longitudeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Longitude",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       height: 60,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(color: Colors.black54)
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //         child: DropdownButton<String>(
                //           value: dropDown_package,
                //           onChanged: (String? newValue) {
                //             setState(() {
                //               dropDown_package = newValue;
                //               if (newValue != null) {
                //                 updatePackageDetails(newValue);
                //               }
                //             });
                //           },
                //           items: [
                //             const DropdownMenuItem<String>(
                //               value: null,
                //               child: Text('Select Package'),
                //             ),
                //             ...allPackagesList
                //                 .map<DropdownMenuItem<String>>((category) {
                //               return DropdownMenuItem<String>(
                //                 value: category.id ?? '',
                //                 child: Text(category.pkDsc ?? ''),
                //               );
                //             }).toList(),
                //           ],
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 12,
                //     ),
                //     SizedBox(
                //       width: 155,
                //       child: TextField(
                //         maxLength: 4,
                //         controller: _speedController,
                //         keyboardType: TextInputType.number,
                //         decoration: InputDecoration(
                //           labelText: "Mbps",
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                DropdownButtonFormField<String>(
                  value: reference,
                  onChanged: (newValue) {
                    setState(() {
                      reference = newValue;
                    });
                  },
                  items: <String>['1', '2']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Reference",
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
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _typeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _collectorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Collector",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _cityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _ipController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "IP",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                      if (_formKey.currentState!.validate()) {
                        Cosmos.waitingDialog(context, "       Please Wait");
                        post_addCust();
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
    );
  }

  ///-------------------> Image Picker Function <------------------///
  void _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Future post_addCust() async {
  //   var request = http.MultipartRequest('POST',
  //       Uri.parse(addCust));
  //   request.fields['FColId'] = _collectorController.text.toString();
  //   request.fields['FCstDsc'] = _description.text.toString();
  //   request.fields['FCstSts'] = 'Yes';
  //   request.fields['FCntPer'] = _nameController.text.toString();
  //   request.fields['FPhnNum'] = _phoneController.toString();
  //   request.fields['FMobNum'] = _mobileController.text.toString();
  //   request.fields['FAdd001'] = _address1Controller.text.toString();
  //   request.fields['FAdd002'] = _address2Controller.text.toString();
  //   request.fields['FEmlAdd'] = _emailController.text.toString();
  //   request.fields['FShpNum'] = _shopController.text.toString();
  //   request.fields['FMthChg'] = _monthlyChargesController.text.toString();
  //   request.fields['FRefId'] = reference.toString();
  //   request.fields['FTypId'] = _typeController.text.toString();
  //   request.fields['FCtyId'] = _cityController.text.toString();
  //   request.fields['FLatVal'] = _latitudeController.text.toString();
  //   request.fields['FLngVal'] = _longitudeController.text.toString();
  //   request.fields['FSrvIp'] = _ipController.text.toString();
  //
  //   // if (_image != null) {
  //   //   var picture = await http.MultipartFile.fromPath('pic', _image!.path);
  //   //   request.files.add(picture);
  //   // }
  //
  //   final response = await http.Response.fromStream(await request.send());
  //
  //   var result = jsonDecode(response.body.toString());
  //
  //
  //   if (result["error"] == 200) {
  //     print(result["message"]);
  //     Cosmos.snackBarToast(context, result["message"], 'ok', 2);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //   } else {
  //     print(result["error"]);
  //     Cosmos.snackBarToast(context, result["message"], 'ok', 2);
  //   }
  // }
  Future post_addCust() async {
    var response = await http.post(Uri.parse(addCust),
        body: {
      'FColId': _collectorController.text.toString(),
      'FCstDsc': _description.text.toString(),
      'FCstSts': 'Yes',
      'FCntPer': _cntPersonController.text.toString(),
      'FPhnNum': _phoneController.text.toString(),
      'FMobNum': _mobileController.text.toString(),
      'FAdd001': _address1Controller.text.toString(),
      'FAdd002': _address2Controller.text.toString(),
      'FEmlAdd': _emailController.text.toString(),
      'FShpNum': _shopController.text.toString(),
      'FMthChg': _monthlyChargesController.text.toString(),
      'FRefId':  reference.toString(),
      'FTypId': _typeController.text.toString(),
      'FCtyId': _cityController.text.toString(),
      'FLatVal': _latitudeController.text.toString(),
      'FLngVal': _longitudeController.text.toString(),
      'FSrvIp': _ipController.text.toString(),
    });
    var result = jsonDecode(response.body);
    if(result['error'] == 200){
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: result['message']);
      print(result['message']);
      Navigator.pop(context);
    }
  }
}
