
import 'dart:typed_data';
import 'package:cve_app/domain/domain.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> generateReservation(Booking objReservation) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Reporte de Reservas', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 53,
                      alignment: pw.Alignment.center,                      
                      child: pw.Text('Secuencia de reserva', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text('Fecha de ingreso', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text('Fecha de salida', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text('Hotel', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text('Reserva incluye', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    pw.Container(
                      width: 55,
                      alignment: pw.Alignment.center,
                      child: pw.Text('Secuencia de contrato', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text('Habitaciones', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text('Estado', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 5)),
                    ),
                    
                  ],
                ),
                ...[ 
                  [objReservation.name, objReservation.dateBookingsStart, objReservation.dateBookingsEnd, objReservation.tradeNameHotel, objReservation.personInclude, objReservation.subscriptionName, objReservation.roomInclude, objReservation.state],                  
                ].map((row) => pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: row.map(
                      (cell) => 
                      pw.Container(
                        width: 50,
                        alignment: pw.Alignment.center,
                        child: pw.Text(cell, style: const TextStyle(fontSize: 5))
                      ),
                      
                    ).toList(),
                  ),
                
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }