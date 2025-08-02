
import 'dart:typed_data';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

/*
Future<Uint8List> generateReservation(Booking objReservation) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(locGen!.reservReportLbl, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 53,
                      alignment: pw.Alignment.center,                      
                      child: pw.Text(locGen!.reservSeqLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text(locGen!.checkInDateLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text(locGen!.checkOutDateLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text(locGen!.hotelLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text(locGen!.includesLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    pw.Container(
                      width: 55,
                      alignment: pw.Alignment.center,
                      child: pw.Text(locGen!.contractSeqLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text(locGen!.roomsLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    pw.Container(
                      width: 48,
                      alignment: pw.Alignment.center,
                      child: pw.Text(locGen!.statusLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6)),
                    ),
                    
                  ],
                ),
                ...[ 
                  [objReservation.bookingName, objReservation.bookingDateCheckIn, objReservation.bookingEndCheckIn, objReservation.bookingHotelName, objReservation.bookingContent, objReservation.contractName, objReservation.bookingContent, objReservation.bookingState],
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
*/

Future<Uint8List> generateReservation(List<Booking> reservations) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              locGen!.reservReportLbl,
              style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: pw.FixedColumnWidth(53),
                1: pw.FixedColumnWidth(48),
                2: pw.FixedColumnWidth(48),
                3: pw.FixedColumnWidth(48),
                4: pw.FixedColumnWidth(48),
                5: pw.FixedColumnWidth(55),
                6: pw.FixedColumnWidth(48),
                //7: pw.FixedColumnWidth(48),
              },
              children: [
                // Fila de encabezado
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Center(child: pw.Text(locGen!.reservSeqLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                    pw.Center(child: pw.Text(locGen!.checkInDateLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                    pw.Center(child: pw.Text(locGen!.checkOutDateLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                    pw.Center(child: pw.Text(locGen!.hotelLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                    pw.Center(child: pw.Text(locGen!.includesLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                    pw.Center(child: pw.Text(locGen!.contractSeqLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                    //pw.Center(child: pw.Text(locGen!.roomsLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                    pw.Center(child: pw.Text(locGen!.statusLbl, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6))),
                  ],
                ),
                // Filas de datos
                ...reservations.map(
                  (booking) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(booking.bookingName, style: const pw.TextStyle(fontSize: 5), textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(booking.bookingDateCheckIn, style: const pw.TextStyle(fontSize: 5), textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(booking.bookingEndCheckIn, style: const pw.TextStyle(fontSize: 5), textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(booking.bookingHotelName, style: const pw.TextStyle(fontSize: 5), textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(booking.bookingContent, style: const pw.TextStyle(fontSize: 5), textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(booking.contractName, style: const pw.TextStyle(fontSize: 5), textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(booking.bookingState, style: const pw.TextStyle(fontSize: 5), textAlign: pw.TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
