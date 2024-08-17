import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../HHH/DrawerPages/Customers/Customer PDF/pdf_file_handle.dart';
import '../../../Model/BillRegister/BillRegisterModel.dart';

class BillRegister_Pdf {
  static Future<File> generate(
    BillRegisterModel? billRegisterModel,
    selectedInitialDate,
    selectedFinalDate,
  ) async {
    final numberFormat = NumberFormat('#,###');
    String formatAmount(String amount) {
      final doubleAmount = double.tryParse(amount)?? 0.00;
      return numberFormat.format(doubleAmount);
    }
    final pdf = pw.Document();

    final tableHeaders = [
      'Sr',
      'Date',
      'Trn#',
      'Description',
      'Phone',
      'Srv',
      'Adv',
      'Mnthly',
      'SMS',
      'POS',
      'Other',
      'Amt',
      '',
    ];

    final tableData = [
      for (int i = 0; i < billRegisterModel!.detail!.length; i++)
        [
          i + 1,
          billRegisterModel.detail![i].date.toString().trim(),
          billRegisterModel.detail![i].trn.toString().trim(),
          billRegisterModel.detail![i].customer.toString().trim(),
          billRegisterModel.detail![i].mobile.toString().trim(),
          formatAmount(billRegisterModel.detail![i].srvChg.toString().trim()) == '0'
              ? ''
              : formatAmount(billRegisterModel.detail![i].srvChg.toString().trim()),
          formatAmount(billRegisterModel.detail![i].advance.toString().trim()) == '0'
              ? ''
              : formatAmount(billRegisterModel.detail![i].advance.toString().trim()),
          formatAmount(billRegisterModel.detail![i].monthly.toString().trim()) == '0'
              ? ''
              : formatAmount(billRegisterModel.detail![i].monthly.toString().trim()),
          formatAmount(billRegisterModel.detail![i].sms.toString().trim()) == '0'
              ? ''
              : formatAmount(billRegisterModel.detail![i].sms.toString().trim()),
          formatAmount(billRegisterModel.detail![i].pos.toString().trim()) == '0'
              ? ''
              : formatAmount(billRegisterModel.detail![i].pos.toString().trim()),
          formatAmount(billRegisterModel.detail![i].other.toString().trim()) == '0'
              ? ''
              : formatAmount(billRegisterModel.detail![i].other.toString().trim()),
          formatAmount(billRegisterModel.detail![i].amount.toString().trim()) == '0'
              ? ''
              : formatAmount(billRegisterModel.detail![i].amount.toString().trim()),
          '',
        ],

    ];
final totalRow = [
  '',
  '',
  '',
  'Total',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  billRegisterModel.totalAmount.toString(),
  '',
];
tableData.add(totalRow);
    const int rowsPerPage = 25;
    for (int i = 0; i < tableData.length; i += rowsPerPage) {
      final dataChunk = tableData.sublist(
        i,
        i + rowsPerPage > tableData.length ? tableData.length : i + rowsPerPage,
      );

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.landscape,
          margin:
              const pw.EdgeInsets.only(left: 30, right: 30, bottom: 40, top: 10),
          header: (context) {
            return pw.Stack(
              children: [
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'Crystal Solutions',
                    style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.black),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 25),
                  child: pw.Center(
                    child: pw.Text(
                      'Bill Register (${DateFormat('dd-MM-yyyy').format(selectedInitialDate)} To ${DateFormat('dd-MM-yyyy').format(selectedFinalDate)})',
                      style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.black),
                    ),
                  ),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 700, top: 10,bottom: 5),
                  child: pw.Container(
                      child: pw.Column(children: [
                        pw.Text(
                          '${DateFormat('dd-MM-yyyy').format(DateTime.now().toLocal())}',
                          style: pw.TextStyle(
                            fontSize: 9,
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
                      ]))
                ),
              ],
            );
          },
          build: (context) {
            return [
              pw.TableHelper.fromTextArray(
                cellHeight: 5,
                headers: tableHeaders,
                data: dataChunk,
                border: pw.TableBorder.all(width: 1.0, color: PdfColors.grey),
                headerStyle: pw.TextStyle(fontSize: 10),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellStyle: pw.TextStyle(fontSize: 8),
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.centerLeft,
                  4: pw.Alignment.centerRight,
                  5: pw.Alignment.centerRight,
                  6: pw.Alignment.centerRight,
                  7: pw.Alignment.centerRight,
                  8: pw.Alignment.centerRight,
                  9: pw.Alignment.centerRight,
                  10: pw.Alignment.centerRight,
                  11: pw.Alignment.centerRight,
                  12: pw.Alignment.centerRight,
                },
                columnWidths: {
                  0: pw.FlexColumnWidth(0.05),
                  1: pw.FlexColumnWidth(.1),
                  2: pw.FlexColumnWidth(.07),
                  3: pw.FlexColumnWidth(.38),
                  4: pw.FlexColumnWidth(.17),
                  5: pw.FlexColumnWidth(.09),
                  6: pw.FlexColumnWidth(.09),
                  7: pw.FlexColumnWidth(.09),
                  8: pw.FlexColumnWidth(.09),
                  9: pw.FlexColumnWidth(.09),
                  10: pw.FlexColumnWidth(.09),
                  11: pw.FlexColumnWidth(.09),
                  12: pw.FlexColumnWidth(.08),
                },
              ),
            ];
          },
        ),
      );
    }

    return PdfFileHandle.saveDocument(name: 'Customers.pdf', pdf: pdf);
  }

}
