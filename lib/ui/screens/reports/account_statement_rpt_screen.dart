import 'dart:convert';
import 'dart:typed_data';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
//import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
/*
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
*/
import 'package:pdf/widgets.dart' as pw;

bool varTieneCorreo = false;
String rolPagoPeriodoGen = '';
String cabecera = '';
int idTbl = 0;

Map<String, List<CustomerStatementItem>> agruparPorContrato(List<CustomerStatementItem> items) {
  final Map<String, List<CustomerStatementItem>> agrupado = {};

  for (var item in items) {
    var nombreAgrupado = '${item.contractName} - ${item.planName} - ${item.contractState}';

    agrupado.putIfAbsent(nombreAgrupado, () => []);

    if(agrupado[nombreAgrupado] != null){
      agrupado[nombreAgrupado]!.add(item);
    }
    
  }

  return agrupado;
}


//Future<Uint8List> accountStatementRpt(AccountStatementModel rolDePago, String correo, String periodoDesc, String periodo) async {
Future<Uint8List> accountStatementRpt(List<CustomerStatementItem> items) async {
  
  initializeDateFormatting('es');

  final agrupado = agruparPorContrato(items);

  final pdf = Document();

  pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('REPORTE DE ESTADOS DE CUENTA',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text('Cliente: $displayName'),
          //pw.Text('Tipo: Cuotas y gastos administrativos'),
          pw.SizedBox(height: 10),
/*
          pw.Table(
            columnWidths: {
              0: const pw.FixedColumnWidth(55),
            },
            border: pw.TableBorder.all(),
            children: [

              // Filas agrupadas por Rubro
              ...agrupado.entries.expand((entry) {
                final rubro = entry.key;

                return [
                  
                  pw.TableRow(
                    children: [
                      
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text(rubro, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                      ),                        
                      pw.Container(),
                      pw.Container(),
                    ],
                  ),
                
                ];
              }).toList()
            ],
          ),
*/
          // Tabla agrupada
          pw.Table(
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
              //11: const pw.FixedColumnWidth(50),
            },
            border: pw.TableBorder.all(),
            children: [

              // Filas agrupadas por Rubro
              ...agrupado.entries.expand((entry) {
                final rubro = entry.key;
                final rows = entry.value;

                if(cabecera != rubro){
                  cabecera = '';
                  cabecera = rubro;
                }

                cabecera = rubro;

                idTbl = idTbl + 1;
                
                return [
                  
                  pw.TableRow(
                    children: [
                      /*
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("ID", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      */
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Fecha venc.", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Descripción", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Tipo", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Valor cuota", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Estado cuota", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Recibo", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Forma pago", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Valor pagado", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Saldo", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text("Fecha pago", textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text('Estado pago', textAlign: TextAlign.end, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      ),
                    ],
                  ),
                  
                  ...rows.map((item) => 

                  pw.TableRow(
                      children: [
                        /*
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text('$idTbl', style: const pw.TextStyle(fontSize: 6)),
                        ),
                        */
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.quotaDueDate, style: const pw.TextStyle(fontSize: 6)),
                        ),
                        //if(item.rubro.isNotEmpty)
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.quotaName, textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text('ANT', textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.quotaAmount.toStringAsFixed(2), textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.quotaState, textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.paymentSequence, textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.paymentMethodName, textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text('${item.paymentAmount?.toStringAsFixed(2)}', textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text('${item.quotaResidual?.toStringAsFixed(2)}', textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.paymentDate, textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.paymentState, textAlign: TextAlign.end, style: const pw.TextStyle(fontSize: 6,)),
                        ),
                      ],
                    )
                  )
                ];
              }).toList()
            ],
          ),

/*
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
        */
        ],
      ),
    );

  final bytes = await pdf.save();
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/rolpago.pdf');
  await file.writeAsBytes(bytes);
  
  //List<int> documento = file.readAsBytesSync();
  
  //String base64documento = base64Encode(documento);
  
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
