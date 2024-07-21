import 'package:crystal_solutions/HHH/DrawerPages/City/addCity.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Customers/addCustomers.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Reference/addReference.dart';
import 'package:crystal_solutions/HHH/DrawerPages/Type/addType.dart';
import 'package:crystal_solutions/HHH/Login/loginScreen.dart';
import 'package:flutter/material.dart';
import '../DrawerPages/Collectors/addCollectors.dart';

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
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddCustomers()));
                    },
                    child: const Row(
                      children: [
                        SizedBox(
                            height: 30, width: 30, child: Icon(Icons.person)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Customers",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddCollectors()));
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
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddReference()));
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
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddType()));
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
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddCity()));
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
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
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
              ],
            ),
          ],
        ));
  }
}
