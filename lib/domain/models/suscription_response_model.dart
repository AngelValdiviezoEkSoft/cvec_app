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
      result: SubscriptionResponse.fromJson(json['result']),
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
      data: SaleSubscriptionData.fromJson(json['data']['sale.subscription']),
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
    return SaleSubscriptionData(
      length: json['length'] ?? 0,
      fields: json['fields'] ?? '',
      data: (json['data'] as List)
          .map((item) => Subscription.fromJson(item))
          .toList(),
    );
  }
}

class Subscription {
  final int contractId;
  final String contractName;
  final String contractPlan;
  final String contractInscriptionDate;
  final double contractResidual;

  Subscription({
    required this.contractId,
    required this.contractName,
    required this.contractPlan,
    required this.contractInscriptionDate,
    required this.contractResidual,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      contractId: json['contract_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      contractPlan: json['contract_plan'] ?? '',
      contractInscriptionDate: json['contract_inscription_date'] ?? '',
      contractResidual: json['contract_residual'] != null ? (json['contract_residual'] as num).toDouble() : 0,
    );
  }
}
