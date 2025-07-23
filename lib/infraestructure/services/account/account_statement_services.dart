
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AccountStatementService extends ChangeNotifier{

  static final jsonRpc = EnvironmentsProd().jsonrpc;
  var storage = const FlutterSecureStorage();
  final String endPoint = StringConection().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

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

  Future<List<Quota>> getDetAccountStatement(idContract) async {
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
          idConsulta: idContract,
          models: []
        )
      );

      var objRsp = await GenericService().getMultiModelos(objReq, "ek.travel.subscription.quota", true, '');

      //print('Rsp Lista DET DEBS $objRsp');
      
      SuscriptionDetResponseModel objConv = SuscriptionDetResponseModel.fromJson(jsonDecode(objRsp));

      return objConv.result.data.ekTravelSubscriptionQuota.data;
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

  Future<List<PaymentLineData>> getDetCuotasAccountStatement(idCuota) async {
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
          idConsulta: idCuota,
          models: []
        )
      );

      var objRsp = await GenericService().getMultiModelos(objReq, "account.payment.line.travel", true, 'getDetCuotasAccountStatement');

      //print('Rsp Lista DET DEBS $objRsp');
      
      AccountStatementDetPayResponseModel objConv = AccountStatementDetPayResponseModel.fromJson(jsonDecode(objRsp));

      return objConv.result.data.accountPaymentLineTravel.data;
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

  Future<List<CustomerStatementItem>> getRptAccountStatement(List<int> contractIds) async {
    try {

      final Map<String, dynamic> body = {
        "jsonrpc": "2.0",
        "params": {
          "company_id": 1,
          "query_type": "customer_statement",
          "filters": [
            ["contract_ids", "=", jsonEncode(contractIds)]
          ]
        }
      };

      String ruta = '';
      final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
      
      if(objStr.isNotEmpty)
      {  
        var obj = RegisterDeviceResponseModel.fromJson(objStr);
        ruta = '${obj.result.url}/api/v1/cve/get';
      }
    
      final response = await http.post(
        Uri.parse(ruta),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      //print('Rsp Lista DET DEBS ${jsonDecode(response.body)}');
      
      AccountStatementReportResponseModel objConv = AccountStatementReportResponseModel.fromJson(jsonDecode(response.body));

      await storage.write(key: 'ListadoEstadoCuentas', value: '');
      await storage.write(key: 'ListadoEstadoCuentas', value: response.body);

      return objConv.result.data.customerStatement.data;
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

}

