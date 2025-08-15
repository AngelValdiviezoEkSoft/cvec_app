
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    
      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      int partnerId = data["result"]["partner_id"] ?? 0;

      var response = await GenericService().getGeneric("customer_debts_contracts", ["partner_id", "=", '$partnerId']);

      if(response.isEmpty){
        return [];
      }

      var rspValidacion = json.decode(response);
      
      SubscriptionResponseModel objConv = SubscriptionResponseModel.fromJson(rspValidacion);

      return objConv.result.data.customerStatementContracts.data;      
    }
    catch(_){
      return [];
    }
  }

  Future<List<Quota>> getDetDebts(idContract) async {
    try {

      var response = await GenericService().getGeneric("customer_debts_quotas", ["contract_id", "=", '$idContract']);

      if(response.isEmpty){
        return [];
      }

      var rspValidacion = json.decode(response);
      
      CustomerStatementQuotasResponse objConv = CustomerStatementQuotasResponse.fromJson(rspValidacion);

      return objConv.result.data.customerStatementQuotas.data;
    }
    catch(_){
      return [];
    }
  }

}

