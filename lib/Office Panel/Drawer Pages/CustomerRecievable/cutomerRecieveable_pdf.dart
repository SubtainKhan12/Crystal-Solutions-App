import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../HHH/DrawerPages/Customers/Customer PDF/pdf_file_handle.dart';

import '../../../Model/CustomerRecieveable/CustomerReceivableModel.dart';

class CustomerRecieveable_Pdf {
  static Future<File> generate(CustomerReceivableModel? customerReceivableModel,
      selectedInitialDate, selectedFinalDate) async {
    final pdf = pw.Document();
    final numberFormat = NumberFormat('#,###');
    String formatCollection(String amount) {
      final doubleAmount = double.tryParse(amount) ?? 0.00;
      return numberFormat.format(doubleAmount);
    }

    final tableHeaders = [
      'Sr',
      'Code',
      'Description',
      'Bill Amount',
      'Col Amount',
      'Balance',
      '',
    ];
    final tableData = [
      for (int i = 0; i < customerReceivableModel!.detail!.length; i++)
        [
          i + 1,
          customerReceivableModel.detail![i].code.toString().trim(),
          customerReceivableModel.detail![i].customer.toString().trim(),
          formatCollection(
              customerReceivableModel.detail![i].billAmt.toString().trim()),
          formatCollection(
              customerReceivableModel.detail![i].collection.toString().trim()),
          formatCollection(
              customerReceivableModel.detail![i].balance.toString().trim()),
          '',
        ],
    ];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        margin:
            const pw.EdgeInsets.only(left: 25, right: 25, bottom: 40, top: 10),
        header: (context) {
          return pw.Stack(
            children: [
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'Crystal Solutions',
                  style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 25),
                child: pw.Center(
                  child: pw.Text(
                    'Customer Recieveable (${DateFormat('dd-MM-yyyy').format(selectedInitialDate)} To ${DateFormat('dd-MM-yyyy').format(selectedFinalDate)})',
                    style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
                  ),
                ),
              ),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 480, top: 10, bottom: 5),
                  child: pw.Container(
                      child: pw.Column(children: [
                    pw.Text(
                      '${DateFormat('dd-MM-yyyy').format(DateTime.now().toLocal())}',
                      style: pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Text(
                      '${DateFormat('HH:mm:ss').format(DateTime.now().toLocal())}',
                      style: pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text(
                      '${context.pageNumber} / ${context.pagesCount}',
                      style: pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.black,
                      ),
                    ),
                  ]))),
            ],
          );
        },
        build: (context) {
          return [
            pw.TableHelper.fromTextArray(
              cellHeight: 5,
              headers: tableHeaders,
              data: tableData,
              border: pw.TableBorder.all(width: 1.0, color: PdfColors.grey),
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
                0: pw.Alignment.center,
                1: pw.Alignment.center,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
                5: pw.Alignment.centerRight,
              },
              columnWidths: {
                0: pw.FlexColumnWidth(0.1),
                1: pw.FlexColumnWidth(0.1),
                2: pw.FlexColumnWidth(.4),
                3: pw.FlexColumnWidth(.15),
                4: pw.FlexColumnWidth(.15),
                5: pw.FlexColumnWidth(.15),
                6: pw.FlexColumnWidth(.15),
              },
            ),
            // pw.Divider(),
          ];
        },
      ),
    );

    return PdfFileHandle.saveDocument(name: 'Customers.pdf', pdf: pdf);
  }
}
