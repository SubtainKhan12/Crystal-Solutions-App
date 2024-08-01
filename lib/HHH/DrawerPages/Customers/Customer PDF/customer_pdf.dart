import 'dart:io';
import 'package:pdf/pdf.dart';
import 'pdf_file_handle.dart';
import 'package:pdf/widgets.dart'as pw;
import '../../../../Model/Customers/GetCustomersModel.dart';

class Customer_PDF {
  static Future<File> generate(List<GetCustomersModel> getCustomersModel) async {

    final pdf = pw.Document(
      // pageMode: PdfPageMode.fullscreen,
    );

    final tableHeaders = [
      'Sr',
      'DSC',
      'Cnt p',
      'Mobile',
      'Phone',
      'Add 1',
      'Add 2',
      'Email',
      'Shops',
      'Srv',
      'SMS',
      'Adv',
      'POS',
      'Monthly',
      'Total',
      'Ref#',
      'Type',
      'Clctr',
      'City',
      'Srv IP',
      'Status',
    ];
    final tableData = [
      for (int i = 0; i < getCustomersModel.length; i++)
        [
          i + 1,
          getCustomersModel[i].tCstDsc.toString().trim(),
          getCustomersModel[i].tCntPer.toString().trim(),
          getCustomersModel[i].tMobNUm.toString().trim(),
          getCustomersModel[i].tPhnNum.toString(),
          getCustomersModel[i].tAdd001.toString(),
          getCustomersModel[i].tAdd002.toString(),
          getCustomersModel[i].tEmlAdd.toString(),
          getCustomersModel[i].tShpNum.toString(),
          getCustomersModel[i].tsrvchg.toString(),
          getCustomersModel[i].tsmschg.toString(),
          getCustomersModel[i].tadvchg.toString(),
          getCustomersModel[i].tposchg.toString(),
          getCustomersModel[i].tmthChg.toString(),
          getCustomersModel[i].ttotamt.toString(),
          getCustomersModel[i].tRefId.toString(),
          getCustomersModel[i].tTypId.toString(),
          getCustomersModel[i].tColId.toString(),
          getCustomersModel[i].tctyid.toString(),
          getCustomersModel[i].tSrvIp.toString(),
          getCustomersModel[i].tCstSts.toString(),
        ],
    ];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        margin:
        const pw.EdgeInsets.only(left: 25, right: 25, bottom: 0, top: 0),
        header: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Center(
                child: pw.Text(
                  'Crystal Solutions',
                  style: pw.TextStyle(
                      fontSize: 25,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.deepOrange),
                ),
              ),
              pw.Divider(thickness: 2),
            ],
          );
        },
        build: (context) {
          return [
            pw.TableHelper.fromTextArray(
              headers: tableHeaders,
              data: tableData,
              border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
              headerStyle: pw.TextStyle(fontSize: 10,),
              headerDecoration:
              const pw.BoxDecoration(color: PdfColors.grey300),
              // cellHeight: 12.0,
              cellStyle: pw.TextStyle(fontSize: 8,),
              cellAlignments: {
                0: pw.Alignment.center,
                1: pw.Alignment.center,
                2: pw.Alignment.center,
                3: pw.Alignment.center,
                4: pw.Alignment.center,
                5: pw.Alignment.center,
                6: pw.Alignment.center,
                7: pw.Alignment.center,
                8: pw.Alignment.center,
                9: pw.Alignment.center,
                10: pw.Alignment.center,
                11: pw.Alignment.center,
                12: pw.Alignment.center,
                13: pw.Alignment.center,
                14: pw.Alignment.center,
                15: pw.Alignment.center,
                16: pw.Alignment.center,
                17: pw.Alignment.center,
                18: pw.Alignment.center,
                19: pw.Alignment.center,
                20: pw.Alignment.center,
              },
              columnWidths: {
                0: pw.FlexColumnWidth(.2),
                1: pw.FlexColumnWidth(.3),
                2: pw.FlexColumnWidth(.3),
                3: pw.FlexColumnWidth(.35),
                4: pw.FlexColumnWidth(.35),
                5: pw.FlexColumnWidth(.25),
                6: pw.FlexColumnWidth(.25),
                7: pw.FlexColumnWidth(.23),
                8: pw.FlexColumnWidth(.25),
                9: pw.FlexColumnWidth(.2),
                10: pw.FlexColumnWidth(.2),
                11: pw.FlexColumnWidth(.2),
                12: pw.FlexColumnWidth(.2),
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