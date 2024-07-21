import 'dart:convert';
import 'package:crystal_solutions/apis.dart';
import 'package:crystal_solutions/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset(
                'assets/Crystal-Solutions-logo-removebg-preview.png',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  fillColor: Colors.grey.shade200,
                  filled: true),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  fillColor: Colors.grey.shade200,
                  filled: true),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: (){
                Cosmos.waitingDialog(context, 'Please Wait          ');
                loginApi();
              },
              child: Container(
                height: 65,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Cosmic.app_color),
                child: const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ]),
        ),
      )),
    );
  }
  Future loginApi() async {
    var response = await http.post(Uri.parse(login), body: {
      'FUsrId': _emailController.text,
      'FUsrPwd': _passwordController.text,
    });
    var result = jsonDecode(response.body);

    if (result['error'] == 200){
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DashboardPage()));
      Fluttertoast.showToast(msg: result['message']);

    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: result['message']);
      _passwordController.clear();
      _emailController.clear();
    }
  }
}
