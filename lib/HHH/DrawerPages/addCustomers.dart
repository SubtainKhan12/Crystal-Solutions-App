import 'package:flutter/material.dart';

import '../../cosmos.dart';

class AddCustomers extends StatefulWidget {
  const AddCustomers({super.key});

  @override
  State<AddCustomers> createState() => _AddCustomersState();
}

class _AddCustomersState extends State<AddCustomers> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _description = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _ipController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _monthlyChargesController = TextEditingController();
  TextEditingController _shopController = TextEditingController();

  String? reference;



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
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
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
                  controller: _phoneController,
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                  Container(
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
                  Container(
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
                ],),
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
                  items: <String>['Office', 'Ghauri']
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
                        // Cosmos.waitingDialog(context, "       Please Wait");


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
}
