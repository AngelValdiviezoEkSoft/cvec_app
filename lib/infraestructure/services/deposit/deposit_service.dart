
import 'dart:convert';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      int partnerId = data["result"]["partner_id"] ?? 0;

      var response = await GenericService().getGeneric("customer_receipt_records_read", ["partner_id", "=", '$partnerId']);

      if(response.isEmpty || response.contains('"estado": 404') || response.contains('Platform Error')){
        return [];
      }

      var rspValidacion = json.decode(response);

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

        //var fechaConv = DateFormat('yyyy-MM-dd', 'es').format(objDeposit.date);
/*
        DateTime ahora = DateTime.now();

        int horas = ahora.hour;
        int minutos = ahora.minute;
        int segundos = ahora.second;

        String mesFinal = ahora.month < 10 ? '0${ahora.month}' : '${ahora.month}';
        String diaFinal = ahora.day < 10 ? '0${ahora.day}' : '${ahora.day}';

        String fechaFinal = '${ahora.year}-$mesFinal-$diaFinal';

        String horasStr = horas < 10 ? '0$horas' : '$horas';
        String minStr = minutos < 10 ? '0$minutos' : '$minutos';
        String segStr = segundos < 10 ? '0$segundos' : '$segundos';

        //String fechaHoraEnviar = DateFormat('yyyy-MM-dd').format(DateTime.now());
        //DateTime fechaHoraEnviarDateTime = DateTime.parse(fechaHoraEnviar);
        String fechaEnvio = '$fechaFinal $horasStr:$minStr:$segStr';
        */

        final List<Map<String, dynamic>> dataList = [
          {
            "receipt_concept": objDeposit.name,
            //"date": fechaEnvio,//DateFormat('yyyy-MM-dd HH:mm:ss', 'es').format(objDeposit.date),
            "amount": objDeposit.amount,
            "receipt_number": objDeposit.receiptNumber,
            "user_id": objDeposit.idUser,
            "receipt_file": objDeposit.receiptFile,
            "customer_notes": objDeposit.customerNotes
          }
        ];

        var response = await GenericService().postGeneric(true,"create","customer_receipt_records_create", null, dataList);

        if(response.isEmpty){
          return null;
        }

        var rspValidacion = json.decode(response);

        var objRespuestaFinal = ApiRespuestaResponseModel.fromJson(rspValidacion);

        return objRespuestaFinal;
      } 
      catch(_){
        //print('Error al grabar: $ex');
      }
    }
    
  }

}

