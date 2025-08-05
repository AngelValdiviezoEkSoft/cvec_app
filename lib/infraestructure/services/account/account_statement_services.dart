
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
//import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:http/http.dart' as http;

class AccountStatementService extends ChangeNotifier{

  static final jsonRpc = EnvironmentsProd().jsonrpc;
  var storage = const FlutterSecureStorage();
  final String endPoint = StringConection().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

/*
  Future<List<Subscription>> getAccountStatement() async {
    try {

      var codImei = await storage.read(key: 'codImei') ?? '';

      var objReg = await storage.read(key: 'RespuestaRegistro') ?? '';
      var obj = RegisterDeviceResponseModel.fromJson(objReg);

      var objLog = await storage.read(key: 'RespuestaLogin') ?? '';
      var objLogDecode = json.decode(objLog);

      ConsultaMultiModelRequestModel objReq = ConsultaMultiModelRequestModel(
        jsonrpc: EnvironmentsProd().jsonrpc,
        params: ParamsMultiModels(
          bearer: obj.result.bearer,
          company: objLogDecode['result']['current_company'],
          imei: codImei,
          key: obj.result.key,
          tocken: obj.result.tocken,
          tockenValidDate: obj.result.tockenValidDate,
          uid: objLogDecode['result']['uid'],
          partnerId: objLogDecode['result']['partner_id'],
          idConsulta: 0,
          models: []
        )
      );

      var objRsp = await GenericService().getMultiModelos(objReq, "sale.subscription", true, '');

      //print('Respuesta: $objRsp');

      var rspValidacion = json.decode(objRsp);

      if(rspValidacion['result']['mensaje'] != null){
        final TokenManager tokenManager = TokenManager();
        
        String msmFinal = rspValidacion['result']['mensaje'].toString().trim().toLowerCase();

        if(msmFinal.contains(MessageValidation().tockenNoValido) || msmFinal.contains(MessageValidation().tockenExpirado)){
          await tokenManager.checkTokenExpiration();
          await getAccountStatement();
        }
      }

      //print('Test $objRsp');

      SubscriptionResponseModel objConv = SubscriptionResponseModel.fromJson(jsonDecode(objRsp));

      List<int> lstIdsContratos = [];

      for(int i = 0; i < objConv.result.data.data.length; i++){
        lstIdsContratos.add(objConv.result.data.data[i].contractId);
      }

      //var _ = await getRptAccountStatement([96084]);
      var _ = await getRptAccountStatement(lstIdsContratos);

      return objConv.result.data.data;      
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }
*/

  Future<List<Contract>> getAccountStatement() async {
    try {

      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      int partnerId = data["result"]["partner_id"] ?? 0;

      var response = await GenericService().getGeneric("customer_statement_contracts", ["partner_id", "=", '$partnerId']);

      if(response.isEmpty){
        return [];
      }

      var rspValidacion = json.decode(response);
      
      AccountStatementResponseModel objConv = AccountStatementResponseModel.fromJson(rspValidacion);

      List<int> lstIdsContratos = [];

      for(int i = 0; i < objConv.result.data.customerStatementContracts.data.length; i++){
        lstIdsContratos.add(objConv.result.data.customerStatementContracts.data[i].contractId);
      }

      await storage.write(key: 'ListadoIdsContratos', value: '');
      await storage.write(key: 'ListadoIdsContratos', value: jsonEncode(lstIdsContratos));

      //var _ = await getRptAccountStatement(lstIdsContratos);

      return objConv.result.data.customerStatementContracts.data;      
    }
    catch(ex){
      //print('Test DataInit $ex');
      return [];
    }
  }

  Future<List<AccountStatementDet>> getDetAccountStatement(idContract) async {
    try {
      
      var response = await GenericService().getGeneric("customer_statement_quotas", ["contract_id", "=", '$idContract']);

      if(response.isEmpty){
        return [];
      }

      var rspValidacion = json.decode(response);
      
      AccountStatementDetResponseModel objConv = AccountStatementDetResponseModel.fromJson(rspValidacion);

      return objConv.result.data.customerStatementQuotas.data;
    }
    catch(ex){
      //print('Test DataInit $ex');
      return [];
    }
  }

  Future<List<PaymentLineData>> getDetCuotasAccountStatement(idCuota) async {
    try {
      
      var response = await GenericService().getGeneric("customer_statement_payments", ["quota_id", "=", '$idCuota']);

      if(response.isEmpty){
        return [];
      }

      var rspValidacion = json.decode(response);
      
      AccountStatementDetPayResponseModel objConv = AccountStatementDetPayResponseModel.fromJson(rspValidacion);

      if(objConv.result.data.accountPaymentLineTravel.data.isEmpty){
        objConv.result.data.accountPaymentLineTravel.data.add(
          PaymentLineData(
            contractId: 0,
            contractName: 'VACIO',
            lineAmount: 0,
            lineId: 0,
            paymentAmount: 0,
            paymentDate: '',
            paymentId: 0,
            paymentLineId: 0,
            paymentSequence: '',
            quotaCode: '',
            quotaId: 0,
            quotaName: '',
            quotaType: ''
          )
        );
      }

      return objConv.result.data.accountPaymentLineTravel.data;
    }
    catch(ex){
      return [];
    }
  }

/*
  Future<List<AccountStatementDet>> getDetAccountStatement(idContract) async {
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
          "query_type": "customer_statement_quotas",
          "filters": [
            "contract_id", "=", '$idContract'
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
      
      AccountStatementDetResponseModel objConv = AccountStatementDetResponseModel.fromJson(jsonDecode(response.body));

      return objConv.result.data.customerStatementQuotas.data;
    }
    catch(ex){
      //print('Test DataInit $ex');
      return [];
    }
  }

  Future<List<PaymentLineData>> getDetCuotasAccountStatement(idCuota) async {
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
          "query_type": "customer_statement_payments",
          "filters": [
            "quota_id", "=", '$idCuota'
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
      
      AccountStatementDetPayResponseModel objConv = AccountStatementDetPayResponseModel.fromJson(rspValidacion);

      if(objConv.result.data.accountPaymentLineTravel.data.isEmpty){
        objConv.result.data.accountPaymentLineTravel.data.add(
          PaymentLineData(
            contractId: 0,
            contractName: 'VACIO',
            lineAmount: 0,
            lineId: 0,
            paymentAmount: 0,
            paymentDate: '',
            paymentId: 0,
            paymentLineId: 0,
            paymentSequence: '',
            quotaCode: '',
            quotaId: 0,
            quotaName: '',
            quotaType: ''
          )
        );
      }

      return objConv.result.data.accountPaymentLineTravel.data;
    }
    catch(ex){
      return [];
    }
  }
*/

  Future<String> getRptAccountStatement(List<int> contractIds) async {
    try {

      var response = await GenericService().getGeneric("customer_statement_report", ["contract_ids", "=", jsonEncode(contractIds)]);

      await storage.write(key: 'ListadoEstadoCuentas', value: '');
      await storage.write(key: 'ListadoEstadoCuentas', value: response);

      return response;
    }
    catch(_){
      //print('Test DataInit $ex');
      return '';
    }
  }

}
