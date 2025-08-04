class AccountStatementDetResponseModel {
  String? jsonrpc;
  dynamic id;
  AccountStatementDetModel result;

  AccountStatementDetResponseModel({this.jsonrpc, this.id, required this.result});

  factory AccountStatementDetResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementDetResponseModel(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: AccountStatementDetModel.fromJson(json['result']),
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

class AccountStatementDetModel {
  int? estado;
  DataAccountStatementDetModel data;

  AccountStatementDetModel({this.estado, required this.data});

  factory AccountStatementDetModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementDetModel(
      estado: json['estado'],
      data: json['data'] != null ? DataAccountStatementDetModel.fromJson(json['data']) : DataAccountStatementDetModel(customerStatementQuotas: AccountStatementDetMod(data: [], length: 0)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'data': data.toJson(),
    };
  }
}

class DataAccountStatementDetModel {
  AccountStatementDetMod customerStatementQuotas;

  DataAccountStatementDetModel({required this.customerStatementQuotas});

  factory DataAccountStatementDetModel.fromJson(Map<String, dynamic> json) {
    return DataAccountStatementDetModel(
      customerStatementQuotas: json['customer_statement_quotas'] != null
          ? AccountStatementDetMod.fromJson(json['customer_statement_quotas'])
          : AccountStatementDetMod(data: [], length: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_statement_quotas': customerStatementQuotas.toJson(),
    };
  }
}

class AccountStatementDetMod {
  int? length;
  List<AccountStatementDet> data;

  AccountStatementDetMod({this.length, required this.data});

  factory AccountStatementDetMod.fromJson(Map<String, dynamic> json) {
    return AccountStatementDetMod(
      length: json['length'],
      data: json['data'] != null
          ? List<AccountStatementDet>.from(json['data'].map((x) => AccountStatementDet.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}

class AccountStatementDet {
  int quotaId;
  String contractName;
  String quotaDueDate;
  String quotaName;
  double quotaPaidAmount;
  double quotaAmount;
  String quotaPaidDate;
  String quotaState;

  AccountStatementDet({
    required this.quotaId,
    required this.contractName,
    required this.quotaDueDate,
    required this.quotaName,
    required this.quotaPaidAmount,
    required this.quotaAmount,
    required this.quotaPaidDate,
    required this.quotaState,
  });

  factory AccountStatementDet.fromJson(Map<String, dynamic> json) {
    return AccountStatementDet(
      quotaId: json['quota_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      quotaDueDate: json['quota_due_date'] ?? '',
      quotaName: json['quota_name'] ?? '',
      quotaPaidAmount: json['quota_paid_amount'] != null ? (json['quota_paid_amount'] as num).toDouble() : 0,
      quotaAmount: json['quota_amount'] != null ? (json['quota_amount'] as num).toDouble() : 0,
      quotaPaidDate: json['quota_paid_date'] ?? '',
      quotaState: json['quota_state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quota_id': quotaId,
      'contract_name': contractName,
      'quota_due_date': quotaDueDate,
      'quota_name': quotaName,
      'quota_paid_amount': quotaPaidAmount,
      'quota_amount': quotaAmount,
      'quota_paid_date': quotaPaidDate,
      'quota_state': quotaState,
    };
  }
}
