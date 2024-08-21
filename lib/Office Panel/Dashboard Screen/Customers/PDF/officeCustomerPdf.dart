import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import '../../../../HHH/DrawerPages/Customers/Customer PDF/pdf_file_handle.dart';
import '../../../../Model/Bill/GetBillModel.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Add Bill/getBill.dart';

class OfficeCustomerReciept_PDF {
  static Future<File> generate(GetBillModel filterBillList) async {
    DateTime parsedDate = DateTime.parse(filterBillList.date.toString());
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    final numberFormat = NumberFormat('#,###');
    String formatAmount(String amount) {
      final doubleAmount = double.tryParse(amount)?? 0.00;
      return numberFormat.format(doubleAmount);
    }
    ByteData image = await rootBundle.load('assets/CrystalSolutions.jpg');

    Uint8List imageData = (image).buffer.asUint8List();

    ByteData image2 = await rootBundle.load('assets/Sign1.jpg');

    Uint8List imageData2 = (image2).buffer.asUint8List();
    ByteData image3 = await rootBundle.load('assets/UrduText.png');

    Uint8List urduText = (image3).buffer.asUint8List();
    ByteData image4 = await rootBundle.load('assets/locationQR.png');

    Uint8List locationQR = (image4).buffer.asUint8List();

    final pdf = pw.Document(
        // pageMode: PdfPageMode.fullscreen,
        );

    // final tableHeaders = [
    //   // 'Sr#',
    //   // 'PARTICULARS',
    //   // 'Amount Rs',
    //   // 'Mobile',
    //   // 'Phone',
    //   // 'Add 1',
    //   // 'Add 2',
    //   // 'Email',
    //   // 'Shops',
    //   // 'Srv',
    //   // 'SMS',
    //   // 'Adv',
    //   // 'POS',
    //   // 'Monthly',
    //   // 'Total',
    //   // 'Ref#',
    //   // 'Type',
    //   // 'Clctr',
    //   // 'City',
    //   // 'Srv IP',
    //   // 'Status',
    // ];
    // final tableData = [
    //   // for (int i = 0; i < getActiveCustomersModel.length; i++)
    //   [
    //     // i + 1,
    //     // getActiveCustomersModel.tCstDsc.toString().trim(),
    //     // getActiveCustomersModel.tCntPer.toString().trim(),
    //     // getActiveCustomersModel[i].tMobNUm.toString().trim(),
    //     // getActiveCustomersModel[i].tPhnNum.toString(),
    //     // getActiveCustomersModel[i].tAdd001.toString(),
    //     // getActiveCustomersModel[i].tAdd002.toString(),
    //     // getActiveCustomersModel[i].tEmlAdd.toString(),
    //     // getActiveCustomersModel[i].tShpNum.toString(),
    //     // getCustomersModel[i].tsrvchg.toString(),
    //     // getCustomersModel[i].tsmschg.toString(),
    //     // getCustomersModel[i].tadvchg.toString(),
    //     // getCustomersModel[i].tposchg.toString(),
    //     // getCustomersModel[i].tmthChg.toString(),
    //     // getCustomersModel[i].ttotamt.toString(),
    //     // getCustomersModel[i].tRefId.toString(),
    //     // getCustomersModel[i].tTypId.toString(),
    //     // getCustomersModel[i].tColId.toString(),
    //     // getCustomersModel[i].tctyid.toString(),
    //     // getCustomersModel[i].tSrvIp.toString(),
    //     // getCustomersModel[i].tCstSts.toString(),
    //   ],
    // ];

    double arrear = double.tryParse(filterBillList.arrear.toString()) ?? 0.0;
    double serverChg =
        double.tryParse(filterBillList.serverChg.toString()) ?? 0.0;
    double sMSChg = double.tryParse(filterBillList.sMSChg.toString()) ?? 0.0;
    double advacneChg =
        double.tryParse(filterBillList.advacneChg.toString()) ?? 0.0;
    double monthlyChg =
        double.tryParse(filterBillList.monthlyChg.toString()) ?? 0.0;
    double posChg = double.tryParse(filterBillList.pSOChg.toString()) ?? 0.0;
    double otherChg =
        double.tryParse(filterBillList.otherChg.toString()) ?? 0.0;

    // Calculate the total charges
    double total = arrear +
        serverChg +
        sMSChg +
        advacneChg +
        monthlyChg +
        posChg +
        otherChg;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        margin:
            const pw.EdgeInsets.only(left: 25, right: 25, bottom: 0, top: 0),
        header: (context) {
          return pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 15),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 25),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(imageData)),
                    pw.Padding(padding: pw.EdgeInsets.only(right: 30),
                    child: pw.Image(pw.MemoryImage(locationQR),height: 80),)

                  ]
                ),
                pw.Align(
                    alignment: pw.Alignment.topRight,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.only(right: 20),
                      child: pw.Text('Customer Copy',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    )),
                pw.Divider(thickness: 1, height: 0),
                pw.Divider(
                  height: 5,
                  thickness: 1,
                ),
                pw.Center(
                  child: pw.Text(
                      '15-D, AL-Makkah Colony, Near Butt Chowk, College Road, Lahore. Ph : 0304-4770075, 0302-8427221, 04235184078',
                      style: pw.TextStyle(fontSize: 13)),
                ),
                pw.SizedBox(height: 10),
                pw.Stack(children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top: 10, left: 630),
                    child: pw.Container(
                      height: 16,
                      width: 120,
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(0),
                        border: pw.Border.all(color: PdfColors.black)
                      ),
                      child: pw.RichText(
                          text: pw.TextSpan(children: [
                            pw.TextSpan(
                              text: 'Due Date: ',
                              style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontWeight: pw.FontWeight.bold),
                            ),
                            pw.TextSpan(
                              text: '10th',
                              style: const pw.TextStyle(
                                color: PdfColors.black,
                              ),
                            ),
                          ])),
                    ),
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: 300,
                          decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(0),
                              border: pw.Border.all(
                                color: PdfColor.fromInt(0xff000000),
                              )),
                          child: pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        filterBillList.customerName.toString()),
                                    pw.Text(
                                        filterBillList.contactPerson.toString()),
                                    pw.Text(filterBillList.mobile.toString()),
                                    pw.Text(filterBillList.email.toString()),
                                    pw.Text(filterBillList.address1.toString()),
                                    pw.Text(filterBillList.address2.toString()),
                                  ])),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Padding(
                            padding: pw.EdgeInsets.only(right: 10, top: 50),
                            child: pw.Container(
                              child: pw.Column(children: [
                                pw.Container(
                                  width: 100,
                                  child: pw.RichText(
                                      text: pw.TextSpan(children: [
                                        pw.TextSpan(
                                          text: 'Invoice: ',
                                          style: pw.TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                        pw.TextSpan(
                                          text: '${filterBillList.inv.toString()}',
                                          style: const pw.TextStyle(
                                            color: PdfColors.black,
                                          ),
                                        ),
                                      ])),
                                ),
                                pw.Container(
                                  child: pw.RichText(
                                      text: pw.TextSpan(children: [
                                        pw.TextSpan(
                                          text: '       Date: ',
                                          style: pw.TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                        pw.TextSpan(
                                          text: formattedDate,
                                          style: const pw.TextStyle(
                                            color: PdfColors.black,
                                          ),
                                        ),
                                      ])),
                                )

                              ]),
                            ),

                          ),
                        ),
                      ]),
                ]),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Divider(thickness: 1, height: 0),
                pw.Divider(
                  height: 5,
                  thickness: 1,
                ),
                pw.Container(
                  // color: PdfColors.blue,
                  width: 280,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('   Sr#',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 14)),
                      pw.Text('PARTICULARS',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 14)),
                      pw.Text('Amount Rs.',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ),
                pw.Divider(thickness: 1, height: 7),
                pw.Divider(
                  height: 0,
                  thickness: 1,
                ),
                pw.SizedBox(height: 5),
                pw.Stack(children: [
                  pw.Container(
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(left: 20),
                        child: pw.Column(children: [
                          pw.Text('1.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('2.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('3.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('4.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('5.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('6.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text('7.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ])),
                  ),
                  pw.Container(
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(left: 70),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Arear',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Server Charges',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('SMS Charges',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Advance Charges',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Monthly Charges',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('POS Charges',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Other Charges',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            ])),
                  ),
                  pw.Container(
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(left: 240),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(formatAmount(filterBillList.arrear.toString()),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(formatAmount(filterBillList.serverChg.toString()),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(formatAmount(filterBillList.sMSChg.toString()),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(formatAmount(filterBillList.advacneChg.toString()),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(formatAmount(filterBillList.monthlyChg.toString()),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(formatAmount(filterBillList.pSOChg.toString()),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(formatAmount(filterBillList.otherChg.toString()),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            ])),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top: 100),
                    child: pw.Container(
                      width: 300,
                      child: pw.Divider(thickness: 1, height: 5),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top: 103),
                    child: pw.Container(
                      width: 300,
                      child: pw.Divider(thickness: 1, height: 5),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top: 110, left: 160),
                    child: pw.Text('TOTAL',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top: 110, left: 240),
                    child: pw.Text(formatAmount(total.toString()),
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(left: 500),
                    child: pw.Container(
                        height: 125,
                        width: 270,
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('CRYSTAL SOLUTIONS',
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Meezan Bank, Akbar Chowk'),
                              pw.Text('IBAN No: PK32MEZN0002060109804512'),
                              pw.SizedBox(height: 10),
                              pw.Text('JAZZ CASH',
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('03218811400'),
                              pw.Text('Abdul Razzaq Ghauri'),
                            ])),
                  ),
                ]),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 30, top: 20),
                  child: pw.Container(
                    width: 150,
                    height: 40,
                    child: pw.Image(pw.MemoryImage(imageData2)),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 30),
                  child: pw.Container(
                    width: 150,
                    // height: 50,
                    child: pw.Divider(thickness: 1, height: 5),
                  ),
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.only(left: 70),
                        child: pw.Text('(Signature)'),
                      ),
                      pw.Container(
                        width: 600,
                        child: pw.Image(pw.MemoryImage(urduText)),
                      )
                    ])
              ],
            ),
          );
        },
        build: (context) {
          return [
            pw.TableHelper.fromTextArray(
              // headers: tableHeaders,
              // data: tableData,
              data: [],
              border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
              headerStyle: pw.TextStyle(
                fontSize: 10,
              ),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              // cellHeight: 12.0,
              cellStyle: pw.TextStyle(
                fontSize: 8,
              ),
              cellAlignments: {
                // 0: pw.Alignment.center,
                // 1: pw.Alignment.center,
                // 2: pw.Alignment.center,
                //   3: pw.Alignment.center,
                //   4: pw.Alignment.center,
                //   5: pw.Alignment.center,
                //   6: pw.Alignment.center,
                //   7: pw.Alignment.center,
                //   8: pw.Alignment.center,
                //   9: pw.Alignment.center,
                //   10: pw.Alignment.center,
                //   11: pw.Alignment.center,
                //   12: pw.Alignment.center,
                //   13: pw.Alignment.center,
                //   14: pw.Alignment.center,
                //   15: pw.Alignment.center,
                //   16: pw.Alignment.center,
                //   17: pw.Alignment.center,
                //   18: pw.Alignment.center,
                //   19: pw.Alignment.center,
                //   20: pw.Alignment.center,
              },
              columnWidths: {
                // 0: pw.FlexColumnWidth(.2),
                // 1: pw.FlexColumnWidth(.3),
                // 2: pw.FlexColumnWidth(.3),
                // 3: pw.FlexColumnWidth(.35),
                // 4: pw.FlexColumnWidth(.35),
                // 5: pw.FlexColumnWidth(.25),
                // 6: pw.FlexColumnWidth(.25),
                // 7: pw.FlexColumnWidth(.23),
                // 8: pw.FlexColumnWidth(.25),
                // 9: pw.FlexColumnWidth(.2),
                // 10: pw.FlexColumnWidth(.2),
                // 11: pw.FlexColumnWidth(.2),
                // 12: pw.FlexColumnWidth(.2),
              },
            ),
            // pw.Divider(),
          ];
        },
      ),
    );

    return PdfFileHandle.saveDocument(
        name: '${filterBillList.customerName}.pdf', pdf: pdf);
  }
}
