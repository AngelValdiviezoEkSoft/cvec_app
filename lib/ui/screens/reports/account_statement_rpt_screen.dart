import 'dart:typed_data';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/date_symbol_data_local.dart';
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

Future<Uint8List> accountStatementRpt(List<CustomerStatementItem> items) async {
  final dateFormat = DateFormat('dd/MM/yyyy');
  initializeDateFormatting('es');
  final agrupado = agruparPorContrato(items);
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        final widgets = <pw.Widget>[];

        // Encabezado
        widgets.add(pw.Text(
          locGen!.accountStatusReportLbl,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ));
        
        widgets.add(pw.SizedBox(height: 10));

        widgets.add(pw.Text(
          '${locGen!.customerLbl}: ${items.isNotEmpty ? items.first.partnerName : ""}',
          style: const pw.TextStyle(fontSize: 14),
        ));

        widgets.add(pw.SizedBox(height: 20));

        for (var entry in agrupado.entries) {
          final first = entry.value.first;

          final tableRows = entry.value.map((item) => [
                dateFormat.format(DateTime.parse(item.quotaDueDate)),
                item.quotaName,
                item.quotaAmount.toStringAsFixed(2),
                item.quotaState.toLowerCase() == "open"
                    ? locGen!.stateOpenQuotaAccountStatementLbl
                    : item.quotaState.toLowerCase() == "paid"
                        ? locGen!.statePaidQuotaAccountStatementLbl
                        : locGen!.stateAnnulledQuotaAccountStatementLbl,
                item.paymentSequence,
                item.paymentMethodName,
                item.paymentAmount?.toStringAsFixed(2) ?? "-",
                item.quotaResidual?.toStringAsFixed(2) ?? "-",
                item.paymentDate.isNotEmpty
                    ? dateFormat.format(DateTime.parse(item.paymentDate))
                    : "-",
                item.paymentState.toLowerCase() == "posted"
                    ? locGen!.statePaidQuotaAccountStatementLbl
                    : "",
              ]).toList();

          final chunks = chunkList(tableRows, 40);

          // Título del contrato
          widgets.add(pw.Text(
            '${first.contractName} - ${first.planName} - ${first.contractState == "open" ? locGen!.stateActiveLbl : locGen!.stateFinishedLbl}',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ));

          widgets.add(pw.SizedBox(height: 5));

          // Cada bloque como tabla independiente
          for (var chunk in chunks) {
            widgets.add(
              pw.TableHelper.fromTextArray(
                headers: [
                  locGen!.dueDateLbl,
                  locGen!.descriptionLbl,
                  locGen!.installmentAmountLbl,
                  locGen!.installmentStatusLbl,
                  locGen!.receiptLbl,
                  locGen!.paymentMethodLbl,
                  locGen!.amountPaidLbl,
                  locGen!.balanceLbl,
                  locGen!.paymentDateLbl,
                  locGen!.paymentStatusLbl
                ],
                data: chunk,
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
                border: pw.TableBorder.all(color: PdfColors.grey),
                cellAlignment: pw.Alignment.centerLeft,
                cellStyle: const pw.TextStyle(fontSize: 6),
                 cellAlignments: {
                  0: pw.Alignment.centerLeft,   // Fecha
                  1: pw.Alignment.centerLeft,   // Descripción
                  2: pw.Alignment.centerRight,  // Monto cuota
                  3: pw.Alignment.centerLeft,   // Estado cuota
                  4: pw.Alignment.centerLeft,   // Recibo
                  5: pw.Alignment.centerLeft,   // Método pago
                  6: pw.Alignment.centerRight,  // Monto pagado
                  7: pw.Alignment.centerRight,  // Saldo
                  8: pw.Alignment.centerLeft,   // Fecha pago
                  9: pw.Alignment.centerLeft,   // Estado pago
                },
              ),
            );

            widgets.add(pw.SizedBox(height: 15));
            
          }

          widgets.add(pw.SizedBox(height: 20));
        }

        return widgets;
      },
    ),
  );

  return pdf.save();
}


List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
  List<List<T>> chunks = [];
  for (var i = 0; i < list.length; i += chunkSize) {
    chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
  }
  return chunks;
}
