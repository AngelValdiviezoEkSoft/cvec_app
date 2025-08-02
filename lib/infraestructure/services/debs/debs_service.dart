
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DebsService extends ChangeNotifier{

  static final jsonRpc = EnvironmentsProd().jsonrpc;
  var storage = const FlutterSecureStorage();
  final String endPoint = StringConection().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  Future<List<Subscription>> getDebts() async {
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
          "query_type": "customer_debts_contracts",
          "filters": [
            ["partner_id", "=", '$partnerId']
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
      
      SubscriptionResponseModel objConv = SubscriptionResponseModel.fromJson(rspValidacion);

      return objConv.result.data.customerStatementContracts.data;      
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

  Future<List<Quota>> getDetDebts(idContract) async {
    try {

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
          "query_type": "customer_debts_quotas",
          "filters": [
            ["contract_id", "=", '$idContract']
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

      //print('Rsp Lista DET DEBS $objRsp');
      
      CustomerStatementQuotasResponse objConv = CustomerStatementQuotasResponse.fromJson(rspValidacion);

      return objConv.result.data.customerStatementQuotas.data;
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

}

