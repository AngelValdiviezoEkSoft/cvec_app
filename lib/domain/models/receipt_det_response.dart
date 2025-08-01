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
      accountPaymentLineTravel: json['customer_payment_receipts_report'] != null
          ? AccountPaymentLineTravel.fromJson(
              json['customer_payment_receipts_report'])
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
  String? quotaCode;
  double? lineAmount;
  String companyStreet;
  String companyStreet2;
  String companyWebsite;
  String customerName;
  String paymentRef;
  String companyPhone;

  PaymentLine({
    this.lineId,
    this.paymentId,
    this.contractId,
    this.contractName,
    this.quotaType,
    this.quotaId,
    this.quotaName,
    this.quotaCode,
    this.lineAmount,
    required this.companyStreet,
    required this.companyStreet2,
    required this.companyWebsite,
    required this.customerName,
    required this.paymentRef,
    required this.companyPhone,
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
      lineAmount: json['line_amount'] != null ? json['line_amount']?.toDouble() : 0,
      quotaCode: json['quota_code'],
      companyStreet: json['company_street'] ?? '',
      companyStreet2: json['company_street2'] ?? '',
      companyWebsite: json['company_website'] ?? '',
      customerName: json['customer_name'] ?? '',
      paymentRef: json['payment_ref'] ?? '',
      companyPhone: json['company_phone'] ?? '',
    );
  }
}
