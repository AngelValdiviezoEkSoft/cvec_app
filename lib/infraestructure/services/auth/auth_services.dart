import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  
  static final jsonRpc = EnvironmentsProd().jsonrpc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final envProd = EnvironmentsProd();
  final env = StringConection();
  final storage = const FlutterSecureStorage();

  String passWord = '';
  String email = '';
  bool _areInputsView = false;
  bool _inputPin = false;

  bool get areInputsView => _areInputsView;
  set areInputsView(bool value) {
    _areInputsView = value;
    notifyListeners();
  }

  bool get inputPin => _inputPin;
  set inputPin(bool value) {
    _inputPin = value;
    notifyListeners();
  }

  bool isLoading = false;
  bool get varIsLoading => isLoading;
  set varIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isLoadingCambioClave = false;
  bool get varIsLoadingCambioClave => isLoadingCambioClave;
  set varIsLoadingCambioClave(bool value) {
    isLoadingCambioClave = value;
    notifyListeners();
  }

  String varCedula = '';
  String varPasaporte = '';

  bool isKeyOscured = true;
  bool get varIsKeyOscured => isKeyOscured;
  set varIsKeyOscured(bool value) {
    isKeyOscured = value;
    notifyListeners();
  }

  bool isOscured = true;
  bool get varIsOscured => isOscured;
  set varIsOscured(bool value) {
    isOscured = value;
    notifyListeners();
  }

  bool isOscuredConf = true;
  bool get varIsOscuredConf => isOscuredConf;
  set varIsOscuredConf(bool value) {
    isOscuredConf = value;
    notifyListeners();
  }

  bool isOscuredConfNew = true;
  bool get varIsOscuredConfNew => isOscuredConfNew;
  set varIsOscuredConfNew(bool value) {
    isOscuredConfNew = value;
    notifyListeners();
  }

  bool isPasaporte = false;
  bool get varIsPasaporte => isPasaporte;
  set varIsPasaporte(bool value) {
    isPasaporte = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  //#region Registro Dispositivo
  doneRegister(RegisterDeviceRequestModel objRegister) async {
    final ruta = '${env.apiEndpoint}done/register';

    final Map<String, dynamic> body = {
    "jsonrpc": envProd.jsonrpc,
    "params": {
      "server": objRegister.server,
      "key": objRegister.key,
      "imei": objRegister.imei,
      "lat": objRegister.lat,
      "lon": objRegister.lon,
      "so": objRegister.so
      }
    };
    
    final response = await http.post(
      Uri.parse(ruta),
      headers: <String, String>{
        'Content-Type': envProd.contentType,
      },
      body: jsonEncode(body),
    );
    
    var reponseRs = response.body;

    //print("Test: " + response.body);

    var obj = RegisterDeviceResponseModel.fromJson(reponseRs);
    await storage.write(key: 'codImei', value: objRegister.imei);

    if(obj.result.estado == 200){      
      await storage.write(key: 'RespuestaRegistro', value: reponseRs);
    }

    if(obj.result.estado == 404){
      RegisterDeviceResponseModel rsp = await doneGetTocken(objRegister.imei, objRegister.key);
      return rsp;
    }

    return obj;
    
  }
  
  doneGetTocken(String imei, String key) async {
    final ruta = '${env.apiEndpoint}done/$imei/tocken/$key';
    
    final Map<String, dynamic> body = {
      "jsonrpc": envProd.jsonrpc,
      "params": {}
    };
    
    final response = await http.post(
      Uri.parse(ruta),
      headers: <String, String>{
        'Content-Type': envProd.contentType,
      },
      body: jsonEncode(body),
    );
    
    var reponseRs = response.body;

    var obj = RegisterDeviceResponseModel.fromJson(reponseRs);

    await storage.write(key: 'RespuestaRegistro', value: '');
    await storage.write(key: 'RespuestaRegistro', value: reponseRs);

    return obj;    
  }
  
  doneValidateTocken(String imei, String key, String tocken) async {
    final ruta = '${env.apiEndpoint}done/$imei/validate/tocken/$key';
    
    final Map<String, dynamic> body = {
      "jsonrpc": envProd.jsonrpc,
      "params": {
        "tocken": tocken
      }
    };
    
    final response = await http.post(
      Uri.parse(ruta),
      headers: <String, String>{
        'Content-Type': envProd.contentType,
      },
      body: jsonEncode(body),
    );
    
    var reponseRs = response.body;
    //return ValidationTokenResponseModel.fromJson(reponseRs);
    return reponseRs;
  }
  //#endregion

  /*
  login(AuthRequest authRequest) async {
    try {

      String resInt = await ValidationsUtils().validaInternet();

      if(resInt.isNotEmpty){
        return 'NI';
      }

      String ruta = '';
      final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
    
      if(objStr.isNotEmpty)
      {  
        var obj = RegisterDeviceResponseModel.fromJson(objStr);
        ruta = '${obj.result.url}/web/session/authenticate';
      }

      final Map<String, dynamic> body = {
        "jsonrpc": jsonRpc,//EnvironmentsProd().jsonrpc,
        //"method": "call",
        "params": {
          "db": authRequest.db,
          "login": authRequest.login,
          "password": authRequest.password
        },
        "id": null
      };
      
      final response = await http.post(
        Uri.parse(ruta),
        headers: <String, String>{
          'Content-Type': EnvironmentsProd().contentType,
        },
        body: jsonEncode(body),
      );

      //print('Test: ${response.body}');
      
      var rspValidacion = json.decode(response.body);

      if(rspValidacion['error'] != null){
        return response.body;
      }

      
      if(rspValidacion['result']['mensaje'] != null && (rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenNoValido || rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenExpirado)){
        await TokenManager().checkTokenExpiration();
        await login(authRequest);
      }

      final models = [        
        {
          "model": EnvironmentsProd().modProsp,//"crm.lead",
          "filters": []
        },
        {
          "model": EnvironmentsProd().modClien,//"res.partner",
          "filters": []
        },
        {
          "model": EnvironmentsProd().modCampa,//"utm.campaign",
          "filters": []
        },
        {
          "model": EnvironmentsProd().modOrige,//"utm.source",
          "filters": []
        },
        {
          "model": EnvironmentsProd().modMedio,//"utm.medium",
          "filters": []
        },
        {
          "model": EnvironmentsProd().modActiv,//"mail.activity.type",
          "filters": [
            ["res_model","=",false]
          ]
        },
        {
          "model": EnvironmentsProd().modPaise,//"res.country",
          "filters": []
        },
        {
          "model": EnvironmentsProd().modIrModel,//"ir.model",
          "filters": [
            ["model","=",EnvironmentsProd().modCrmLead]//"crm.lead"
          ]
        },
      ];

      await storage.write(key: 'RespuestaLogin', value: response.body);

      //print('Result Login: ${response.body}');
      
      await DataInicialService().readModelosApp(models);

      //#region ConsultaCorreo
      var objReg = await storage.read(key: 'RespuestaRegistro') ?? '';
      var obj = RegisterDeviceResponseModel.fromJson(objReg);

      var objLog = await storage.read(key: 'RespuestaLogin') ?? '';
      var objLogDecode = json.decode(objLog);

      var codImei = await storage.read(key: 'codImei') ?? '';

      ConsultaModelRequestModel objRqst = ConsultaModelRequestModel(
        jsonrpc: '',
        params: ParamsConsultaModel(
          bearer: obj.result.bearer,
          company: objLogDecode['result']['current_company'],
          imei: codImei,
          key: obj.result.key,
          models: [],
          tocken: obj.result.tocken,
          tockenValidDate: obj.result.tockenValidDate,
          uid: objLogDecode['result']['uid'],
        )
      );

      String rsp = await GenericService().getModelosByUidUser(objRqst, 'res.users');

      var rspCorreo = json.decode(rsp);

      String emailUser = rspCorreo["result"]["data"][0]["email"] ?? '';

      await storage.write(key: 'DataUser', value: rsp);
      await storage.write(key: 'CorreoUser', value: emailUser);
      //#endregion

      return response.body;
    } catch (_) {
      //print('Test Error1: $ex');
    }
  }
*/

  login(AuthRequest authRequest) async {
    try {

      String resInt = await ValidationsUtils().validaInternet();

      if(resInt.isNotEmpty){
        return 'NI';
      }

      String ruta = '${EnvironmentsProd().apiEndpoint}auth/user';

      final headers = {
        "Content-Type": "application/json",
      };
      
      final body = jsonEncode({
        "jsonrpc": jsonRpc,
        "params": {
          "login": authRequest.login,
          "password": authRequest.password
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
        return response.body;
      }

      await storage.write(key: 'RespuestaLogin', value: response.body);

      return response.body;
    } catch (_) {
      //print('Test Error1: $ex');
    }
  }


  Future<String> getDatosPerfil() async {    
    final rspLogin = await storage.read(key: 'DataUser') ?? '';
    //final jsonLog = json.decode(rspLogin);

    return rspLogin;//jsonEncode(objFiltrado);
    //return "TST";//jsonEncode(objFiltrado);
  }


}
