import 'package:crystal_solutions/HHH/DrawerPages/Bank/getBankScreen.dart';
import 'package:crystal_solutions/HHH/DrawerPages/City/getCity.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Collectors/getCollectors.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Customers%20Collections/getActiveCustomers.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Designation/getDesignation.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Reference/getReference.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Type/getType.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Employee/getEmployee.dart';
import 'package:crystal_solutions/HHH/Login/loginScreen.dart';
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import '../DrawerPages/Customers/customersScreen.dart';
import '../DrawerPages/Expense/getExpenseScreen.dart';
import '../DrawerPages/User Manegment/usersScreen.dart';

class DrawerUi extends StatefulWidget {
  const DrawerUi({super.key});

  @override
  State<DrawerUi> createState() => _DrawerUiState();
}

class _DrawerUiState extends State<DrawerUi> {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GetUsersScreen()));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                              height: 30, width: 30, child: Icon(Icons.person)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Users",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    listTileTheme: ListTileTheme.of(context)
                        .copyWith(dense: true, minVerticalPadding: 16),
                  ),
                  child: ExpansionTile(

                    leading: Icon(
                      Icons.person,
                      color: Cosmic.app_color,
                    ),
                    title: Text(
                      'Employee',
                      style: TextStyle(fontSize: 18),
                      selectionColor: Color(0xff111441),
                    ),
                    children: [
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> GetDesignationScreen()));
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.perm_device_info)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Designation",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> GetEmployeeScreen()));
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.person_pin_outlined)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Employee",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    listTileTheme: ListTileTheme.of(context)
                        .copyWith(dense: true, minVerticalPadding: 16),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.person,
                      color: Cosmic.app_color,
                    ),
                    title: Text(
                      'Customers',
                      style: TextStyle(fontSize: 18),
                      selectionColor: Color(0xff111441),
                    ),
                    children: [
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CollectorsScreen()));
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.person_pin)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Collectors",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GetReferenceScreen()));
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.person_add_rounded)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Reference",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GetTypeScreen()));
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.merge_type)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Type",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CityScreen()));
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.location_city)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Cities",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GetCustomersScreen()));
                          },
                          child: const Row(
                            children: [
                              SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.person)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Customers",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),

                SizedBox(
                  height: 39,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GetBankScreen()));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                              height: 30, width: 30, child: Icon(Icons.money)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Bank",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 39,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExpenseScreen()));
                      },
                      child: const Row(
                        children: [
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.food_bank_outlined)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Expense",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    listTileTheme: ListTileTheme.of(context)
                        .copyWith(dense: true, minVerticalPadding: 16),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.person,
                      color: Cosmic.app_color,
                    ),
                    title: Text(
                      'Billing',
                      style: TextStyle(fontSize: 18),
                      selectionColor: Color(0xff111441),
                    ),
                    children: [
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.person_pin)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Customers Billing",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    listTileTheme: ListTileTheme.of(context)
                        .copyWith(dense: true, minVerticalPadding: 16),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.person,
                      color: Cosmic.app_color,
                    ),
                    title: Text(
                      'Receipts',
                      style: TextStyle(fontSize: 18),
                      selectionColor: Color(0xff111441),
                    ),
                    children: [
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerCollectionScreen()));
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.person_pin)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Customer Collections",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    listTileTheme: ListTileTheme.of(context)
                        .copyWith(dense: true, minVerticalPadding: 16),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.person,
                      color: Cosmic.app_color,
                    ),
                    title: Text(
                      'Payments',
                      style: TextStyle(fontSize: 18),
                      selectionColor: Color(0xff111441),
                    ),
                    children: [
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.person_pin)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Expense Payment",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 39,
                        child: TextButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.person_pin)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Salary Payment",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 39,
                //   child: TextButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                     const GetCustomersScreen()));
                //       },
                //       child: const Row(
                //         children: [
                //           SizedBox(
                //               height: 30, width: 30, child: Icon(Icons.person)),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           Text(
                //             "Customers",
                //             style: TextStyle(fontSize: 18),
                //           ),
                //         ],
                //       )),
                // ),

                // custom_badge.Badge(
                //   showBadge: admin_drawerProvider.complainList
                //       .where((data) => data.status == 'Pending')
                //       .isNotEmpty,
                //   position:
                //       custom_badge.BadgePosition.topEnd(top: -5, end: 220),
                //   badgeContent: Text(
                //     admin_drawerProvider.complainList
                //         .where((data) => data.status == 'Pending')
                //         .length
                //         .toString(),
                //     style: TextStyle(color: Cosmic.iconTheme),
                //   ),
                //   child: TextButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => Complains()));
                //       },
                //       child: Row(
                //         children: [
                //           SizedBox(
                //               height: 30,
                //               width: 30,
                //               child: Image.asset(
                //                 "assets/complains.png",
                //               )),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           const Text(
                //             "Complains",
                //             style: TextStyle(fontSize: 18),
                //           ),
                //         ],
                //       )),
                // ),
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
