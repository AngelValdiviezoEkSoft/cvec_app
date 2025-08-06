
import 'dart:convert';

import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BankAccountService extends ChangeNotifier{

  var storage = const FlutterSecureStorage();
  final String endPoint = StringConection().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  Future<List<BankAccount>> getBankAccounts() async {
    try {
/*
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
          partnerId: 0,
          idConsulta: 0,
          models: []
        )
      );
      */

      var objRsp = '';//await GenericService().getMultiModelos(objReq, "res.partner.bank", true, '');
      
      BankResponse objConv = BankResponse.fromJson(jsonDecode(objRsp));

      return objConv.result.data.resPartnerBank.data;
      
    }
    catch(_){
      //print('Test DataInit $ex');
      return [];
    }
  }

}

