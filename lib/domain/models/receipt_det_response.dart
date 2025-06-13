class ReceiptDetResponse {
  String? jsonrpc;
  dynamic id;
  ResultReceiptDet? result;

  ReceiptDetResponse({this.jsonrpc, this.id, this.result});

  factory ReceiptDetResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptDetResponse(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: json['result'] != null ? ResultReceiptDet.fromJson(json['result']) : null,
    );
  }
}

class ResultReceiptDet {
  int? estado;
  DataReceiptDet? data;

  ResultReceiptDet({this.estado, this.data});

  factory ResultReceiptDet.fromJson(Map<String, dynamic> json) {
    return ResultReceiptDet(
      estado: json['estado'],
      data: json['data'] != null ? DataReceiptDet.fromJson(json['data']) : null,
    );
  }
}

class DataReceiptDet {
  AccountPaymentLineTravel? accountPaymentLineTravel;

  DataReceiptDet({this.accountPaymentLineTravel});

  factory DataReceiptDet.fromJson(Map<String, dynamic> json) {
    return DataReceiptDet(
      accountPaymentLineTravel: json['account.payment.line.travel'] != null
          ? AccountPaymentLineTravel.fromJson(
              json['account.payment.line.travel'])
          : null,
    );
  }
}

class AccountPaymentLineTravel {
  int? length;
  String? fields;
  List<PaymentLine>? data;

  AccountPaymentLineTravel({this.length, this.fields, this.data});

  factory AccountPaymentLineTravel.fromJson(Map<String, dynamic> json) {
    return AccountPaymentLineTravel(
      length: json['length'] ?? 0,
      fields: json['fields'] ?? '',
      data: json['data'] != null
          ? List<PaymentLine>.from(
              json['data'].map((x) => PaymentLine.fromJson(x)))
          : [],
    );
  }
}

class PaymentLine {
  int? lineId;
  int? paymentId;
  int? contractId;
  String? contractName;
  String? quotaType;
  int? quotaId;
  String? quotaName;
  double? lineAmount;

  PaymentLine({
    this.lineId,
    this.paymentId,
    this.contractId,
    this.contractName,
    this.quotaType,
    this.quotaId,
    this.quotaName,
    this.lineAmount,
  });

  factory PaymentLine.fromJson(Map<String, dynamic> json) {
    return PaymentLine(
      lineId: json['line_id'] ?? 0,
      paymentId: json['payment_id'] ?? 0,
      contractId: json['contract_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      quotaType: json['quota_type'] ?? '',
      quotaId: json['quota_id'] ?? 0,
      quotaName: json['quota_name'] ?? '',
      lineAmount: json['line_amount']?.toDouble(),
    );
  }
}
