import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../Model/Bank/GetActiveBank.dart';
import '../../../Model/Expense/GetActiveExpense.dart';
import '../../../apis.dart';
import '../../../cosmos.dart';

class OfficeExpensePaymentUI extends StatefulWidget {
  const OfficeExpensePaymentUI({super.key});

  @override
  State<OfficeExpensePaymentUI> createState() => _OfficeExpensePaymentUIState();
}

class _OfficeExpensePaymentUIState extends State<OfficeExpensePaymentUI> {
  List<GetActiveExpense> _getActiveExpensList = [];
  List<GetActiveExpense> filterActiveExpenseList = [];
  List<GetActiveBank> _getActiveBankList = [];
  String? SelectBank;
  DateTime selectedDate = DateTime.now(); // Default date
   TextEditingController _amountController = TextEditingController();
   TextEditingController _remarksController = TextEditingController();
  File? _localImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ActiveExp();
    get_ActiveBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: RefreshIndicator(
        onRefresh: get_ActiveExp,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  filterActiveExpense(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: filterActiveExpenseList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filterActiveExpenseList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 2,
                              shadowColor: Cosmic.app_color,
                              borderOnForeground: true,
                              surfaceTintColor: Colors.blue.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          filterActiveExpenseList[index]
                                              .texpdsc
                                              .toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 50,
                                          height: 30,
                                          child: PopupMenuButton<int>(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                onTap: () {
                                                  _showDialog(
                                                      context,
                                                      filterActiveExpenseList[
                                                          index]);
                                                },
                                                value: 1,
                                                child: Text(
                                                  'Add Expense',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                            offset: const Offset(0, 30),
                                            color: Colors.white,
                                            elevation: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      filterActiveExpenseList[index]
                                          .texpsts
                                          .toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      filterActiveExpenseList[index]
                                          .tmthbgt
                                          .toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, GetActiveExpense getActiveExpense) {

    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;


    Future<void> _selectDate(BuildContext context, StateSetter setState) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    void _takePictureFromGallery(StateSetter setState) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _localImage = File(pickedFile.path);
        });
      }
    }

    void _takePictureFromCamera(StateSetter setState) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _localImage = File(pickedFile.path);
        });
      }
    }

    Future _showDialogeCameraAndGallery1(StateSetter setState) async {
      var _height = MediaQuery.of(context).size.height;
      var _width = MediaQuery.of(context).size.width;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose an option'),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  _takePictureFromCamera(setState);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: _height * 0.04,
                  child: Image.asset(
                    'assets/camera.png',
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  _takePictureFromGallery(setState);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: _height * 0.04,
                  child: Image.asset('assets/gallery.png'),
                ),
              ),
            ],
          );
        },
      );
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Expense',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              content: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: _localImage == null
                                  ? const Center(child: Text(""))
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                        _localImage!,
                                        fit: BoxFit.cover,
                                      ),
                                  ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                _showDialogeCameraAndGallery1(setState);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        InkWell(
                          onTap: () => _selectDate(context, setState),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.blue),
                              SizedBox(width: 8),
                              Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Dsc: ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: getActiveExpense.texpdsc.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ])),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: _height * 0.06,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            decoration: InputDecoration(
                                labelText: 'Add Amount',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3))),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: _height * 0.06,
                          child: DropdownButtonFormField<String>(
                            value: SelectBank,
                            onChanged: (newValue) {
                              setState(() {
                                SelectBank = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Bank",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            items: _getActiveBankList.map((collector) {
                                  return DropdownMenuItem<String>(
                                    value: collector.tbnkid ?? '',
                                    child: Text(collector.tbnkdsc ?? ''),
                                  );
                                }).toList() ??
                                [],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: _height * 0.06,
                          child: TextField(
                            controller: _remarksController,
                            decoration: InputDecoration(
                                labelText: 'Remarks',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      selectedDate = DateTime.now();
                      _amountController.clear();
                      _remarksController.clear();
                      SelectBank = null;
                      _localImage = null;
                    });
                  },
                ),
                TextButton(
                  child: Text('Submit'),
                  onPressed: () {
                    post_newExp(getActiveExpense);
                    Cosmos.waitingDialog(context, '         Please wait');
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
  Future post_newExp(GetActiveExpense getActiveExpense) async {
    var request = http.MultipartRequest('POST',
        Uri.parse(newExp));
    request.fields['FTrnDat'] = selectedDate.toString();
    request.fields['FExpId'] = getActiveExpense.texpid.toString();
    request.fields['FTrnTot'] = _amountController.text.toString();
    request.fields['FTrnDsc'] = _remarksController.text.toString();
    request.fields['FBnkId'] = SelectBank.toString();


    if (_localImage != null) {
      var picture = await http.MultipartFile.fromPath('ExpImg', _localImage!.path);
      request.files.add(picture);
    }

    final response = await http.Response.fromStream(await request.send());

    var result = jsonDecode(response.body.toString());

    if (result["error"] == 200) {
      print(result["message"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      Navigator.pop(context);
      setState(() {
        selectedDate = DateTime.now();
        _amountController.clear();
        _remarksController.clear();
        SelectBank = null;
        _localImage = null;
      });
    } else {
      print(result["error"]);
      Fluttertoast.showToast(msg: result['message']);
      Navigator.pop(context);
      setState(() {
        selectedDate = DateTime.now();
        _amountController.clear();
        _remarksController.clear();
        SelectBank = null;
        _localImage = null;
      });
    }
  }

  Future get_ActiveExp() async {
    var response = await http.post(Uri.parse(getActiveExp));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getActiveExpensList.clear();
      for (Map i in result) {
        _getActiveExpensList.add(GetActiveExpense.fromJson(i));
      }
      setState(() {
        filterActiveExpenseList = List.from(_getActiveExpensList);
      });
    }
  }

  Future get_ActiveBank() async {
    var response = await http.post(Uri.parse(getActiveBank));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _getActiveBankList.clear();
      for (Map i in result) {
        _getActiveBankList.add(GetActiveBank.fromJson(i));
      }
      setState(() {});
    }
  }

  filterActiveExpense(String query) {
    setState(() {
      filterActiveExpenseList = _getActiveExpensList
          .where((element) =>
              element.texpdsc!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
