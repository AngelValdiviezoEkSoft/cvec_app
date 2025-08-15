import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
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

  login(AuthRequest authRequest) async {
    try {

      String resInt = await ValidationsUtils().validaInternet();

      if(resInt.isNotEmpty){
        return 'NI';
      }

      String ruta = '${EnvironmentsProd().apiEndpoint}auth/user';

      final headers = {
        "Content-Type": EnvironmentsProd().contentType,
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

  
  Future<ApiResponse?> changePassword(String previousPassword, String nextPassword) async {
    try {

      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      String login = data["result"]["login"] ?? '';
    
      final Map<String, dynamic> body = {
        "login": login,
        "previous_password": previousPassword,
        "next_password": nextPassword
      };

      var response = await GenericService().postGeneric(false,"update","change_password", body, null);

      if(response.isEmpty){
        return null;
      }

      var rspValidacion = json.decode(response);
      
      ApiRespuestaResponseModel objConv = ApiRespuestaResponseModel.fromJson(rspValidacion);

      return objConv.result;
    }
    catch(_){
      return null;
    }
  }


}
