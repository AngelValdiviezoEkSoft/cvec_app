/*
class AccountStatementReportResponseModel {
  final String jsonrpc;
  final dynamic id;
  final AccountStatementReportResponse result;

  AccountStatementReportResponseModel({
    required this.jsonrpc,
    this.id,
    required this.result,
  });

  factory AccountStatementReportResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementReportResponseModel(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: AccountStatementReportResponse.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonrpc': jsonrpc,
      'id': id,
      'result': result.toJson(),
    };
  }
}

class AccountStatementReportResponse {
  final int estado;
  final CustomerData data;

  AccountStatementReportResponse({required this.estado, required this.data});

  factory AccountStatementReportResponse.fromJson(Map<String, dynamic> json) {
    return AccountStatementReportResponse(
      estado: json['estado'],
      data: CustomerData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'data': data.toJson(),
    };
  }
}

class CustomerData {
  final CustomerStatement customerStatement;

  CustomerData({required this.customerStatement});

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      customerStatement: CustomerStatement.fromJson(json['customer_statement']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_statement': customerStatement.toJson(),
    };
  }
}

class CustomerStatement {
  final int length;
  final List<CustomerStatementItem> data;

  CustomerStatement({required this.length, required this.data});

  factory CustomerStatement.fromJson(Map<String, dynamic> json) {
    return CustomerStatement(
      length: json['length'],
      data: (json['data'] as List)
          .map((item) => CustomerStatementItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomerStatementItem {
  final int partnerId;
  final int contractId;
  final String partnerName;
  final String contractName;
  final String planName;
  final String contractState;
  final String quotaDueDate;
  final String quotaName;
  final double quotaAmount;
  final String quotaState;
  final String paymentSequence;
  final String paymentMethodName;
  final double? paymentAmount;
  final double? quotaResidual;
  final String paymentDate;
  final String paymentState;

  CustomerStatementItem({
    required this.partnerId,
    required this.contractId,
    required this.partnerName,
    required this.contractName,
    required this.planName,
    required this.contractState,
    required this.quotaDueDate,
    required this.quotaName,
    required this.quotaAmount,
    required this.quotaState,
    required this.paymentSequence,
    required this.paymentMethodName,
    this.paymentAmount,
    this.quotaResidual,
    required this.paymentDate,
    required this.paymentState,
  });

  factory CustomerStatementItem.fromJson(Map<String, dynamic> json) {
    return CustomerStatementItem(
      partnerId: json['partner_id'] ?? 0,
      contractId: json['contract_id'] ?? 0,
      partnerName: json['partner_name'] ?? '',
      contractName: json['contract_name'] ?? '',
      planName: json['plan_name'] ?? '',
      contractState: json['contract_state'] ?? '',
      quotaDueDate: json['quota_due_date'] ?? '',
      quotaName: json['quota_name'] ?? '',
      quotaAmount: (json['quota_amount'] ?? 0).toDouble(),
      quotaState: json['quota_state'] ?? '',
      paymentSequence: json['payment_sequence'] ?? '',
      paymentMethodName: json['payment_method_name'] ?? '',
      paymentAmount: json['payment_amount'] != null
          ? (json['payment_amount']).toDouble()
          : null,
      quotaResidual: json['quota_residual'] != null
          ? (json['quota_residual']).toDouble()
          : null,
      paymentDate: json['payment_date'] ?? '',
      paymentState: json['payment_state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partner_id': partnerId,
      'contract_id': contractId,
      'partner_name': partnerName,
      'contract_name': contractName,
      'plan_name': planName,
      'contract_state': contractState,
      'quota_due_date': quotaDueDate,
      'quota_name': quotaName,
      'quota_amount': quotaAmount,
      'quota_state': quotaState,
      'payment_sequence': paymentSequence,
      'payment_method_name': paymentMethodName,
      'payment_amount': paymentAmount,
      'quota_residual': quotaResidual,
      'payment_date': paymentDate,
      'payment_state': paymentState,
    };
  }
}
*/

