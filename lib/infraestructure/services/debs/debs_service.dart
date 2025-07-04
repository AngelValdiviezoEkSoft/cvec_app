
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
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

      var objRsp = await GenericService().getMultiModelos(objReq, "sale.subscription", true);

      var rspValidacion = json.decode(objRsp);

      if(rspValidacion['result']['mensaje'] != null){
        final TokenManager tokenManager = TokenManager();
        
        String msmFinal = rspValidacion['result']['mensaje'].toString().trim().toLowerCase();

        //rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenExpirado

        //if(rspValidacion['result']['mensaje'] != null && (rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenNoValido || rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenExpirado)){
        if(msmFinal.contains(MessageValidation().tockenNoValido) || msmFinal.contains(MessageValidation().tockenExpirado)){
          await tokenManager.checkTokenExpiration();
          await getDebts();
        }
      }
      
      SubscriptionResponseModel objConv = SubscriptionResponseModel.fromJson(jsonDecode(objRsp));

      return objConv.result.data.data;      
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

  Future<List<Quota>> getDetDebts(idContract) async {
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

      var objRsp = await GenericService().getMultiModelos(objReq, "ek.travel.subscription.quota", true);

      //print('Rsp Lista DET DEBS $objRsp');
      
      SuscriptionDetResponseModel objConv = SuscriptionDetResponseModel.fromJson(jsonDecode(objRsp));

      return objConv.result.data.ekTravelSubscriptionQuota.data;
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

}

