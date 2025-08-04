
import 'dart:convert';
import 'package:cve_app/ui/ui.dart';
import 'package:http/http.dart' as http;
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class DepositService extends ChangeNotifier{

  static final jsonRpc = EnvironmentsProd().jsonrpc;
  var storage = const FlutterSecureStorage();
  final String endPoint = StringConection().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  Future<List<ReceiptModelResponse>> getDeposit() async {
    try {

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
          "query_type": "customer_receipt_records_read",
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

      ReceiptResponseModel objConv = ReceiptResponseModel.fromJson(rspValidacion);

      //print('Test DataInit $objRsp');

      return objConv.result.data.data;      
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

  registroDeposito(DepositRequestModel objDeposit) async {
    String internet = await ValidationsUtils().validaInternet();
    
    //VALIDACIÓN DE INTERNET
    if(internet.isEmpty){      
      try{

        var resp = await storage.read(key: 'RespuestaLogin') ?? '';

        final data = json.decode(resp);

        int compId = data["result"]["company_id"] ?? 0;
        //int partnerId = data["result"]["partner_id"] ?? 0;

        final url = Uri.parse('${EnvironmentsProd().apiEndpoint}post/create');

        final headers = {
          'Content-Type': EnvironmentsProd().contentType,
        };

        final body = {
          "jsonrpc": "2.0",
          "params": {
            "company_id": compId,
            "query_type": "customer_receipt_records_create",
            "data_list": [
              {
                "name": objDeposit.name,
                "date": DateFormat('yyyy-MM-dd', 'es').format(objDeposit.date),
                "amount": objDeposit.amount,
                "receipt_number": objDeposit.receiptNumber,
                "user_id": objDeposit.idUser,
                "receipt_file": objDeposit.receiptFile,
                "customer_notes": objDeposit.customerNotes
              }
            ]
          }
        };

        final response = await http.post(
          url,
          headers: headers,
          body: jsonEncode(body),
        );

        var rspValidacion = json.decode(response.body);

        var objRespuestaFinal = ApiRespuestaResponseModel.fromJson(rspValidacion);

        return objRespuestaFinal;
      } 
      catch(_){
        //print('Error al grabar: $ex');
      }
    }
    
  }

}

