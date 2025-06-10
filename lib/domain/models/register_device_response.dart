
import 'dart:convert';

import 'package:cve_app/domain/domain.dart';

class RegisterDeviceResponseModel {
    String jsonrpc;
    dynamic id;
    RegisterDeviceModel result;

    RegisterDeviceResponseModel({
        required this.jsonrpc,
        required this.id,
        required this.result,
    });

    factory RegisterDeviceResponseModel.fromJson(String str) => RegisterDeviceResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterDeviceResponseModel.fromMap(Map<String, dynamic> json) => RegisterDeviceResponseModel(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] != null ? RegisterDeviceModel.fromMap(json["result"]) 
          : RegisterDeviceModel(bearer: '', database: '', estado: 0, key: '', serverUrl: '', tocken: '', tockenValidDate: DateTime.now(), url: '', msmError: ''),
    );

    Map<String, dynamic> toMap() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
    };
}
