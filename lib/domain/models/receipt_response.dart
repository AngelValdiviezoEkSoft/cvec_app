
class ReceiptResponse {
  final String jsonrpc;
  final dynamic id;
  final ReceiptModel result;

  ReceiptResponse({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptResponse(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'] ?? 0,
      result: ReceiptModel.fromJson(json['result']),
    );
  }
}

class ReceiptModel {
  final int estado;
  final PaymentData data;

  ReceiptModel({
    required this.estado,
    required this.data,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      estado: json['estado'] ?? 0,
      data: PaymentData.fromJson(json['data']),
    );
  }
}

class PaymentData {
  final AccountPayment accountPayment;

  PaymentData({
    required this.accountPayment,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      accountPayment: json['customer_payment_receipts'] != null ? AccountPayment.fromJson(json['customer_payment_receipts'])
      : AccountPayment(data: [], fields: '', length: 0),
    );
  }
}

class AccountPayment {
  final int length;
  final String fields;
  final List<Payment> data;

  AccountPayment({
    required this.length,
    required this.fields,
    required this.data,
  });

  factory AccountPayment.fromJson(Map<String, dynamic> json) {
    return AccountPayment(
      length: json['length'] ?? 0,
      fields: json['fields'] ?? '',
      data: json['data'] != null ? List<Payment>.from(json['data'].map((x) => Payment.fromJson(x))) : [],
    );
  }
}

class Payment {
  final int paymentId;
  final String paymentName;
  final String paymentDate;
  String paymentRef;
  final String companyName;
  String companyPhone;
  String companyStreet;
  String companyStreet2;
  String companyWebsite;
  final String journalName;
  String customerName;
  final String userName;
  final String countryName;
  final double paymentAmount;

  Payment({
    required this.paymentId,
    required this.paymentName,
    required this.paymentDate,
    required this.paymentRef,
    required this.companyName,
    required this.companyPhone,
    required this.companyStreet,
    required this.companyStreet2,
    required this.companyWebsite,
    required this.journalName,
    required this.customerName,
    required this.userName,
    required this.countryName,
    required this.paymentAmount
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['payment_id'] ?? 0,
      paymentName: json['payment_name'] ?? '',
      paymentDate: json['payment_date'] ?? '',
      paymentRef: json['payment_ref'] ?? '',
      companyName: json['company_name'] ?? '',
      companyPhone: json['company_phone'] ?? '',
      companyStreet: json['company_street'] ?? '',
      companyStreet2: json['company_street2'] ?? '',
      companyWebsite: json['company_website'] ?? '',
      journalName: json['journal_name'] ?? '',
      customerName: json['customer_name'] ?? '',
      userName: json['user_name'] ?? '',
      countryName: json['country_name'] ?? '',
      paymentAmount: json['payment_amount'] ?? 0
    );
  }
}
