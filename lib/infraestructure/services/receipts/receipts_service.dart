
import 'dart:convert';
import 'dart:io';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
//import 'package:fluttertoast/fluttertoast.dart';

const storageReceipts = FlutterSecureStorage();
AlertsMessages objMessageReceipt = AlertsMessages();
//ResponseValidation objResponseValidationService = ResponseValidation();

class ReceiptsService extends ChangeNotifier{

  final String endPoint = StringConection().apiEndpoint;

  final TokenManager tokenManager = TokenManager();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  Future<List<Payment>?> getReceipts() async {
    try{

      String resInt = await ValidationsUtils().validaInternet();

      if(resInt.isNotEmpty){
        return [];
      }

      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      int compId = data["result"]["company_id"] ?? 0;
      int partnerId = data["result"]["partner_id"] ?? 0;

      String ruta = '${EnvironmentsProd().apiEndpoint}get';

      final headers = {
        "Content-Type": EnvironmentsProd().contentType,
      };
      
      final body = jsonEncode({
        "jsonrpc": "2.0",
        "params": {
          "company_id": compId,
          "query_type": "customer_payment_receipts",
          "filters": [
            "partner_id", "=", '$partnerId'
          ]
        }
      });

      final request = http.Request("GET", Uri.parse(ruta))
        ..headers.addAll(headers)
        ..body = body;
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      //print('Test: ${response.body}');
      
      var rspValidacion = json.decode(response.body);

      if(rspValidacion['error'] != null){
        return [];
      }

      await storage.write(key: 'ListadoRecibos', value: '');
      await storage.write(key: 'ListadoRecibos', value: response.body);

      final bookingResponse = ReceiptResponse.fromJson(rspValidacion);

      List<Payment> bookingList = bookingResponse.result.data.accountPayment.data;

      return bookingList;
    }
    on SocketException catch (_) {
      /*
      Fluttertoast.showToast(
        msg: objMessageReceipt.mensajeFallaInternet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
      */
      return null;
    }
  }

  Future<List<PaymentLine>?> getDetReceipts(int idCab) async {
    try{

      String resInt = await ValidationsUtils().validaInternet();

      if(resInt.isNotEmpty){
        return [];
      }

      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      int compId = data["result"]["company_id"] ?? 0;

      String ruta = '${EnvironmentsProd().apiEndpoint}get';

      final headers = {
        "Content-Type": EnvironmentsProd().contentType,
      };
      
      final body = jsonEncode({
        "jsonrpc": "2.0",
        "params": {
          "company_id": compId,
          "query_type": "customer_payment_receipts_report",
          "filters": [
            "payment_id", "=", '$idCab'
          ]
        }
      });

      final request = http.Request("GET", Uri.parse(ruta))
        ..headers.addAll(headers)
        ..body = body;
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      //print('Test: ${response.body}');
      
      var rspValidacion = json.decode(response.body);

      if(rspValidacion['error'] != null){
        return [];
      }

      final bookingResponse = ReceiptDetResponse.fromJson(rspValidacion);

      List<PaymentLine> bookingList = bookingResponse.result?.data?.accountPaymentLineTravel?.data ?? [];

      return bookingList;
    }
    on SocketException catch (_) {
      /*
      Fluttertoast.showToast(
        msg: objMessageReceipt.mensajeFallaInternet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
      */
      return null;
    }
  }

}
