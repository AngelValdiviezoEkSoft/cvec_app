class ApiRespuestaResponseModel {
  final String jsonrpc;
  final dynamic id;
  final ApiResponse result;

  ApiRespuestaResponseModel({
    required this.jsonrpc,
    this.id,
    required this.result,
  });

  factory ApiRespuestaResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiRespuestaResponseModel(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: ApiResponse.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jsonrpc': jsonrpc,
        'id': id,
        'result': result.toJson(),
      };
}

class ApiResponse {
  final int estado;
  final String mensaje;
  //final CustomerReceiptRecords data;

  ApiResponse({
    required this.estado,
    required this.mensaje,
    //required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      estado: json['estado'],
      mensaje: json['mensaje'],
      //data: CustomerReceiptRecords.fromJson(json['data']['customer_receipt_records_create']),
    );
  }

  Map<String, dynamic> toJson() => {
        'estado': estado,
        'mensaje': mensaje,
        /*
        'data': {
          'customer_receipt_records_create': data.toJson(),
        },
        */
      };
}

class CustomerReceiptRecords {
  final int length;
  final List<String> data;

  CustomerReceiptRecords({
    required this.length,
    required this.data,
  });

  factory CustomerReceiptRecords.fromJson(Map<String, dynamic> json) {
    return CustomerReceiptRecords(
      length: json['length'],
      data: List<String>.from(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'length': length,
        'data': data,
      };
}
