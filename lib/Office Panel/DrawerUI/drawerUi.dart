import 'package:crystal_solutions/Office%20Panel/Drawer%20Pages/CollectionRegister/collectionRegister.dart';
import 'package:flutter/material.dart';

import '../../HHH/Login/loginScreen.dart';
import '../../cosmos.dart';
import '../Drawer Pages/BillRegister/billRegister.dart';
import '../Drawer Pages/CustomerRecievable/customerRecievable.dart';

class OfficeDrawerUI extends StatefulWidget {
  const OfficeDrawerUI({super.key});

  @override
  State<OfficeDrawerUI> createState() => _OfficeDrawerUIState();
}

class _OfficeDrawerUIState extends State<OfficeDrawerUI> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 270,
        child: ListView(
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(color: Colors.blueAccent),
                child: Image.asset(
                    "assets/Crystal-Solutions-logo-removebg-preview.png")),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 39,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CollectionRegisterUI()));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                              height: 30, width: 30, child: Icon(Icons.person)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Collection Register",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 39,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> BillRegisterUi()));

                      },
                      child: const Row(
                        children: [
                          SizedBox(
                              height: 30, width: 30, child: Icon(Icons.person)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Bill Register",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 39,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerReceivableUi()));

                      },
                      child: const Row(
                        children: [
                          SizedBox(
                              height: 30, width: 30, child: Icon(Icons.monetization_on_outlined)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Customer Recievable",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 39,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.logout,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
