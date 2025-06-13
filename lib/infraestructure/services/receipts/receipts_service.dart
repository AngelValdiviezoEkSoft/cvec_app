
import 'dart:convert';
import 'dart:io';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

const storageReceipts = FlutterSecureStorage();
AlertsMessages objMessageReceipt = AlertsMessages();
//ResponseValidation objResponseValidationService = ResponseValidation();

class ReceiptsService extends ChangeNotifier{

  final String endPoint = StringConection().apiEndpoint;

  final TokenManager tokenManager = TokenManager();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  Future<List<Payment>?> getReceipts() async {
    try{

      var codImei = await storageReceipts.read(key: 'codImei') ?? '';

      var objReg = await storageReceipts.read(key: 'RespuestaRegistro') ?? '';
      var obj = RegisterDeviceResponseModel.fromJson(objReg);

      var objLog = await storageReceipts.read(key: 'RespuestaLogin') ?? '';
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
          models: lstMultiModel,
          idConsulta: 0
        )
      );

      var objRsp = await GenericService().getMultiModelos(objReq, "account.payment", true);

      await storage.write(key: 'ListadoRecibos', value: '');
      await storage.write(key: 'ListadoRecibos', value: objRsp);

      final bookingResponse = ReceiptResponse.fromJson(jsonDecode(objRsp));

      List<Payment> bookingList = bookingResponse.result.data.accountPayment.data;

      return bookingList;
    }
    on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: objMessageReceipt.mensajeFallaInternet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
      return null;
    }
  }

  Future<List<PaymentLine>?> getDetReceipts(int idCab) async {
    try{

      var codImei = await storageReceipts.read(key: 'codImei') ?? '';

      var objReg = await storageReceipts.read(key: 'RespuestaRegistro') ?? '';
      var obj = RegisterDeviceResponseModel.fromJson(objReg);

      var objLog = await storageReceipts.read(key: 'RespuestaLogin') ?? '';
      var objLogDecode = json.decode(objLog);

      List<MultiModel> lstMultiModel = [];

      lstMultiModel.add(
        MultiModel(model: 'account.payment.line.travel')
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
          models: lstMultiModel,
          idConsulta: idCab
        )
      );

      var objRsp = await GenericService().getMultiModelos(objReq, "account.payment.line.travel", true);

      final bookingResponse = ReceiptDetResponse.fromJson(jsonDecode(objRsp));

      List<PaymentLine> bookingList = bookingResponse.result?.data?.accountPaymentLineTravel?.data ?? [];

      return bookingList;
    }
    on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: objMessageReceipt.mensajeFallaInternet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
      return null;
    }
  }

/*
  Future<List<Payment>?> getCompanies() async {
    try{

      var codImei = await storageReceipts.read(key: 'codImei') ?? '';

      var objReg = await storageReceipts.read(key: 'RespuestaRegistro') ?? '';
      var obj = RegisterDeviceResponseModel.fromJson(objReg);

      var objLog = await storageReceipts.read(key: 'RespuestaLogin') ?? '';
      var objLogDecode = json.decode(objLog);

      List<MultiModel> lstMultiModel = [];

      lstMultiModel.add(
        MultiModel(model: 'res.company')
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
          models: lstMultiModel
        )
      );

      var objRsp = await GenericService().getMultiModelosSinFiltro(objReq, "res.company");

      await storage.write(key: 'ListadoRecibos', value: '');
      await storage.write(key: 'ListadoRecibos', value: objRsp);

      final bookingResponse = ReceiptResponse.fromJson(jsonDecode(objRsp));

      List<Payment> bookingList = bookingResponse.result.data.data;

      return bookingList;
    }
    on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: objMessageReceipt.mensajeFallaInternet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
      return null;
    }
  }
*/
}
