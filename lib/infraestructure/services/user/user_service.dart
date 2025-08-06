import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService extends ChangeNotifier{

  static final jsonRpc = EnvironmentsProd().jsonrpc;
  var storage = const FlutterSecureStorage();
  final String endPoint = StringConection().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  editUserData(String cell, String email, String direction, String foto) async {
    String internet = await ValidationsUtils().validaInternet();
    
    //VALIDACIÓN DE INTERNET
    if(internet.isEmpty){      
      try{
        
        /*

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
              'email': email,
              if(foto.isNotEmpty)
              'image_1920': foto
            }
          }
        };

        final response = await http.post(
          url,
          headers: headers,
          body: jsonEncode(body),
        );
      
        var rspValidacion = json.decode(response.body);
        */

        var resp = await storage.read(key: 'RespuestaLogin') ?? '';

        final data = json.decode(resp);

        int partnerId = data["result"]["partner_id"] ?? 0;

        final Map<String, dynamic> dataParam = {
          'partner_id': partnerId,
          'street': direction,
          'phone': cell,
          'email': email,
          if (foto.isNotEmpty) 'image_1920': foto,
        };

        var response = await GenericService().postGeneric("update","customer_info_update", dataParam, []);

        if(response.isEmpty){
          return null;
        }

        var rspValidacion = json.decode(response);

        var objRespuestaFinal = ApiRespuestaResponseModel.fromJson(rspValidacion);

        final rspLogin = await storage.read(key: 'DataUser') ?? '';
        var rsp = jsonDecode(rspLogin);
    
        rsp["result"]["street"] = direction;
        direccionUserPrp = direction;

        await storage.write(key: 'DataUser', value: '');
        await storage.write(key: 'DataUser', value: jsonEncode(rsp));

        return objRespuestaFinal;
      } 
      catch(_){
        //print('Error al grabar: $ex');
      }
    }
    
  }

}

