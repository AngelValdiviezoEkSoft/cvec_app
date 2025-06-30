class ReceiptResponseModel {
  final String jsonrpc;
  final dynamic id;
  final ResultReceiptResponse result;

  ReceiptResponseModel({
    required this.jsonrpc,
    this.id,
    required this.result,
  });

  factory ReceiptResponseModel.fromJson(Map<String, dynamic> json) {
    return ReceiptResponseModel(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'] ?? '',
      result: ResultReceiptResponse.fromJson(json['result']),
    );
  }
  
}

class ResultReceiptResponse {
  final int estado;
  final ReceiptDataModel data;

  ResultReceiptResponse({
    required this.estado,
    required this.data,
  });

  factory ResultReceiptResponse.fromJson(Map<String, dynamic> json) {
    return ResultReceiptResponse(
      estado: json['estado'] ?? 0,
      data: ReceiptDataModel.fromJson(json['data']['ek.customer.receipt.record']),
    );
  }
}

class ReceiptDataModel {
  final int length;
  final String? fields;
  final List<ReceiptModelResponse> data;

  ReceiptDataModel({
    required this.length,
    this.fields,
    required this.data,
  });

  factory ReceiptDataModel.fromJson(Map<String, dynamic> json) {
    return ReceiptDataModel(
      length: json['length'] ?? 0,
      fields: json['fields'] ?? '',
      data: (json['data'] as List)
          .map((e) => ReceiptModelResponse.fromJson(e))
          .toList(),
    );
  }
}

class ReceiptModelResponse {
  final double receiptAmount;
  final String receiptNumber;
  final String receiptDate;
  final String receiptConcept;
  final String? receiptNotes;
  final int receiptBankAccountId;
  final String receiptBankName;
  final String receiptBankAccountHolder;
  final String receiptState;
  final String receiptFile;
  final String receiptComment;
  final String receiptDateApproving;

  ReceiptModelResponse({
    required this.receiptAmount,
    required this.receiptNumber,
    required this.receiptDate,
    required this.receiptConcept,
    this.receiptNotes,
    required this.receiptBankAccountId,
    required this.receiptBankName,
    required this.receiptBankAccountHolder,
    required this.receiptState,
    required this.receiptFile,
    required this.receiptComment,
    required this.receiptDateApproving
  });

  factory ReceiptModelResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptModelResponse(
      receiptAmount: json['receipt_amount'] != null ?
        (json['receipt_amount'] as num).toDouble() : 0,
      receiptNumber: json['receipt_number'] ?? '',
      receiptDate: json['receipt_date'] ?? '',
      receiptConcept: json['receipt_concept'] ?? '',
      receiptNotes: json['receipt_notes'] ?? '',
      receiptBankAccountId: json['receipt_bank_account_id'] ?? 0,
      receiptBankName: json['receipt_bank_name'] ?? '',
      receiptBankAccountHolder: json['receipt_bank_account_holder'] ?? '',
      receiptState: json['receipt_state'] ?? '',
      receiptFile: json['receipt_file'] ?? '',
      receiptComment: json['receipt_comments'] ?? '',
      receiptDateApproving: json['receipt_approving_date'] ?? ''
    );
  }

  Map<String, dynamic> toJson() => {
        'receipt_amount': receiptAmount,
        'receipt_number': receiptNumber,
        'receipt_date': receiptDate,
        'receipt_concept': receiptConcept,
        'receipt_notes': receiptNotes,
        'receipt_bank_account_id': receiptBankAccountId,
        'receipt_bank_name': receiptBankName,
        'receipt_bank_account_holder': receiptBankAccountHolder,
        'receipt_state': receiptState,
        'receipt_file': receiptFile,
        'receipt_comments': receiptComment,
        'receipt_approving_date': receiptDateApproving
      };
}
