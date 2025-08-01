/*
class SubscriptionResponseModel {
  final String jsonrpc;
  final dynamic id;
  final SubscriptionResponse result;

  SubscriptionResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponseModel(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'] ?? 0,
      result: json['result'] != null ? SubscriptionResponse.fromJson(json['result']) 
      : SubscriptionResponse(data: SaleSubscriptionData(data: [], fields: '', length: 0), estado: 0),
    );
  }
}

class SubscriptionResponse {
  final int estado;
  final SaleSubscriptionData data;

  SubscriptionResponse({
    required this.estado,
    required this.data,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      estado: json['estado'] ?? '',
      data: json['data']['customer_statement_contracts'] != null ? SaleSubscriptionData.fromJson(json['data']['sale.subscription'])
      : SaleSubscriptionData(data: [], fields: '', length: 0),
    );
  }
}

class SaleSubscriptionData {
  final int length;
  final String fields;
  final List<Subscription> data;

  SaleSubscriptionData({
    required this.length,
    required this.fields,
    required this.data,
  });

  factory SaleSubscriptionData.fromJson(Map<String, dynamic> json) {
    print('Result: ${json['data']}');

    return SaleSubscriptionData(
      length: json['length'] ?? 0,
      fields: '',//json['fields'] ?? '',
      data: json['data'] != null ? //List<Subscription>.from(json['data'].map((x) => Subscription.fromJson(x))) : [],
      
      (json['data'] as List)
          .map((item) => Subscription.fromJson(item))
          .toList() : [],
          
    );
  }
}

class Subscription {
  final int contractId;
  final String contractName;
  final String contractPlan;
  final String contractInscriptionDate;
  final double contractResidual;

  final String contractDueDate;
  final double contractTotalAmount;
  final double contractPaidAmount;
  final double contractPaidPercent;
  final String contractState;

  Subscription({
    required this.contractId,
    required this.contractName,
    required this.contractPlan,
    required this.contractInscriptionDate,
    required this.contractResidual,

    required this.contractDueDate,
    required this.contractTotalAmount,
    required this.contractPaidAmount,
    required this.contractPaidPercent,
    required this.contractState
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      contractId: json['contract_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      contractPlan: json['contract_plan'] ?? '',
      contractInscriptionDate: json['contract_inscription_date'] ?? '',
      contractResidual: json['contract_residual'] != null ? (json['contract_residual'] as num).toDouble() : 0,

      contractDueDate: json['contract_due_date'] ?? '',
      contractTotalAmount: json['contract_total_amount'] != null ? (json['contract_total_amount'] as num).toDouble() : 0,//json[''] ?? '',
      contractPaidAmount: json['contract_paid_amount'] != null ? (json['contract_paid_amount'] as num).toDouble() : 0,//json[''] ?? '',
      contractPaidPercent: json['contract_paid_percent'] != null ? (json['contract_paid_percent'] as num).toDouble() : 0,//json[''] ?? '',
      contractState: json['contract_state'] ?? '',
    );
  }
}
*/

class SubscriptionResponseModel {
  final String jsonrpc;
  final dynamic id;
  final SubscriptionResponse result;

  SubscriptionResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponseModel(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: SubscriptionResponse.fromJson(json['result']),
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

class SubscriptionResponse {
  final int estado;
  final SaleSubscriptionData data;

  SubscriptionResponse({
    required this.estado,
    required this.data,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      estado: json['estado'],
      data: SaleSubscriptionData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'data': data.toJson(),
    };
  }
}

class SaleSubscriptionData {
  final CustomerStatementContracts customerStatementContracts;

  SaleSubscriptionData({required this.customerStatementContracts});

  factory SaleSubscriptionData.fromJson(Map<String, dynamic> json) {
    return SaleSubscriptionData(
      customerStatementContracts: CustomerStatementContracts.fromJson(json['customer_debts_contracts']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_debts_contracts': customerStatementContracts.toJson(),
    };
  }
}

class CustomerStatementContracts {
  final int length;
  final List<Subscription> data;

  CustomerStatementContracts({
    required this.length,
    required this.data,
  });

  factory CustomerStatementContracts.fromJson(Map<String, dynamic> json) {
    return CustomerStatementContracts(
      length: json['length'],
      data: (json['data'] as List).map((e) => Subscription.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Subscription {
  final int contractId;
  final String contractName;
  final String contractPlan;
  final String contractInscriptionDate;
  final String contractDueDate;
  final double contractTotalAmount;
  final double contractPaidAmount;
  final double contractPaidPercent;
  final double contractResidual;
  final String contractState;

  Subscription({
    required this.contractId,
    required this.contractName,
    required this.contractPlan,
    required this.contractInscriptionDate,
    required this.contractDueDate,
    required this.contractTotalAmount,
    required this.contractPaidAmount,
    required this.contractPaidPercent,
    required this.contractResidual,
    required this.contractState,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      contractId: json['contract_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      contractPlan: json['contract_plan'] ?? '',
      contractInscriptionDate: json['contract_inscription_date'] ?? '',
      contractDueDate: json['contract_due_date'] ?? '',
      contractTotalAmount: json['contract_total_amount'] != null ? (json['contract_total_amount'] as num).toDouble() : 0,
      contractPaidAmount: json['contract_paid_amount'] != null ? (json['contract_paid_amount'] as num).toDouble() : 0,
      contractPaidPercent: json['contract_paid_percent'] != null ? (json['contract_paid_percent'] as num).toDouble() : 0,
      contractResidual: json['contract_residual'] != null ? (json['contract_residual'] as num).toDouble() : 0,
      contractState: json['contract_state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contract_id': contractId,
      'contract_name': contractName,
      'contract_plan': contractPlan,
      'contract_inscription_date': contractInscriptionDate,
      'contract_due_date': contractDueDate,
      'contract_total_amount': contractTotalAmount,
      'contract_paid_amount': contractPaidAmount,
      'contract_paid_percent': contractPaidPercent,
      'contract_residual': contractResidual,
      'contract_state': contractState,
    };
  }
}
