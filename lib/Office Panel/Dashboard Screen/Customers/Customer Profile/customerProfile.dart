import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Model/Customers/GetActiveCustomersModel.dart';
import '../../../../cosmos.dart';

class CustomerProfileUI extends StatefulWidget {
  GetActiveCustomersModel getActiveCustomersList;
  CustomerProfileUI({super.key, required this.getActiveCustomersList});

  @override
  State<CustomerProfileUI> createState() => _CustomerProfileUIState();
}

class _CustomerProfileUIState extends State<CustomerProfileUI> {
  final numberFormat = NumberFormat('#,###');
  String formatAmount(String amount) {
    final doubleAmount = double.tryParse(amount)?? 0.00;
    return numberFormat.format(doubleAmount);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customers Profile',
          style: TextStyle(color: Cosmic.white_color),
        ),
        centerTitle: true,
        backgroundColor: Cosmic.app_color,
        iconTheme: IconThemeData(color: Cosmic.white_color),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          elevation: 2,
          shadowColor: Cosmic.app_color,
          borderOnForeground: true,
          surfaceTintColor: Colors.blue.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                SizedBox(height: 16.0),
                _buildInfoRow("Shop Name", widget.getActiveCustomersList.tCstDsc.toString()),
                _buildInfoRow("Contact Person", widget.getActiveCustomersList.tCntPer.toString()),
                _buildInfoRow("Mobile Number", widget.getActiveCustomersList.tMobNUm.toString()),
                _buildInfoRow("Phone Number", widget.getActiveCustomersList.tPhnNum.toString()),
                _buildInfoRow("Email", widget.getActiveCustomersList.tEmlAdd.toString()),
                _buildInfoRow("Shop Number", widget.getActiveCustomersList.tShpNum.toString()),
                _buildInfoRow("Address Line 1", widget.getActiveCustomersList.tAdd001.toString()),
                _buildInfoRow("Address Line 2", widget.getActiveCustomersList.tAdd002.toString()),
                _buildInfoRow("Arrear Charge", formatAmount(widget.getActiveCustomersList.tarrchg.toString()== 'null'? '0':widget.getActiveCustomersList.tarrchg.toString())),
                _buildInfoRow("Server Charge", formatAmount(widget.getActiveCustomersList.tsrvchg.toString()== 'null'? '0':widget.getActiveCustomersList.tsrvchg.toString())),
                _buildInfoRow("Monthly Charge", formatAmount(widget.getActiveCustomersList.tmthChg.toString()== 'null'? '0':widget.getActiveCustomersList.tmthChg.toString())),
                _buildInfoRow("SMS Charge", formatAmount(widget.getActiveCustomersList.tsmschg.toString()== 'null'? '0':widget.getActiveCustomersList.tsmschg.toString())),
                _buildInfoRow("Advance Charge", formatAmount(widget.getActiveCustomersList.tadvchg.toString()== 'null'? '0':widget.getActiveCustomersList.tadvchg.toString())),
                _buildInfoRow("POS Charge", formatAmount(widget.getActiveCustomersList.tposchg.toString() == 'null'? '0':widget.getActiveCustomersList.tposchg.toString())),
                _buildInfoRow("Other Charge", formatAmount(widget.getActiveCustomersList.tothchg.toString() == 'null' ? '0':widget.getActiveCustomersList.tothchg.toString())),
                _buildInfoRow("Total Amount", formatAmount(widget.getActiveCustomersList.ttotamt.toString() ?? "0")),
                SizedBox(height: 16.0),
                _buildMapSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundImage: widget.getActiveCustomersList.tCstPic.toString() != null
              ? NetworkImage(widget.getActiveCustomersList.tCstPic.toString())
              : AssetImage("assets/default_profile.png") as ImageProvider,
        ),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.getActiveCustomersList.tCntPer.toString(),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.getActiveCustomersList.tCstDsc.toString(),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.blueGrey[50],
      ),
      child: Center(
        child: Icon(
          Icons.location_on,
          color: Colors.blueGrey,
          size: 50.0,
        ),
      ),
    );
  }
}
