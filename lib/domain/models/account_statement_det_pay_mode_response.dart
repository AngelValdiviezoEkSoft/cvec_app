class AccountStatementDetPayResponseModel {
  final String jsonrpc;
  final dynamic id;
  final AccountStatementDetPayResultModel result;

  AccountStatementDetPayResponseModel({required this.jsonrpc, this.id, required this.result});

  factory AccountStatementDetPayResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementDetPayResponseModel(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'] ?? 0,
      result: AccountStatementDetPayResultModel.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jsonrpc': jsonrpc,
        'id': id,
        'result': result.toJson(),
      };
}

class AccountStatementDetPayResultModel {
  final int estado;
  final AccountStatementDetPayModel data;

  AccountStatementDetPayResultModel({required this.estado, required this.data});

  factory AccountStatementDetPayResultModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementDetPayResultModel(
      estado: json['estado'],
      data: AccountStatementDetPayModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'estado': estado,
        'data': data.toJson(),
      };
}

class AccountStatementDetPayModel {
  final PaymentLineTravel accountPaymentLineTravel;

  AccountStatementDetPayModel({required this.accountPaymentLineTravel});

  factory AccountStatementDetPayModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementDetPayModel(
      accountPaymentLineTravel:
          PaymentLineTravel.fromJson(json['customer_statement_payments']),
    );
  }

  Map<String, dynamic> toJson() => {
        'customer_statement_payments': accountPaymentLineTravel.toJson(),
      };
}

class PaymentLineTravel {
  final int length;
  final dynamic fields;
  final List<PaymentLineData> data;

  PaymentLineTravel({
    required this.length,
    required this.fields,
    required this.data,
  });

  factory PaymentLineTravel.fromJson(Map<String, dynamic> json) {
    return PaymentLineTravel(
      length: json['length'],
      fields: json['fields'],
      data: List<PaymentLineData>.from(
        json['data'].map((x) => PaymentLineData.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'length': length,
        'fields': fields,
        'data': data.map((x) => x.toJson()).toList(),
      };
}

class PaymentLineData {
  final int paymentLineId;
  final int quotaId;
  final String paymentSequence;
  final String paymentDate;
  final double paymentAmount;
  final int lineId;
  final int paymentId;
  final int contractId;
  final String contractName;
  final String quotaType;
  final String quotaName;
  final String quotaCode;
  final double lineAmount;

  PaymentLineData({
    required this.paymentLineId,
    required this.quotaId,
    required this.paymentSequence,
    required this.paymentDate,
    required this.paymentAmount,
    required this.lineId,
    required this.paymentId,
    required this.contractId,
    required this.contractName,
    required this.quotaType,
    required this.quotaName,
    required this.quotaCode,
    required this.lineAmount,
  });

  factory PaymentLineData.fromJson(Map<String, dynamic> json) {
    return PaymentLineData(
      paymentLineId: json['payment_line_id'] ?? 0,
      quotaId: json['quota_id'] ?? 0,
      paymentSequence: json['payment_sequence'] ?? '',
      paymentDate: json['payment_date'] ?? '',
      paymentAmount: json['payment_amount'] != null ? (json['payment_amount'] as num).toDouble() : 0,
      lineId: json['line_id'] ?? 0,
      paymentId: json['payment_id'] ?? 0,
      contractId: json['contract_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      quotaType: json['quota_type'] ?? '',
      quotaName: json['quota_name'] ?? '',
      quotaCode: json['quota_code'] ?? '',
      lineAmount: json['line_amount'] != null ? (json['line_amount'] as num).toDouble() : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'payment_line_id': paymentLineId,
        'quota_id': quotaId,
        'payment_sequence': paymentSequence,
        'payment_date': paymentDate,
        'payment_amount': paymentAmount,
        'line_id': lineId,
        'payment_id': paymentId,
        'contract_id': contractId,
        'contract_name': contractName,
        'quota_type': quotaType,
        'quota_name': quotaName,
        'quota_code': quotaCode,
        'line_amount': lineAmount,
      };
}
