import 'dart:async';
import 'dart:convert';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../../config/routes/routes.dart';

class GenericService extends ChangeNotifier {
  //final env = CadenaConexion();
  final storage = const FlutterSecureStorage();
  List<OptionsMenuModel> lstOp = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TokenManager tokenManager = TokenManager();

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  getModelos(ConsultaModelRequestModel objReq, String modelBusca) async {
    //final ruta = '${env.apiEndpoint}<imei>/done/data/<model>/model';

    String ruta = '';
    final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
    
    if(objStr.isNotEmpty)
    {  
      var obj = RegisterDeviceResponseModel.fromJson(objStr);
      ruta = '${obj.result.url}/api/v1/${objReq.params.imei}/done/data/$modelBusca/model';
    }
    
    final Map<String, dynamic> body = 
    {
      "jsonrpc": EnvironmentsProd().jsonrpc,
      "params": {
        "key": objReq.params.key,
        "tocken": objReq.params.tocken,
        "imei": objReq.params.imei,
        "uid": objReq.params.uid,
        "company": objReq.params.company,
        "bearer": objReq.params.bearer,
        "tocken_valid_date": objReq.params.tockenValidDate,
        "filters": ''
      }
    };
    
    final response = await http.post(
      Uri.parse(ruta),
      headers: <String, String>{
        'Content-Type': EnvironmentsProd().contentType//'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    
    var reponseRs = response.body;

    var rspValidacion = json.decode(response.body);

    //if(rspValidacion['result']['mensaje'] == 'El tocken no es valido'){
    if(rspValidacion['result']['mensaje'] != null && 
      (
        rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenNoValido || 
        rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenExpirado
      )){
      await tokenManager.checkTokenExpiration();
      await getModelos(objReq, modelBusca);
    }

    var obj = RegisterDeviceResponseModel.fromJson(reponseRs);

    await storage.write(key: 'RespuestaRegistro', value: reponseRs);

    return obj;    
  }

  getModelosByUidUser(ConsultaModelRequestModel objReq, String modelBusca) async {    

    String ruta = '';
    final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
    
    if(objStr.isNotEmpty)
    {  
      var obj = RegisterDeviceResponseModel.fromJson(objStr);
      ruta = '${obj.result.url}/api/v1/${objReq.params.imei}/done/data/$modelBusca/model';
    }

    String tockenValidDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(objReq.params.tockenValidDate);
    
    final Map<String, dynamic> body = 
    {
      "jsonrpc": EnvironmentsProd().jsonrpc,
      "params": {
        "key": objReq.params.key,
        "tocken": objReq.params.tocken,
        "imei": objReq.params.imei,
        "uid": objReq.params.uid,
        "company": objReq.params.company,
        "bearer": objReq.params.bearer,
        "tocken_valid_date": tockenValidDate,//objReq.params.tockenValidDate,
        "filters": [
          ["id","=",objReq.params.uid],
        ]
      }
    };
    
    final response = await http.post(
      Uri.parse(ruta),
      headers: <String, String>{
        'Content-Type': EnvironmentsProd().contentType//'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    
    var reponseRs = response.body;

    var rspValidacion = json.decode(response.body);

    if(rspValidacion['result']['mensaje'] != null && 
      (
        rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenNoValido || 
        rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenExpirado
      )){
      await tokenManager.checkTokenExpiration();
      await getModelos(objReq, modelBusca);
    }

    //var obj = RegisterDeviceResponseModel.fromJson(reponseRs);

    return reponseRs;    
  }

  getMultiModelos(ConsultaMultiModelRequestModel objReq, String modelo, bool isComposedInfo, String metodoEnviado) async {

    String ruta = '';
    final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
    
    if(objStr.isNotEmpty)
    {  
      var obj = RegisterDeviceResponseModel.fromJson(objStr);
      ruta = '${obj.result.url}/api/v1/${objReq.params.imei}/done/data/multi/models';
    }

    String tockenValidDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(objReq.params.tockenValidDate);

    final requestBody = {
      "jsonrpc": EnvironmentsProd().jsonrpc,
      "params": {
        "key": objReq.params.key,
        "tocken": objReq.params.tocken,
        "imei": objReq.params.imei,
        "uid": objReq.params.uid,
        "company": objReq.params.company,
        "bearer": objReq.params.bearer,
        "tocken_valid_date": tockenValidDate,
        "is_composed_info": isComposedInfo,
        "models": [
          {
            "model": modelo,            
            "filters": [
              if(modelo != 'account.payment.line.travel')
              ["partner_id","=",objReq.params.partnerId],
              if(modelo.isNotEmpty && modelo == 'ek.travel.subscription.quota')
              ['contract_id', '=', objReq.params.idConsulta],
              if(modelo.isNotEmpty && modelo == 'account.payment')
              ['payment_type', '=', 'inbound'],
              if(modelo.isNotEmpty && modelo == 'account.payment')
              ['partner_type', '=', 'customer'],
              if(modelo.isNotEmpty && modelo == 'account.payment')
              ['state', '=', 'posted'],
              if(modelo.isNotEmpty && modelo == 'account.payment.line.travel' && metodoEnviado.isEmpty)
              ['payment_id', '=', objReq.params.idConsulta],
              if(modelo.isNotEmpty && modelo == 'account.payment.line.travel' && metodoEnviado.isNotEmpty && metodoEnviado == 'getDetCuotasAccountStatement')
              ['quota_id', '=', objReq.params.idConsulta],
            ]
          }
        ],
      }
    };

    final headers = {
      "Content-Type": EnvironmentsProd().contentType
    };

    final response = await http.post(
      Uri.parse(ruta),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print('Respuesta Reporte: ${response.body}');
    
    return response.body;
    
  }
  
  getMultiModelosSinFiltro(ConsultaMultiModelRequestModel objReq, String modelo) async {

    String ruta = '';
    final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
    
    if(objStr.isNotEmpty)
    {  
      var obj = RegisterDeviceResponseModel.fromJson(objStr);
      ruta = '${obj.result.url}/api/v1/${objReq.params.imei}/done/data/multi/models';
    }

    String tockenValidDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(objReq.params.tockenValidDate);

    final requestBody = {
      "jsonrpc": EnvironmentsProd().jsonrpc,
      "params": {
        "key": objReq.params.key,
        "tocken": objReq.params.tocken,
        "imei": objReq.params.imei,
        "uid": objReq.params.uid,
        "company": objReq.params.company,
        "bearer": objReq.params.bearer,
        "tocken_valid_date": tockenValidDate,
        "models": [
          {
            "model": modelo
          }
        ],
      }
    };

    final headers = {
      "Content-Type": EnvironmentsProd().contentType
    };

    final response = await http.post(
      Uri.parse(ruta),
      headers: headers,
      body: jsonEncode(requestBody), 
    );

    print('Respuesta Reporte: ${response.body}');
    
    var rspValidacion = json.decode(response.body);

    //if(rspValidacion['result']['mensaje'] == 'El tocken no es valido'){
    if(rspValidacion['result']['mensaje'] != null && (rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenNoValido || rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenExpirado)){
      await tokenManager.checkTokenExpiration();
      await getMultiModelosSinFiltro(objReq, modelo);
    }

    return response.body;
    
  }
  

  getMultiModelosGen(ConsultaMultiModelRequestModel objReq, List<Map<String, dynamic>> lstModels) async {

    String ruta = '';
    final objStr = await storage.read(key: 'RespuestaRegistro') ?? '';
    
    if(objStr.isNotEmpty)
    {  
      var obj = RegisterDeviceResponseModel.fromJson(objStr);
      ruta = '${obj.result.url}/api/v1/${objReq.params.imei}/done/data/multi/models';
    }

    String tockenValidDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(objReq.params.tockenValidDate);

    final requestBody = {
      "jsonrpc": EnvironmentsProd().jsonrpc,
      "params": {
        "key": objReq.params.key,
        "tocken": objReq.params.tocken,
        "imei": objReq.params.imei,
        "uid": objReq.params.uid,
        "company": objReq.params.company,
        "bearer": objReq.params.bearer,
        "tocken_valid_date": tockenValidDate,
        "models": lstModels
      }
    };

    final headers = {
      "Content-Type": EnvironmentsProd().contentType//"application/json",
    };

    final response = await http.post(
      Uri.parse(ruta),
      headers: headers,
      body: jsonEncode(requestBody), 
    );
    
    var rspValidacion = json.decode(response.body);

    //if(rspValidacion['result']['mensaje'] == 'El tocken no es valido'){
    if(rspValidacion['result']['mensaje'] != null && (rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenNoValido || rspValidacion['result']['mensaje'].toString().trim().toLowerCase() == MessageValidation().tockenExpirado)){
      await tokenManager.checkTokenExpiration();
      await getMultiModelosGen(objReq, lstModels);
    }

    //print('Lst gen: ${response.body}');

    var rsp = AppResponseModel.fromRawJson(response.body);

    //print('Lst Prsp: ${json.encode(rsp.result.data.crmLead)}'); 

    await storage.write(key: 'RespuestaProspectos', value: json.encode(rsp.result.data.crmLead));
    await storage.write(key: 'RespuestaClientes', value: json.encode(rsp.result.data.resPartner));

    await storage.write(key: 'cmbCampania', value: json.encode(rsp.result.data.utmCampaign));
    await storage.write(key: 'cmbOrigen', value: json.encode(rsp.result.data.utmSource));
    await storage.write(key: 'cmbMedia', value: json.encode(rsp.result.data.utmMedium));
    await storage.write(key: 'cmbActividades', value: json.encode(rsp.result.data.mailActivityType));
    await storage.write(key: 'cmbPaises', value: json.encode(rsp.result.data.resCountry));
    await storage.write(key: 'cmbLstActividades', value: json.encode(rsp.result.data.mailActivity));
    await storage.write(key: 'RespuestaIrModel', value: json.encode(rsp.result.data.irResponse));

    return response.body;
    
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
}
