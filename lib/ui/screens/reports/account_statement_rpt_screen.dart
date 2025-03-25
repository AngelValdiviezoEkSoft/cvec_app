import 'dart:convert';
import 'dart:typed_data';
import 'package:cve_app/domain/domain.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

bool varTieneCorreo = false;
String rolPagoPeriodoGen = '';

Future<Uint8List> accountStatementRpt(AccountStatementModel rolDePago, String correo, String periodoDesc, String periodo) async {
  rolPagoPeriodoGen = periodoDesc;
  final String endPoint = '';//CadenaConexion().apiUtilsEndpoint;
  varTieneCorreo = correo != '';
  initializeDateFormatting('es');
  final DateTime now = DateTime.now();
  final String formatter = DateFormat('dd-MM-yyyy').format(now);

  final pdf = Document();
  String? observacion;
  final imageFirma = MemoryImage(
      (await rootBundle.load('assets/images/imgFirmaMZ.png')).buffer.asUint8List());
  
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
      pw.MultiPage(
        //pageFormat: format,
        build: (context) => [
          pw.Text('REPORTE DE ESTADOS DE CUENTA',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text('Cliente: MAYA CALDERON CRISTHIAN ESLAN'),
          pw.Text('Tipo: Cuotas y gastos administrativos'),
          pw.SizedBox(height: 10),

          // Grupo 1
          pw.Text('CVECAD-018749 - Casa Adjudicada - Activo',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
          pw.SizedBox(height: 5),
          _buildTable([
            _headerRow(),
            _row(['05/11/2022', 'CVECAD-018749 AN', 'ANT', '750.00', 'Pagada', '000081', 'CRUCE - REGA', '2750.00', '0.00', '09/01/2023', 'Pagado']),
            _row(['30/11/2022', 'CVECAD-018749 OFE', 'OFE', '2750.00', 'Pagada', '010330', 'TARJETA CAPI', '38.71', '0.00', '30/11/2022', 'Pagado']),
            _row(['05/01/2022', 'CVECAD-018749 RTC', 'RTC', '20.65', 'Pagada', '003357', 'TARJETA INTEI', '20.65', '0.00', '05/01/2022', 'Pagado']),
            _row(['07/06/2023', 'CVECAD-018749 RTC', 'RTC', '20.65', 'Pagada', '003870', 'TARJETA INTEI', '20.65', '0.00', '07/06/2023', 'Pagado']),
            _row(['17/07/2023', 'CVECAD-018749 RTC', 'RTC', '20.65', 'Pagada', '004337', 'TARJETA INTEI', '20.65', '0.00', '17/07/2023', 'Pagado']),
          ]),

          pw.SizedBox(height: 15),
          pw.Text('CVEINSPCASAS-000003 - Inspección de Construcción de Vivienda - Terminado',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
          pw.SizedBox(height: 5),
          _buildTable([
            _headerRow(),
            _row(['05/10/2022', 'CVEINSPCASAS-0001 CT', 'CT', '200.00', 'Pagada', '009235', 'EFECTIVO JOR', '200.00', '0.00', '20/10/2022', 'Pagado']),
          ]),

          pw.SizedBox(height: 15),
          pw.Text('CVE09MALI-21201 - Plan Alícuotas - Terminado',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
          pw.SizedBox(height: 5),
          _buildTable([
            _headerRow(),
            _row(['15/11/2021', 'CVE09MALI-21201 CT', 'CT', '20.00', 'Pagada', '002458', 'EFECTIVO WEI', '20.00', '0.00', '30/11/2021', 'Pagado']),
            _row(['05/12/2021', 'CVE09MALI-21201 CT', 'CT', '20.00', 'Pagada', '002890', 'EFECTIVO WEI', '20.00', '0.00', '13/12/2021', 'Pagado']),
            _row(['05/01/2022', 'CVE09MALI-21201 CT', 'CT', '18.00', 'Pagada', '003883', 'EFECTIVO WEI', '18.00', '0.00', '31/01/2022', 'Pagado']),
            _row(['05/02/2022', 'CVE09MALI-21201 CT', 'CT', '18.00', 'Pagada', '004015', 'EFECTIVO WEI', '18.00', '0.90', '19/10/2022', 'Pagado']),
            _row(['05/03/2022', 'CVE09MALI-21201 CT', 'CT', '20.00', 'Pagada', '005163', 'EFECTIVO WEI', '8.00', '12.00', '26/02/2022', 'Pagado']),
          ]),
        ],
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

  if (varTieneCorreo) certificadoAE();

  return pdf.save();

}

  List<String> _headerRow() => [
        'Fecha venc.',
        'Descripción',
        'Tipo',
        'Valor cuota',
        'Estado cuota',
        'Recibo',
        'Forma pago',
        'Valor pagado',
        'Saldo',
        'Fecha pago',
        'Estado pago',
      ];

  List<String> _row(List<String> data) => data;

  pw.Widget _buildTable(List<List<String>> rows) {
    return pw.Table.fromTextArray(
      headers: rows.first,
      data: rows.sublist(1),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
      cellStyle: const pw.TextStyle(fontSize: 6),
      cellAlignment: pw.Alignment.centerLeft,
      border: pw.TableBorder.all(width: 0.5),
      columnWidths: {
        0: const pw.FixedColumnWidth(55),
        1: const pw.FixedColumnWidth(90),
        2: const pw.FixedColumnWidth(35),
        3: const pw.FixedColumnWidth(50),
        4: const pw.FixedColumnWidth(50),
        5: const pw.FixedColumnWidth(50),
        6: const pw.FixedColumnWidth(60),
        7: const pw.FixedColumnWidth(55),
        8: const pw.FixedColumnWidth(40),
        9: const pw.FixedColumnWidth(55),
        10: const pw.FixedColumnWidth(50),
      },
    );
  }
