
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier{

  static final jsonRpc = EnvironmentsProd().jsonrpc;
  var storage = const FlutterSecureStorage();
  final String endPoint = StringConection().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  editUserDate(String cell, String email, String direction) async {
    String internet = await ValidationsUtils().validaInternet();
    
    //VALIDACIÓN DE INTERNET
    if(internet.isEmpty){      
      try{

        var resp = await storage.read(key: 'RespuestaLogin') ?? '';

        final data = json.decode(resp);

        int compId = data["result"]["company_id"] ?? 0;
        int partnerId = data["result"]["partner_id"] ?? 0;

        final url = Uri.parse('${EnvironmentsProd().apiEndpoint}post/update');

        final headers = {
          'Content-Type': EnvironmentsProd().contentType,
        };

        final body = {
          "jsonrpc": "2.0",
          "params": {
            "company_id": compId,
            "query_type": "customer_info_update",
            "data": 
            {
              'partner_id': partnerId,
              'street': direction,
              'phone': cell,
              'email': email
            }
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

