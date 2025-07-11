
import 'dart:convert';
import 'dart:io';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:fluttertoast/fluttertoast.dart';

const storageProspecto = FlutterSecureStorage();
AlertsMessages objMensajesProspectoService = AlertsMessages();
ResponseValidation objResponseValidationService = ResponseValidation();

class ReservationsService extends ChangeNotifier{

  final String endPoint = StringConection().apiEndpoint;

  final TokenManager tokenManager = TokenManager();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  Future<List<Booking>?> getReservations() async {
    try{

      var codImei = await storageProspecto.read(key: 'codImei') ?? '';

      var objReg = await storageProspecto.read(key: 'RespuestaRegistro') ?? '';
      var obj = RegisterDeviceResponseModel.fromJson(objReg);

      var objLog = await storageProspecto.read(key: 'RespuestaLogin') ?? '';
      var objLogDecode = json.decode(objLog);

      List<MultiModel> lstMultiModel = [];

      lstMultiModel.add(
        MultiModel(model: 'crm.lead')
      );

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
          models: lstMultiModel
        )
      );

      var objRsp = await GenericService().getMultiModelos(objReq, "ek.travel.contract.bookings", false, '');

      await storage.write(key: 'ListadoReservaciones', value: '');
      await storage.write(key: 'ListadoReservaciones', value: objRsp);

      final bookingResponse = BookingResponse.fromJson(jsonDecode(objRsp));

      List<Booking> bookingList = bookingResponse.result.data.bookings.data;

      return bookingList;
    }
    on SocketException catch (_) {
      /*
      Fluttertoast.showToast(
        msg: objMensajesProspectoService.mensajeFallaInternet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
      */
      return null;
    }
  }

}
