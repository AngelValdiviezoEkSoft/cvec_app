/*
class SuscriptionDetResponseModel {
  final String jsonrpc;
  final dynamic id;
  final SuscriptionDetModel result;

  SuscriptionDetResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory SuscriptionDetResponseModel.fromJson(Map<String, dynamic> json) {
    return SuscriptionDetResponseModel(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: SuscriptionDetModel.fromJson(json['result']),
    );
  }
}

class SuscriptionDetModel {
  final int estado;
  final TravelQuotaContainer data;

  SuscriptionDetModel({
    required this.estado,
    required this.data,
  });

  factory SuscriptionDetModel.fromJson(Map<String, dynamic> json) {
    return SuscriptionDetModel(
      estado: json['estado'],
      data: TravelQuotaContainer.fromJson(json['data']),
    );
  }
}

class TravelQuotaContainer {
  final TravelQuotaData ekTravelSubscriptionQuota;

  TravelQuotaContainer({required this.ekTravelSubscriptionQuota});

  factory TravelQuotaContainer.fromJson(Map<String, dynamic> json) {
    return TravelQuotaContainer(
      ekTravelSubscriptionQuota:
          TravelQuotaData.fromJson(json['ek.travel.subscription.quota']),
    );
  }
}

class TravelQuotaData {
  final int length;
  final String fields;
  final List<Quota> data;

  TravelQuotaData({
    required this.length,
    required this.fields,
    required this.data,
  });

  factory TravelQuotaData.fromJson(Map<String, dynamic> json) {
    return TravelQuotaData(
      length: json['length'],
      fields: json['fields'],
      data: (json['data'] as List)
          .map((item) => Quota.fromJson(item))
          .toList(),
    );
  }
}

class Quota {
  final int quotaId;
  final String quotaName;
  final String quotaDueDate;
  final double quotaResidual;

  final double quotaAmount;
  final double quotaPaidAmount;
  final String quotaDatePayment;//date_payment
  final String quotaState;

  Quota({
    required this.quotaId,
    required this.quotaName,
    required this.quotaDueDate,
    required this.quotaResidual,

    required this.quotaAmount,
    required this.quotaPaidAmount,
    required this.quotaDatePayment,
    required this.quotaState
  });

  factory Quota.fromJson(Map<String, dynamic> json) {
    return Quota(
      quotaId: json['quota_id'] ?? 0,
      quotaName: json['quota_name'] ?? '',
      quotaDueDate: json['quota_due_date'] ?? '',
      quotaResidual: json['quota_residual'] != null ? (json['quota_residual'] as num).toDouble() : 0,

      quotaAmount: json['quota_amount'] != null ? (json['quota_amount'] as num).toDouble() : 0,
      quotaPaidAmount: json['quota_paid_amount'] != null ? (json['quota_paid_amount'] as num).toDouble() : 0,
      quotaDatePayment: json['quota_date_payment'] ?? '',
      quotaState: json['quota_state'] ?? '',
    );
  }
}
*/

class CustomerStatementQuotasResponse {
  final String jsonrpc;
  final dynamic id;
  final ResultCustomerStatementQuota result;

  CustomerStatementQuotasResponse({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory CustomerStatementQuotasResponse.fromJson(Map<String, dynamic> json) {
    return CustomerStatementQuotasResponse(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: ResultCustomerStatementQuota.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jsonrpc': jsonrpc,
        'id': id,
        'result': result.toJson(),
      };
}

class ResultCustomerStatementQuota {
  final int estado;
  final DataCustomerStatementQuota data;

  ResultCustomerStatementQuota({
    required this.estado,
    required this.data,
  });

  factory ResultCustomerStatementQuota.fromJson(Map<String, dynamic> json) {
    return ResultCustomerStatementQuota(
      estado: json['estado'],
      data: DataCustomerStatementQuota.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'estado': estado,
        'data': data.toJson(),
      };
}

class DataCustomerStatementQuota {
  final CustomerStatementQuotas customerStatementQuotas;

  DataCustomerStatementQuota({
    required this.customerStatementQuotas,
  });

  factory DataCustomerStatementQuota.fromJson(Map<String, dynamic> json) {
    return DataCustomerStatementQuota(
      customerStatementQuotas:
          CustomerStatementQuotas.fromJson(json['customer_debts_quotas']),
    );
  }

  Map<String, dynamic> toJson() => {
        'customer_debts_quotas': customerStatementQuotas.toJson(),
      };
}

class CustomerStatementQuotas {
  final int length;
  final List<Quota> data;

  CustomerStatementQuotas({
    required this.length,
    required this.data,
  });

  factory CustomerStatementQuotas.fromJson(Map<String, dynamic> json) {
    return CustomerStatementQuotas(
      length: json['length'],
      data: List<Quota>.from(json['data'].map((x) => Quota.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'length': length,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Quota {
  final int quotaId;
  final String contractName;
  final String quotaDueDate;
  final String quotaName;
  final double quotaPaidAmount;
  final double quotaResidual;
  final String quotaPaidDate;
  final String quotaState;

  Quota({
    required this.quotaId,
    required this.contractName,
    required this.quotaDueDate,
    required this.quotaName,
    required this.quotaPaidAmount,
    required this.quotaResidual,
    required this.quotaPaidDate,
    required this.quotaState,
  });

  factory Quota.fromJson(Map<String, dynamic> json) {
    return Quota(
      quotaId: json['quota_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      quotaDueDate: json['quota_due_date'] ?? '',
      quotaName: json['quota_name'] ?? '',
      quotaPaidAmount: json['quota_paid_amount'] != null ? (json['quota_paid_amount'] as num).toDouble() : 0,
      quotaResidual: json['quota_residual'] != null ? (json['quota_residual'] as num).toDouble() : 0,
      quotaPaidDate: json['quota_paid_date'] ?? '',
      quotaState: json['quota_state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'quota_id': quotaId,
        'contract_name': contractName,
        'quota_due_date': quotaDueDate,
        'quota_name': quotaName,
        'quota_paid_amount': quotaPaidAmount,
        'quota_residual': quotaResidual,
        'quota_paid_date': quotaPaidDate,
        'quota_state': quotaState,
      };
}
