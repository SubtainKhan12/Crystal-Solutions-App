import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Cosmos {
  // FUNCTION OF LOADING/WAITING ALERT DIALOG BOX...
  static waitingDialog(BuildContext context, String msg) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7), child: Text(msg)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


static waitingDialogPro(context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Cosmic.app_color,
                ),
                strokeWidth: 5,
              ),
              SizedBox(height: 20),
              Text(
                'Just a moment...',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Processing Data...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/images/bottom_logo2.png',
                width: 300,
                height: 20,
              ),
            ],
          ),
        ),
      );
    },
  );
}


  // FUNCTION OF SHOWING TOAST
  static fToast(BuildContext context, String msg) {
    Fluttertoast.showToast(
      msg: (msg),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.deepOrange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

// FUNCTION OF SHOWING SNACK-BAR TOAST
  static snackBarToast(
      BuildContext context, String msg, String label, int seconds) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      action: SnackBarAction(
          onPressed: () {}, label: label, textColor: Colors.deepOrange),
      duration: Duration(seconds: seconds),
      // onVisible: () {},
      // elevation: 10,
      // behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.all(0),
    ));
  }

// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(content: Text('Processing Data')));
}

class Cosmic {
  static var app_color = Color(0xff111441);
  static var white_color = Colors.white;
}
