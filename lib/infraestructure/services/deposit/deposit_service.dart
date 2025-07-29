
import 'dart:convert';
import 'package:cve_app/ui/ui.dart';
import 'package:http/http.dart' as http;
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
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

      var objRsp = await GenericService().getMultiModelos(objReq, "ek.customer.receipt.record", true, '');
      
      ReceiptResponseModel objConv = ReceiptResponseModel.fromJson(jsonDecode(objRsp));

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

        //var objRspIrModel = await storage.read(key: 'RespuestaIrModel') ?? '';
        //IrModel objIrModel = IrModel.fromRawJson(objRspIrModel);

        var codImei = await storage.read(key: 'codImei') ?? '';

        var objReg = await storage.read(key: 'RespuestaRegistro') ?? '';
        var obj = RegisterDeviceResponseModel.fromJson(objReg);

        var objLog = await storage.read(key: 'RespuestaLogin') ?? '';
        var objLogDecode = json.decode(objLog);

        //print('Test DatosLogin: $objLog');

        List<MultiModel> lstMultiModel = [];

        lstMultiModel.add(
          MultiModel(model: "mail.activity")
        );

        ConsultaMultiModelRequestModel objReq = ConsultaMultiModelRequestModel(
          jsonrpc: jsonRpc,
          params: ParamsMultiModels(
            idConsulta: 0,
            partnerId: 0,
            bearer: obj.result.bearer,
            company: objLogDecode['result']['current_company'],
            imei: codImei,
            key: obj.result.key,
            tocken: obj.result.tocken,
            tockenValidDate: obj.result.tockenValidDate,
            uid: objLogDecode['result']['uid'],
            models: lstMultiModel
          )
        );

        String tockenValidDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(objReq.params.tockenValidDate);

        final requestBody = {
          "jsonrpc": jsonRpc,
          "params": {
            "key": objReq.params.key,
            "tocken": objReq.params.tocken,
            "imei": objReq.params.imei,
            "uid": objReq.params.uid,
            "company": objReq.params.company,
            "bearer": objReq.params.bearer,
            "tocken_valid_date": tockenValidDate,
            "create": {
              "receipt_file": objDeposit.receiptFile,
              "amount": objDeposit.amount,
              "receipt_number": objDeposit.receiptNumber,
              "date": DateFormat('yyyy-MM-dd', 'es').format(objDeposit.date),              
              "name": objDeposit.name,
              "customer_notes": objDeposit.customerNotes,
              "user_id": objDeposit.idUser,
              "partner_id": objDeposit.idPartner,
              "bank_account_id": objDeposit.idAccountBank
            },
          }
        };

        final headers = {
          "Content-Type": EnvironmentsProd().contentType
        };

        String ruta = '';
        final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
        
        if(objStr.isNotEmpty)
        {
          var obj = RegisterDeviceResponseModel.fromJson(objStr);
          ruta = '${obj.result.url}/api/v1/${objReq.params.imei}/done/create/ek.customer.receipt.record/model';
        }

        final response = await http.post(
          Uri.parse(ruta),
          headers: headers,
          body: jsonEncode(requestBody), 
        );

        //print('respuesta reg deposit: ${response.body}');
      
        var rspValidacion = json.decode(response.body);

        var objRespuestaFinal = DepositResponseModel.fromJson(rspValidacion);

        return objRespuestaFinal;
      } 
      catch(_){
        //print('Error al grabar: $ex');
      }
    }
    /*
     else {
      List<ActivitiesTypeRequestModel> lstAct = [];

      final tstAct = await storage.read(key: 'RegistraActividad') ?? '';

      if(tstAct.isNotEmpty){
        var varDecod = jsonDecode(tstAct);

        for(int i = 0; i < varDecod.length; i++){
          ActivitiesTypeRequestModel objGuardar = ActivitiesTypeRequestModel.fromJson(varDecod[i]);
          lstAct.add(objGuardar);
        }
        
      }

      lstAct.add(objDeposit);
      
      await storage.write(key: 'RegistraActividad', value: jsonEncode(lstAct));

      return ActividadRegistroResponseModel(
        id: 0,
        jsonrpc: '',
        result: ResultActividad(
          data: [],
          estado: 0,
          mensaje: objMensajesAlertasAct.mensajeOffLine
        )
      );
    }
*/
  }

}

