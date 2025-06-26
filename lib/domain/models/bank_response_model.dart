
class BankResponse {
  final String jsonrpc;
  final dynamic id;
  final BankResult result;

  BankResponse({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory BankResponse.fromJson(Map<String, dynamic> json) {
    return BankResponse(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'] ?? 0,
      result: BankResult.fromJson(json['result']),
    );
  }

}

class BankResult {
  final int estado;
  final BankData data;

  BankResult({
    required this.estado,
    required this.data,
  });

  factory BankResult.fromJson(Map<String, dynamic> json) {
    return BankResult(
      estado: json['estado'] ?? 0,
      data: BankData.fromJson(json['data']),
    );
  }
}

class BankData {
  final PartnerBank resPartnerBank;

  BankData({required this.resPartnerBank});

  factory BankData.fromJson(Map<String, dynamic> json) {
    return BankData(
      resPartnerBank: PartnerBank.fromJson(json['res.partner.bank']),
    );
  }
}

class PartnerBank {
  final int length;
  final dynamic fields; // puedes cambiar a String si siempre es "None"
  final List<BankAccount> data;

  PartnerBank({
    required this.length,
    required this.fields,
    required this.data,
  });

  factory PartnerBank.fromJson(Map<String, dynamic> json) {
    var dataList = (json['data'] as List)
        .map((e) => BankAccount.fromJson(e))
        .toList();

    return PartnerBank(
      length: json['length'] ?? 0,
      fields: json['fields'] ?? '',
      data: dataList,
    );
  }
}

class BankAccount {
  final int bankAccountId;
  final String bankName;
  final String bankAccountHolder;

  BankAccount({
    required this.bankAccountId,
    required this.bankName,
    required this.bankAccountHolder,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      bankAccountId: json['bank_account_id'] ?? 0,
      bankName: json['bank_name'] ?? '',
      bankAccountHolder: json['bank_account_holder'] ?? '',
    );
  }
}
