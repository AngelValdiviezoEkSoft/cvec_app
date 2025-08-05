import 'dart:convert';

import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';

import 'package:cve_app/ui/bloc/bloc.dart';
import 'package:cve_app/ui/screens/reports/reports.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:printing/printing.dart';

const storage = FlutterSecureStorage();

//ignore: must_be_immutable
class PdfView extends StatelessWidget {
  //ClienteType? invoice;
  Booking? objReservation;
  List<Booking> lstReservation = [];
  Payment? objPayment;

  CustomerStatementItem? objCustomerStatementItem;
  List<CustomerStatementItem> detalleRptCustStatement = [];

  List<PaymentLine> detalleRptReceipt = [];
  String? tipoCertificado;
  String? periodo;
  String? periodoDesc;
  String? correoEnvio;
  bool? mostrarSueldo;
  final storageEcommerce = const FlutterSecureStorage();

  PdfView(Key? key,
    //ClienteType varInvoice,
    String varTipoCertificado,
    String? varPeriodo,
    String? varDescPeriodo,
    String? envioCorreo,
    bool varMostrarSueldo
  ) : super (key: key) {
    //invoice = varInvoice;
    tipoCertificado = varTipoCertificado;
    periodo = varPeriodo;
    periodoDesc = varDescPeriodo;
    correoEnvio = envioCorreo;
    mostrarSueldo = varMostrarSueldo;
  }

  AccountStatementModel rolDePago = AccountStatementModel();

  //Reservaciones
  Future<dynamic> rptReservation() async {
    try {

      var objRsp = await storage.read(key: 'ListadoReservaciones') ?? '';
      var id = await storage.read(key: 'IdReservaciones') ?? '0';
      int idFinal = int.parse(id);

      if (objRsp.isEmpty) return null;
      
      final bookingResponse = BookingResponse.fromJson(jsonDecode(objRsp));

      List<Booking> bookingList = bookingResponse.result.data.customerBookings.data;

      for(int i = 0; i < bookingList.length; i++){
        if(bookingList[i].bookingState == 'draft'){
          bookingList[i].bookingState = 'Borrador';
        }
        if(bookingList[i].bookingState == 'open'){
          bookingList[i].bookingState = 'Activa';
        }
        if(bookingList[i].bookingState == 'done'){
          bookingList[i].bookingState = 'Realizada';
        }
        if(bookingList[i].bookingState == 'cancel'){
          bookingList[i].bookingState = 'Anulada';
        }
        if(bookingList[i].bookingState == 'traveled'){
          bookingList[i].bookingState = 'Viajó';
        }
        if(bookingList[i].bookingState == 'not_traveled'){
          bookingList[i].bookingState = 'No viajó';
        }
        if(bookingList[i].bookingState == 'to_deliver_voucher'){
          bookingList[i].bookingState = 'Entregando voucher';
        }

      }

      lstReservation = bookingList;

      //objReservation = bookingList.where((x) => x.bookingId == idFinal).first;

       objReservation = bookingList.firstWhere(
        (x) => x.bookingId == idFinal,
        orElse: () => Booking(
          bookingId: 0,
          contractName: '',
          bookingName: '',
          bookingContent: '',
          bookingDate: '',
          bookingDateCheckIn: '',
          bookingEndCheckIn: '',
          bookingHotelName: '',
          bookingState: ''
        ),
      );

      return objReservation;

    } on Exception catch (_) {
    
    }
  }

  //method to make http request
  Future<dynamic> estadoCuentas() async {

    try {
      try {

      var objRsp = await storage.read(key: 'ListadoIdsContratos') ?? '';

      List<int> lstInt = List<int>.from(jsonDecode(objRsp));

      var rsp = await AccountStatementService().getRptAccountStatement(lstInt);
      
      final bookingResponse = AccountStatementReportResponseModel.fromJson(jsonDecode(rsp));

      detalleRptCustStatement = bookingResponse.result.data.customerStatementReport.data;

      return detalleRptCustStatement;

    } on Exception catch (_) {
      
    }

    } on Exception catch (_) {
    
    }
  }

  //method to make http request
  Future<dynamic> printReceipt() async {
    try {
      try {

      var objRsp = await storage.read(key: 'ListadoRecibos') ?? '';
      var id = await storage.read(key: 'IdRecibo') ?? '0';
      int idFinal = int.parse(id);
      
      final bookingResponse = ReceiptResponse.fromJson(jsonDecode(objRsp));

      List<Payment> bookingList = bookingResponse.result.data.accountPayment.data;

      objPayment = bookingList.firstWhere((x) => x.paymentId == idFinal);

      detalleRptReceipt = await ReceiptsService().getDetReceipts(idFinal) ?? [];

      return objPayment;

    } on Exception catch (_) {
    
    }

    } on Exception catch (_) {
    
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(tipoCertificado ?? '', style: const TextStyle(color: Colors.black),),
          ),
          body: state.viewAccountStatement ?
          FutureBuilder(
            future: estadoCuentas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {

                  List<CustomerStatementItem> lstItems = snapshot.data as List<CustomerStatementItem>;

                  return PdfPreview(
                    pdfFileName: "EstadoCuenta.pdf",
                    canChangePageFormat: false,
                    canDebug: false,
                    canChangeOrientation: false,
                    build: (context) => accountStatementRpt(lstItems),//rolDePago, correoEnvio!, periodoDesc!, periodo!),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
          :
          state.viewPrintReceipts ?
          FutureBuilder(
            future: printReceipt(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return PdfPreview(
                    pdfFileName: "Recibo.pdf",
                    canChangePageFormat: false,
                    canDebug: false,
                    canChangeOrientation: false,
                    build: (context) => printReceiptRpt(objPayment!, detalleRptReceipt),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
          :
          FutureBuilder(
            future: rptReservation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return PdfPreview(
                    pdfFileName: "${locGen!.menuSeeReservationsLbl}.pdf",
                    canChangePageFormat: false,
                    canDebug: false,
                    canChangeOrientation: false,
                    build: (context) => generateReservation(lstReservation),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        );
      }
    );

  }
}
