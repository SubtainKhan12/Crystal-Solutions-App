import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crystal_solutions/Model/Customers/GetCustomersModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Model/City/GetActiveCity.dart';
import '../../../Model/City/GetCityModel.dart';
import '../../../Model/Collectors/GetCollectorsModel.dart';
import '../../../Model/Reference/GetActiveReference.dart';
import '../../../Model/Reference/GetReferenceModel.dart';
import '../../../Model/Type/GetActiveType.dart';
import '../../../Model/Type/GetType.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class UpdateCustomersScreen extends StatefulWidget {
  GetCustomersModel getCustomersModel;
  List<GetActiveCity> getActiveCityList = [];
  List<GetActiveReference> getActiveReferenceList = [];
  List<GetCollectorsModel> getCollectorList = [];
  List<GetActiveType> getActiveTypeList = [];

  UpdateCustomersScreen(
      {super.key,
      required this.getCustomersModel,
      required this.getActiveCityList,
      required this.getActiveReferenceList,
      required this.getActiveTypeList,
      required this.getCollectorList});

  @override
  State<UpdateCustomersScreen> createState() => _UpdateCustomersScreenState();
}

class _UpdateCustomersScreenState extends State<UpdateCustomersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _description = TextEditingController();
  TextEditingController _cntPersonController = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _ipController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _monthlyChargesController = TextEditingController();
  TextEditingController _shopController = TextEditingController();
  TextEditingController _serverChargesController = TextEditingController();
  TextEditingController _smsChargesController = TextEditingController();
  TextEditingController _posChargesController = TextEditingController();
  TextEditingController _advanceChargesController = TextEditingController();
  TextEditingController _arrearChargesController = TextEditingController();
  TextEditingController _otherChargesController = TextEditingController();

  String? status;
  File? _image;
  String? selectedCity;
  String? SelectedCollector;
  String? SelectedReference;
  String? SelectedType;

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

  // String? validatePTCL(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a valid PTCL number';
  //   }
  //   if (!RegExp(r'^0[2-9][0-9]{2}[-]?[0-9]{5,9}$').hasMatch(value)) {
  //     return 'Invalid PTCL number format';
  //   }
  //   return null;
  // }

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
    setCustomerData();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Customer',
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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Image.asset(
                    'assets/Crystal-Solutions-logo-removebg-preview.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8)),
                            child: _image == null
                                ? Image.network(
                              "https://crystalsolutions.com.pk/csnew/customerimg//${widget.getCustomersModel.tCstPic.toString()}",
                              fit: BoxFit.fill,
                            )
                                : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: _takePicture,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.red,
                                size: 45,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
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
                        height: 15,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _cntPersonController,
                          decoration: InputDecoration(
                            labelText: "Contact Person",
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
                        constraints: BoxConstraints.tightFor(
                          height: _height / 14,
                          width: _width / 0.3,
                        ),
                        child: TextFormField(
                          maxLength: 11,
                          controller: _mobileController,
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
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          height: _height / 14,
                          width: _width / 0.3,
                        ),
                        child: TextFormField(
                          maxLength: 11,
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          // validator: validatePTCL,
                        ),
                      ),

                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
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
                        height: _height / 16,
                        width: _width / 0.3,
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
                        constraints: BoxConstraints.tightFor(
                          height: _height / 14,
                          width: _width / 0.3,
                        ),
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
                      // const SizedBox(
                      //   height: 15,
                      // ),

                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _shopController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Shops",
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
                          controller: _arrearChargesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Arrer Charges",
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
                          controller: _serverChargesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Server Charges",
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
                          controller: _smsChargesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Sms Charges",
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
                          controller: _advanceChargesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Advance Charges",
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
                          controller: _posChargesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Pos Charges",
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
                          controller: _monthlyChargesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Monthly Charges",
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
                          controller: _otherChargesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Other Charges",
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: _width * 0.45,
                              child: TextField(
                                controller: _latitudeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Latitude",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: _width * 0.45,
                              child: TextField(
                                controller: _longitudeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Longitude",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
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
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: DropdownButtonFormField<String>(
                          value: SelectedReference,
                          onChanged: (newValue) {
                            setState(() {
                              SelectedReference = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Reference",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          items: widget.getActiveReferenceList.map((refernce) {
                                return DropdownMenuItem<String>(
                                  value: refernce.trefid ?? '',
                                  child: Text(refernce.trefdsc ?? ''),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: DropdownButtonFormField<String>(
                          value: SelectedType,
                          onChanged: (newValue) {
                            setState(() {
                              SelectedType = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Type",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          items: widget.getActiveTypeList.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type.ttypid ?? '',
                                  child: Text(type.ttypdsc ?? ''),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: DropdownButtonFormField<String>(
                          value: SelectedCollector,
                          onChanged: (newValue) {
                            setState(() {
                              SelectedCollector = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Collector",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          items: widget.getCollectorList.map((collector) {
                                return DropdownMenuItem<String>(
                                  value: collector.tcolid ?? '',
                                  child: Text(collector.tcoldsc ?? ''),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: DropdownButtonFormField<String>(
                          value: selectedCity,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCity = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "City",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          items: widget.getActiveCityList.map((city) {
                                return DropdownMenuItem<String>(
                                  value: city.tctyid ?? '',
                                  child: Text(city.tctydsc ?? ''),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: _height / 16,
                        width: _width / 0.3,
                        child: TextField(
                          controller: _ipController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "IP",
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: -20),
                                // Adjust padding here
                                onChanged: (String? value) {
                                  setState(() {
                                    status = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text(
                                  'No',
                                ),
                                value: 'No',
                                groupValue: status,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: -20),
                                // Adjust padding here
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
                        height: _height / 16,
                        width: _width / 0.3, // Set the height
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Cosmos.waitingDialog(
                                  context, "       Please Wait");
                              post_updateCust();
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
          ),
        ],
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

  setCustomerData() {
    _description.text = widget.getCustomersModel.tCstDsc ?? '';
    _cntPersonController.text = widget.getCustomersModel.tCntPer ?? '';
    _mobileController.text = widget.getCustomersModel.tMobNUm ?? '';
    _phoneController.text = widget.getCustomersModel.tPhnNum ?? '';
    _address1Controller.text = widget.getCustomersModel.tAdd001 ?? '';
    _address2Controller.text = widget.getCustomersModel.tAdd002 ?? '';
    _emailController.text = widget.getCustomersModel.tEmlAdd ?? '';
    _shopController.text = widget.getCustomersModel.tShpNum ?? '';
    _monthlyChargesController.text = widget.getCustomersModel.tmthChg ?? '';
    _latitudeController.text = widget.getCustomersModel.tLatVal ?? '';
    _longitudeController.text = widget.getCustomersModel.tLngVal ?? '';
    SelectedReference = widget.getCustomersModel.tRefId ?? '';
    status = widget.getCustomersModel.tCstSts ?? '';
    SelectedType = widget.getCustomersModel.tTypId ?? '';
    SelectedCollector = widget.getCustomersModel.tColId ?? '';
    selectedCity = widget.getCustomersModel.tctyid ?? '';
    _posChargesController.text = widget.getCustomersModel.tposchg ?? '';
    _advanceChargesController.text = widget.getCustomersModel.tadvchg ?? '';
    _serverChargesController.text = widget.getCustomersModel.tsrvchg ?? '';
    _smsChargesController.text = widget.getCustomersModel.tsmschg ?? '';
    _otherChargesController.text = widget.getCustomersModel.tothchg ?? '';
    _arrearChargesController.text = widget.getCustomersModel.tarrchg ?? '';
  }
  Future post_updateCust() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(updateCust));
    request.fields['FCstId'] = widget.getCustomersModel.tcstid.toString();
    request.fields['FColId'] = SelectedCollector.toString();
    request.fields['FCstDsc'] = _description.text.toString();
    request.fields['FCstSts'] = status.toString();
    request.fields['FCntPer'] = _cntPersonController.text.toString();
    request.fields['FPhnNum'] = _phoneController.text.toString();
    request.fields['FMobNum'] = _mobileController.text.toString();
    request.fields['FAdd001'] = _address1Controller.text.toString();
    request.fields['FAdd002'] = _address2Controller.text.toString();
    request.fields['FEmlAdd'] = _emailController.text.toString();
    request.fields['FShpNum'] = _shopController.text.toString();
    request.fields['FMthChg'] = _monthlyChargesController.text.isEmpty ? '0' : _monthlyChargesController.text;
    request.fields['FRefId'] = SelectedReference.toString();
    request.fields['FTypId'] = SelectedType.toString();
    request.fields['FCtyId'] = selectedCity.toString();
    request.fields['FLatVal'] = _latitudeController.text.toString();
    request.fields['FLngVal'] = _longitudeController.text.toString();
    request.fields['FSrvIp'] = _ipController.text.toString();
    request.fields['FSrvChg']= _serverChargesController.text.isEmpty ? '0' : _serverChargesController.text;
    request.fields['FSmsChg'] = _smsChargesController.text.isEmpty ? '0' : _smsChargesController.text;
    request.fields['FAdvChg'] = _advanceChargesController.text.isEmpty ? '0' : _advanceChargesController.text;
    request.fields['FPosChg'] = _posChargesController.text.isEmpty ? '0' : _posChargesController.text;
    request.fields['FArrChg'] = _arrearChargesController.text.isEmpty ? '0' : _arrearChargesController.text;
    request.fields['FOthChg'] = _otherChargesController.text.isEmpty ? '0' : _otherChargesController.text;
    request.fields['imgname'] = widget.getCustomersModel.tCstPic.toString();
    if (_image != null) {
      var picture = await http.MultipartFile.fromPath('FCstImg', _image!.path);
      request.files.add(picture);
    }

    final response = await http.Response.fromStream(await request.send());

    var result = jsonDecode(response.body.toString());


    if (result["error"] == 200) {
      print(result["message"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print(result["error"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
    }
  }
}
