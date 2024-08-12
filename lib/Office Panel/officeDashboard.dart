import 'package:crystal_solutions/Office%20Panel/Dashboard%20Screen/Customers/customers.dart';
import 'package:crystal_solutions/Office%20Panel/Dashboard%20Screen/Expense/expense.dart';
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';

import 'DrawerUI/drawerUi.dart';

class OfficeDashboardUI extends StatefulWidget {
  const OfficeDashboardUI({super.key});

  @override
  State<OfficeDashboardUI> createState() => _OfficeDashboardUIState();
}

class _OfficeDashboardUIState extends State<OfficeDashboardUI> {
  String? costomerList;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Office Dashboard',
            style: TextStyle(color: Cosmic.white_color),
          ),
          centerTitle: true,
          backgroundColor: Cosmic.app_color,
          iconTheme: IconThemeData(color: Cosmic.white_color),
        ),
        drawer: OfficeDrawerUI(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Opacity(
                opacity: 0.3, // Adjust the opacity as needed
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Column(
                    children: [
                      Image.asset(
                          'assets/Crystal-Solutions-logo-removebg-preview.png'),
                      Text(
                        'Crystal Solutions',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomersUI()));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          shadowColor: Color(0xffFFAD60),
                          child: Container(
                            height: _height * 0.06,
                            width: _width * 0.45,
                            decoration: BoxDecoration(
                              color: Color(0xffFFAD60),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: _width * 0.03,
                                ),
                                Image.asset(
                                  'assets/customers.png',
                                  height: 30,
                                ),
                                VerticalDivider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                                // SizedBox(width: 20,),
                                Text(
                                  'Customers',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 10,
                        shadowColor: Color(0xffFFAD60),
                        child: Container(
                          height: _height * 0.06,
                          width: _width * 0.45,
                          decoration: BoxDecoration(
                            color: Color(0xffFFAD60),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Image.asset(
                                'assets/Expense.png',
                                height: 30,
                              ),
                              VerticalDivider(
                                color: Colors.cyanAccent,
                                thickness: 1,
                              ),
                              // SizedBox(width: 20,),
                              Text(
                                'Expense',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 10,
                        shadowColor: Color(0xffFFAD60),
                        child: Container(
                          height: _height * 0.06,
                          width: _width * 0.45,
                          decoration: BoxDecoration(
                            color: Color(0xffFFAD60),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Image.asset(
                                'assets/Complain.png',
                                height: 30,
                              ),
                              VerticalDivider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                              // SizedBox(width: 20,),
                              Text(
                                'Complains',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 10,
                        shadowColor: Color(0xffFFAD60),
                        child: Container(
                          height: _height * 0.06,
                          width: _width * 0.45,
                          decoration: BoxDecoration(
                            color: Color(0xffFFAD60),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Image.asset(
                                'assets/MIS.png',
                                height: 30,
                              ),
                              VerticalDivider(
                                color: Colors.cyanAccent,
                                thickness: 1,
                              ),
                              // SizedBox(width: 20,),
                              Text(
                                'MIS',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
