
import 'dart:typed_data';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
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