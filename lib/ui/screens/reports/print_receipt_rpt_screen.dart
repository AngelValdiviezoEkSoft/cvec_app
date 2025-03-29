//import 'dart:convert';
import 'dart:typed_data';
//import 'package:cve_app/domain/domain.dart';
//import 'package:path_provider/path_provider.dart';
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
/*
Future<Uint8List> printReceiptRpt(AccountStatementModel rolDePago, String correo, String periodoDesc, String periodo) async {
  rolPagoPeriodoRecibo = periodoDesc;
  final String endPoint = '';//CadenaConexion().apiUtilsEndpoint;
  varTieneCorreoRecibo = correo != '';
  initializeDateFormatting('es');
  final DateTime now = DateTime.now();
  final String formatter = DateFormat('dd-MM-yyyy').format(now);

  final pdf = Document();
  String? observacion;
  final imageFirma = MemoryImage(
    (await rootBundle.load('assets/images/imgFirmaMZ.png')).buffer.asUint8List()
  );
  
  observacion = rolDePago.cabeceraRol?.observacion;
/*
  if (rolDePago.observacion == null) {
    observacion = '';
  } else {
    observacion = rolDePago.cabeceraRol?.observacion;
  }
  */

  Widget renderIngresos() {
    return ListView(
      children: rolDePago.listaIngresos!
          .map(
            (item) => Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(item.descripcion,
                          style: const TextStyle(fontSize: 6)
                        )
                      )
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(item.cantidad!.toStringAsFixed(2),
                                style: const TextStyle(fontSize: 6)))),
                    Expanded(
                        child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(item.valor!.toStringAsFixed(2),
                                style: const TextStyle(fontSize: 6)))),
                  ]),
            ),
          )
          .toList(),
    );
  }

  Widget renderEgresos() {
    return ListView(
      children: rolDePago.listaEgresos!
          .map(
            (item) => Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(item.descripcion,
                                style: const TextStyle(fontSize: 6)))),
                    Expanded(
                        child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(item.cantidad!.toStringAsFixed(2),
                                style: const TextStyle(fontSize: 6)))),
                    Expanded(
                        child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(item.valor!.toStringAsFixed(2),
                                style: const TextStyle(fontSize: 6)))),
                  ]),
            ),
          )
          .toList(),
    );
  }

  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('Fecha: ',
                  style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
              Text(formatter, style: const TextStyle(fontSize: 7)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('Mes: ',
                  style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
              Text(periodo, style: const TextStyle(fontSize: 7)),
            ]),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ROL DE PAGO',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$rolPagoPeriodoRecibo ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Compañía: ',
                              style: TextStyle(
                                  fontSize: 7, fontWeight: FontWeight.bold)),
                          Text('${rolDePago.cabeceraRol?.empresa}',
                              style: const TextStyle(fontSize: 7)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('División: ',
                              style: TextStyle(
                                  fontSize: 7, fontWeight: FontWeight.bold)),
                          Text('${rolDePago.cabeceraRol?.division}',
                              style: const TextStyle(fontSize: 7)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Sucursal: ',
                              style: TextStyle(
                                  fontSize: 7, fontWeight: FontWeight.bold)),
                          Text('${rolDePago.cabeceraRol?.sucursal}',
                              style: const TextStyle(fontSize: 7)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${rolDePago.cabeceraRol?.apellidos} ${rolDePago.cabeceraRol?.nombres}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('Tipo Nómina',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        width: 50.0,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('Área',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: Text('Cargo',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.tipoNomina}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.area}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                      Container(
                        width: 150.0,
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.cargo}',
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontSize: 7)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30.0,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('Proceso',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('CCosto',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: Text('Sueldo',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.proceso}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                      Container(
                        width: 100.0,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.centroCosto}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                            '${rolDePago.cabeceraRol?.sueldo?.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 45.0,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('Periodo',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('SCosto',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: Text('Forma Pago',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.periodo}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.subCentroCosto}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: Text('${rolDePago.cabeceraRol?.tipoPago}',
                            style: const TextStyle(fontSize: 7)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('INGRESOS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 7)),
                  Text('EGRESOS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 7)),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  height: 200,
                  width: 241,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: Text('',
                                        style: const TextStyle(fontSize: 6)))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text('Cant',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold)))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text('Valor',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold)))),
                          ]),
                      renderIngresos(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: Text('',
                                        style: const TextStyle(fontSize: 6)))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text('Total Ingresos:',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold)))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                        '${rolDePago.totalIngresos?.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold)))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  height: 200,
                  width: 241,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  0,
                                ),
                                child: Text('',
                                    style: const TextStyle(fontSize: 6)))),
                        Expanded(
                            child: Container(
                                alignment: Alignment.bottomRight,
                                child: Text('Cant',
                                    style: TextStyle(
                                        fontSize: 6,
                                        fontWeight: FontWeight.bold)))),
                        Expanded(
                            child: Container(
                                alignment: Alignment.bottomRight,
                                child: Text('Valor',
                                    style: TextStyle(
                                        fontSize: 6,
                                        fontWeight: FontWeight.bold)))),
                      ]),
                      renderEgresos(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: Text('',
                                        style: const TextStyle(fontSize: 6)))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text('Total Egresos:',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold)))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                        '${rolDePago.totalEgresos?.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold)))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Neto a pagar: ${rolDePago.netoPagar}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              width: 482,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Text(
                    '    Observación : $observacion',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      width: 120,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide())),
                    ),
                    Text(
                      'FIRMA DEL EMPLEADO',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 7),
                    ),
                  ]),
                  Container(
                      width: 120,
                      // decoration: const BoxDecoration(
                      //     border: Border(top: BorderSide())),
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
                            '${rolDePago.cabeceraRol?.encargadoCoporativoRRHH}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 7)),
                        Text('${rolDePago.cabeceraRol?.cargoCorporativoRRHH}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 7)),
                      ])),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  final bytes = await pdf.save();
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/rolpago.pdf');
  await file.writeAsBytes(bytes);
  
  List<int> documento = file.readAsBytesSync();
  
  String base64documento = base64Encode(documento);
  
  void certificadoAE() async {
    var url = Uri.parse("${endPoint}Notificaciones/SendEmail");
    var _ = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "para": correo,
          "alias": rolDePago.cabeceraRol!.nombres!,
          "plantilla": "DocEmpleado",
          "archivoBase64": base64documento,
          "nombreArchivo": "rol_de_pago.pdf",
          "asunto": "Rol de Pago"
        }));
  }

  if (varTieneCorreoRecibo) certificadoAE();

  return pdf.save();
}
*/
Future<Uint8List> printReceiptRpt() async {
  final imageFirma = MemoryImage(
    (await rootBundle.load('assets/images/imgFirmaMZ.png')).buffer.asUint8List()
  );

  final imageLogo = MemoryImage(
    (await rootBundle.load('assets/logo_app_pequenio.png')).buffer.asUint8List()
  );

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            /*
            pw.Center(
              child: pw.Text(
                'Centro de Viajes Ecuador',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
            ),
            */
            
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
              child: pw.Text('Calle Aguirre 411 entre Chile y Chimborazo',
              style: const pw.TextStyle(
                        fontSize: 9
                      ),),
            ),
            pw.Center(
              child: pw.Text('Edif. C.C Unicentro 2do Piso Of. #211',
              style: const pw.TextStyle(
                        fontSize: 9
                      ),),
            ),
            pw.Center(
              child: pw.Text('Telfs: 6000575-579',
              style: const pw.TextStyle(
                        fontSize: 9
                      ),),
            ),
            pw.Center(
              child: //pw.Text('Web: www.centrodeviajesecuador.com'),
                RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Web:',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: ' www.centrodeviajesecuador.com',
                      style: pw.TextStyle(
                        color: PdfColors.blue,
                        fontSize: 9,
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
                pw.Text('Ecuador', style: const pw.TextStyle(
                        fontSize: 8
                      ),),
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('ESTABLECIMIENTO: OFICINA', style: const pw.TextStyle(
                        fontSize: 8
                      ),),
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('RECIBO # 077872', style: const pw.TextStyle(
                        fontSize: 8
                      ),),
                pw.Text(' ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),

            pw.SizedBox(height: 10),
            pw.Divider(),
            pw.Text('Cliente: BENIGNO VICTORIANO GUSTAVO', style: const pw.TextStyle(
                        fontSize: 8
                      ),),
            pw.Text('Fecha: 25/03/2025', style: const pw.TextStyle(
                        fontSize: 8
                      ),),
            pw.SizedBox(height: 10),
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Rubro', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                    pw.Text('Descripción', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                    pw.Text('Pagado', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                  ],
                ),
                pw.Divider(),
                ...[ // Datos de la tabla sin bordes
                  ['CVE09M', 'PID-033463', ''],
                  ['GAD', '07/12', '\$1.00'],
                  ['CT', '07/12', '\$30.36'],
                  ['CT', '08/12', '\$0.96'],
                  ['CVE09M', 'PME-026212' '', ''],
                  ['GAD ', '06/24', '\$3.70'],
                  ['CT', '06/24', '\$74.01'],
                  ['CVE09M', 'PTE-024984', ''],
                  ['GAD', '24/72', '\$4.28'],
                  ['CT', '24/72', '\$85.69'],
                ].map((row) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: row.map((cell) => pw.Text(cell, style: const TextStyle(fontSize: 5))).toList(),
                  ),
                )),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Text('Forma de pago: BANCO PACIFICO CTA. CTE. #7718799', style: const TextStyle(fontSize: 6)),
            pw.Text('Subtotal: \$200.00', style: const TextStyle(fontSize: 7)),
            pw.Text('Total: \$200.00', style: const TextStyle(fontSize: 7)),
            pw.SizedBox(height: 10),
            pw.Text('Observación:', style: const TextStyle(fontSize: 7)),
            pw.SizedBox(height: 10),
            
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
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
                        'Firma Autorizada',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 7)),
                    
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
                        'Firma Cliente',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 7)),
                    
                  ]
                )
                ),

              ],
            ),

            pw.SizedBox(height: 10),
            pw.Text('Responsable Ingreso: RENDON SUAREZ ANA RAQUEL', style: const pw.TextStyle(
                        fontSize: 7
                      ),),
            pw.Text('GRACIAS POR SU PAGO', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
