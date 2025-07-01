
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

  Quota({
    required this.quotaId,
    required this.quotaName,
    required this.quotaDueDate,
    required this.quotaResidual,
  });

  factory Quota.fromJson(Map<String, dynamic> json) {
    return Quota(
      quotaId: json['quota_id'],
      quotaName: json['quota_name'],
      quotaDueDate: json['quota_due_date'],
      quotaResidual: (json['quota_residual'] as num).toDouble(),
    );
  }
}
