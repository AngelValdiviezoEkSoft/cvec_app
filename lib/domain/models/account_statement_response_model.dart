class AccountStatementResponseModel {
  String? jsonrpc;
  dynamic id;
  Result result;

  AccountStatementResponseModel({this.jsonrpc, this.id, required this.result});

  factory AccountStatementResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementResponseModel(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: json['result'] != null ? Result.fromJson(json['result']) : Result(data: Data(customerStatementContracts: CustomerStatementContractsModel(data: [], length: 0)), estado: 0),
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

class Result {
  int? estado;
  Data data;

  Result({this.estado, required this.data});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      estado: json['estado'],
      data: json['data'] != null ? Data.fromJson(json['data']) : Data(customerStatementContracts: CustomerStatementContractsModel(data: [], length: 0)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'data': data.toJson(),
    };
  }
}

class Data {
  CustomerStatementContractsModel customerStatementContracts;

  Data({required this.customerStatementContracts});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      customerStatementContracts: json['customer_statement_contracts'] != null
          ? CustomerStatementContractsModel.fromJson(json['customer_statement_contracts'])
          : CustomerStatementContractsModel(data: [], length: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_statement_contracts': customerStatementContracts.toJson(),
    };
  }
}

class CustomerStatementContractsModel {
  int? length;
  List<Contract> data;

  CustomerStatementContractsModel({this.length, required this.data});

  factory CustomerStatementContractsModel.fromJson(Map<String, dynamic> json) {
    return CustomerStatementContractsModel(
      length: json['length'],
      data: json['data'] != null
          ? List<Contract>.from(json['data'].map((x) => Contract.fromJson(x)))
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

class Contract {
  int contractId;
  String contractName;
  String contractPlan;
  String contractInscriptionDate;
  String contractDueDate;
  double contractTotalAmount;
  double contractPaidAmount;
  double contractPaidPercent;
  double contractResidual;
  String contractState;

  Contract({
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

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractId: json['contract_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      contractPlan: json['contract_plan'] ?? '',
      contractInscriptionDate: json['contract_inscription_date'] ?? '',
      contractDueDate: json['contract_due_date'] ?? '',
      contractTotalAmount: json['contract_total_amount'] != null ? (json['contract_total_amount'] as num).toDouble() : 0,
      contractPaidAmount: json['contract_paid_amount'] != null ? (json['contract_paid_amount'] as num).toDouble() : 0,
      contractPaidPercent: json['contract_paid_percent'] != null ? (json['contract_paid_percent'] as num).toDouble() : 0,
      contractResidual: json['contract_residual'] != null ?(json['contract_residual'] as num).toDouble() : 0,
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