class AccountStatementReportResponseModel {
  final String jsonrpc;
  final dynamic id;
  final AccountStatementReportResponse result;

  AccountStatementReportResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory AccountStatementReportResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementReportResponseModel(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: AccountStatementReportResponse.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonrpc': jsonrpc,
      'id': id,
      'result': result.toJson(),
    };
  }
}

class AccountStatementReportResponse {
  final int estado;
  final CustomerData data;

  AccountStatementReportResponse({required this.estado, required this.data});

  factory AccountStatementReportResponse.fromJson(Map<String, dynamic> json) {
    return AccountStatementReportResponse(
      estado: json['estado'],
      data: CustomerData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'data': data.toJson(),
    };
  }
}

class CustomerData {
  final CustomerStatementReport customerStatementReport;

  CustomerData({required this.customerStatementReport});

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      customerStatementReport: CustomerStatementReport.fromJson(json['customer_statement_report']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_statement_report': customerStatementReport.toJson(),
    };
  }
}

class CustomerStatementReport {
  final int length;
  final List<CustomerStatementItem> data;

  CustomerStatementReport({required this.length, required this.data});

  factory CustomerStatementReport.fromJson(Map<String, dynamic> json) {
    return CustomerStatementReport(
      length: json['length'],
      data: (json['data'] as List).map((e) => CustomerStatementItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomerStatementItem {
  final int partnerId;
  final int contractId;
  final String partnerName;
  final String contractName;
  final String planName;
  final String contractState;
  final String quotaDueDate;
  final String quotaName;
  final double quotaAmount;
  final String quotaState;
  final String paymentSequence;
  final String paymentMethodName;
  final double paymentAmount;
  final double quotaResidual;
  final String paymentDate;
  final String paymentState;

  CustomerStatementItem({
    required this.partnerId,
    required this.contractId,
    required this.partnerName,
    required this.contractName,
    required this.planName,
    required this.contractState,
    required this.quotaDueDate,
    required this.quotaName,
    required this.quotaAmount,
    required this.quotaState,
    required this.paymentSequence,
    required this.paymentMethodName,
    required this.paymentAmount,
    required this.quotaResidual,
    required this.paymentDate,
    required this.paymentState,
  });

  factory CustomerStatementItem.fromJson(Map<String, dynamic> json) {
    return CustomerStatementItem(
      partnerId: json['partner_id'] ?? 0,
      contractId: json['contract_id'] ?? 0,
      partnerName: json['partner_name'] ?? '',
      contractName: json['contract_name'] ?? '',
      planName: json['plan_name'] ?? '',
      contractState: json['contract_state'] ?? '',
      quotaDueDate: json['quota_due_date'] ?? '',
      quotaName: json['quota_name'] ?? '',
      quotaAmount: json['quota_amount'] != null ? (json['quota_amount'] as num).toDouble() : 0,
      quotaState: json['quota_state'] ?? '',
      paymentSequence: json['payment_sequence'] ?? '',
      paymentMethodName: json['payment_method_name'] ?? '',
      paymentAmount: json['payment_amount'] != null ? (json['payment_amount'] as num).toDouble() : 0,
      quotaResidual: json['quota_residual'] != null ? (json['quota_residual'] as num).toDouble() : 0,
      paymentDate: json['payment_date'] ?? '',
      paymentState: json['payment_state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partner_id': partnerId,
      'contract_id': contractId,
      'partner_name': partnerName,
      'contract_name': contractName,
      'plan_name': planName,
      'contract_state': contractState,
      'quota_due_date': quotaDueDate,
      'quota_name': quotaName,
      'quota_amount': quotaAmount,
      'quota_state': quotaState,
      'payment_sequence': paymentSequence,
      'payment_method_name': paymentMethodName,
      'payment_amount': paymentAmount,
      'quota_residual': quotaResidual,
      'payment_date': paymentDate,
      'payment_state': paymentState,
    };
  }
}
