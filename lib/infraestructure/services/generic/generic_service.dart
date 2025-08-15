import 'dart:async';
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GenericService extends ChangeNotifier {
  //final env = CadenaConexion();
  final storage = const FlutterSecureStorage();
  List<OptionsMenuModel> lstOp = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TokenManager tokenManager = TokenManager();

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<dynamic> opcionesMenuPorPerfil(BuildContext context) async {
    lstOp = [
      OptionsMenuModel(
        descMenu: 'Editar Perfil', 
        icono: Icons.person_pin, 
        onPress: () {}//=> context.push(objRutas.rutaEditarPerfil),
      ),
      OptionsMenuModel(
        descMenu: 'Soporte', 
        icono: Icons.question_mark,
        onPress: () {}//=> context.push(objRutas.rutaConstruccion),
      ),
      OptionsMenuModel(
        descMenu: 'Terminos de uso',
        icono: Icons.info,
        onPress: () {}//=> context.push(objRutas.rutaConstruccion),
      ),
    ];
    return lstOp;
  }

  Future<String> settingsLoad() async {
    double fontSize = 0;
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getInt('PorcFontSize') != null){
      String porcentaje = '${prefs.getInt('PorcFontSize')}';

      fontSize = double.parse(porcentaje);
    }    

    return fontSize.toString();
  }

  Future<String> getGeneric(String queryType, List<dynamic> filters) async {
    try {

      String resInt = await ValidationsUtils().validaInternet();

      if(resInt.isNotEmpty){
        return '';
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
          "query_type": queryType,
          "filters": filters
        }
      });

      final request = http.Request("GET", Uri.parse(ruta))
        ..headers.addAll(headers)
        ..body = body;
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return response.body;
    }
    catch(ex){
      return '';
    }
  }

  Future<String> postGeneric(bool ingresaQueryType, String methodType, String queryType, Map<String, dynamic>? filters, List<Map<String, dynamic>>? filtersCreate) async {
    try {

      String resInt = await ValidationsUtils().validaInternet();

      if(resInt.isNotEmpty){
        return '';
      }

      var resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);

      int compId = data["result"]["company_id"] ?? 0;

      String cabeceraPost = '';

      if(methodType == 'update'){
        cabeceraPost = 'data';
      }

      if(methodType == 'create'){
        cabeceraPost = 'data_list';
      }

      Uri url = Uri.parse('${EnvironmentsProd().apiEndpoint}post/$methodType');

      if(queryType == 'change_password'){
        url = Uri.parse('${EnvironmentsProd().apiEndpoint}auth/$queryType');
      }

      final headers = {
        'Content-Type': EnvironmentsProd().contentType,
      };

      final body = {
        "jsonrpc": "2.0",
        "params": {
          "company_id": compId,
          if(ingresaQueryType)
          "query_type": queryType,
          if(filters != null)
          cabeceraPost: filters,
          if(filtersCreate != null)
          cabeceraPost: filtersCreate
        }
      };

      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      return response.body;
    }
    catch(ex){
      return '';
    }
  }

}
