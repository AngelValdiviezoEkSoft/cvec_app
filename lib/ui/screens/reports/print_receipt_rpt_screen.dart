//import 'dart:convert';
import 'dart:typed_data';
//import 'package:cve_app/domain/domain.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:pdf/widgets.dart';
//import 'dart:io';
//import 'package:http/http.dart' as http;
//import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
//import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

bool varTieneCorreoRecibo = false;
String rolPagoPeriodoRecibo = '';
String subTotalReceipt = '';
double expenses = 0;

Map<String, List<PagoItem>> agruparPorRubro(List<PagoItem> items) {
  final Map<String, List<PagoItem>> agrupado = {};

  for (var item in items) {
    agrupado.putIfAbsent(item.descRubro, () => []);
    if(agrupado[item.descRubro] != null){
      agrupado[item.descRubro]!.add(item);
    }
    
  }

  return agrupado;
}

Future<Uint8List> printReceiptRpt(Payment objPayment, List<PaymentLine> detRpt) async {

  final imageFirma = MemoryImage(
    (await rootBundle.load('assets/images/imgFirmaMZ.png')).buffer.asUint8List()
  );

  final imageLogo = MemoryImage(
    (await rootBundle.load('assets/logo_empresa_desc.png')).buffer.asUint8List()
  );

  List<PagoItem> items = [];
  double subTot = 0;

  if(detRpt.isNotEmpty) {
    for(int i = 0; i < detRpt.length; i++){
      var amount = detRpt[i].lineAmount?.toStringAsFixed(2) ?? 0;


      if(detRpt[i].quotaCode != 'CPT'){
        subTot = subTot + (detRpt[i].lineAmount ?? 0);

        items.add(
          PagoItem(
            descRubro: detRpt[i].contractName ?? '',//'CVE09MPME-026212',
            rubro: detRpt[i].quotaType ?? '',//'CT',
            descripcion: detRpt[i].quotaName ?? '',//'CT 06/24',          
            pagado: '\$ $amount'//'\$ 74.01',
          ),
        );

      }
      else {
        expenses = expenses + (detRpt[i].lineAmount ?? 0);
      }
      
    }

    subTotalReceipt = subTot.toStringAsFixed(2);
  }

  final agrupado = agruparPorRubro(items);

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      margin: const pw.EdgeInsets.all(24),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                Container(
                  height: 95,
                  width: 160,
                  child: Image(imageLogo),              
                ),
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.SizedBox(height: 15),
            pw.Center(
              child: pw.Text(objPayment.companyStreet,//'Calle Aguirre 411 entre Chile y Chimborazo',
              style: const pw.TextStyle(
                  fontSize: 7
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(objPayment.companyStreet2,//'Edif. C.C Unicentro 2do Piso Of. #211',
              style: const pw.TextStyle(
                  fontSize: 7
                ),
              ),
            ),
            pw.Center(
              child: pw.Text('${locGen!.phoneLbl}: ${objPayment.companyPhone}',
              style: const pw.TextStyle(
                  fontSize: 7
                ),
              ),
            ),
            pw.Center(
              child: 
                RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Web:',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 7,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: ' ${objPayment.companyWebsite}',
                      style: pw.TextStyle(
                        color: PdfColors.blue,
                        fontSize: 7,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(objPayment.countryName, style: const pw.TextStyle(
                        fontSize: 6
                      ),),
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('${locGen!.establishmentLbl}: ${locGen!.officeLbl}', style: const pw.TextStyle(
                        fontSize: 6
                      ),),
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('${locGen!.receiptLbl} # ${objPayment.paymentName}', style: const pw.TextStyle(
                        fontSize: 6
                      ),),
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),

            pw.SizedBox(height: 10),
            pw.Divider(),

            pw.Text('${locGen!.customerLbl}: ${objPayment.customerName}', style: const pw.TextStyle(fontSize: 6),),
            pw.Text('${locGen!.dateLbl}: ${objPayment.paymentDate}', style: const pw.TextStyle(fontSize: 6),),
            
            pw.SizedBox(height: 2),
            pw.Divider(),

            // Tabla agrupada
            pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(3),
                1: const pw.FlexColumnWidth(4),
                2: const pw.FlexColumnWidth(2),
              },
              //border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Text(locGen!.categoryLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Text(locGen!.descriptionLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Text(locGen!.paidLbl, textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                    ),
                  ],
                ),
                // Filas agrupadas por Rubro
                ...agrupado.entries.expand((entry) {
                  final rubro = entry.key;
                  final rows = entry.value;
                  
                  return [
                    // Fila de rubro
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(rubro, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),                          
                        ),
                        pw.Container(),
                        pw.Container(),
                      ],
                    ),
                    // Filas de descripción
                    ...rows.map((item) => 
                    
                    pw.TableRow(
                          children: [
                            if(item.rubro.isNotEmpty)
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(1),
                              child: pw.Text(item.rubro, style: const pw.TextStyle(fontSize: 6)),
                            ),                            
                            if(item.rubro.isNotEmpty)
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(1),
                              child: pw.Text(item.descripcion, style: const pw.TextStyle(fontSize: 6)),
                            ),
                            if(item.rubro.isNotEmpty)
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(1),
                              child: pw.Text(item.pagado, textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                            ),
                          ],
                        ))
                  ];
                }).toList()
              ],
            ),

            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Text('${locGen!.paymentMethodLbl}: ${objPayment.journalName}', style: const TextStyle(fontSize: 6)),
            pw.SizedBox(height: 2),
            
            Container(
                width: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                    width: 107,
                    height: 10,
                    child: pw.Text('Subtotal:', style: const TextStyle(fontSize: 7)),
                  ),
                  
                  Container(
                    width: 70,
                    height: 10,                    
                    child: pw.Text('\$$subTotalReceipt', style: const TextStyle(fontSize: 7), textAlign: TextAlign.right),
                  ),
                ]
              )
            ),

            if(expenses != 0)
            Container(
              width: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: 107,
                  height: 10,
                  child: pw.Text(locGen!.adminServLbl, style: const TextStyle(fontSize: 7)),
                ),
                
                Container(
                  width: 70,
                  height: 10,
                  child: pw.Text('\$${expenses.toStringAsFixed(2)}', style: const TextStyle(fontSize: 7), textAlign: TextAlign.right),
                ),
              ]
            )
          ),

            Container(
              width: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  width: 107,
                  height: 10,
                  child: pw.Text('Total:', style: const TextStyle(fontSize: 7)),
                ),
                
                Container(
                  width: 70,
                  height: 10,
                  child: pw.Text('\$${objPayment.paymentAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 7), textAlign: TextAlign.right),
                ),
              ]
            )
          ),

            pw.SizedBox(height: 10),
            pw.Text('${locGen!.observationLbl}: ${objPayment.paymentRef}', style: const TextStyle(fontSize: 7)),
            pw.SizedBox(height: 10),
            
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        child: Image(imageFirma),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(0, 1, 0, 0)),
                      Text(
                        locGen!.authSignatLbl,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 6)
                      ),                    
                    ]
                  )
                ),

                Container(
                  width: 80,
                  child: Column(children: [
                    Container(
                      height: 150,
                      width: 200,
                      child: Image(imageFirma),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 1, 0, 0)),
                    Text(
                      locGen!.clientSignatLbl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 6
                      )
                    ),
                    
                  ]
                )
                ),

              ],
            ),

            pw.SizedBox(height: 10),
            pw.Text(
              '${locGen!.persRespAdmLbl}: ${objPayment.userName}', 
              style: const pw.TextStyle(fontSize: 6),
            ),
            pw.Text(locGen!.thkYourPaymentLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
