
import 'dart:convert';
import 'dart:io';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storageProspecto = FlutterSecureStorage();
AlertsMessages objMensajesProspectoService = AlertsMessages();
ResponseValidation objResponseValidationService = ResponseValidation();

class ReservationsService extends ChangeNotifier{

  final String endPoint = StringConection().apiEndpoint;

  final TokenManager tokenManager = TokenManager();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  Future<List<Booking>?> getReservations() async {
    try{
/*
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
          "query_type": "customer_bookings",
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
      */

      
      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      int partnerId = data["result"]["partner_id"] ?? 0;

      var response = await GenericService().getGeneric("customer_bookings", ["partner_id", "=", '$partnerId']);

      if(response.isEmpty){
        return [];
      }

      var rspValidacion = json.decode(response);

      await storage.write(key: 'ListadoReservaciones', value: '');
      await storage.write(key: 'ListadoReservaciones', value: response);

      final bookingResponse = BookingResponse.fromJson(rspValidacion);

      List<Booking> bookingList = bookingResponse.result.data.customerBookings.data;

      return bookingList;
    }
    on SocketException catch (_) {
      /*
      Fluttertoast.showToast(
        msg: objMensajesProspectoService.mensajeFallaInternet,
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
