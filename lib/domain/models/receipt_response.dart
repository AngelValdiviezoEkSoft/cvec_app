/*
class ReceiptResponse {
  String jsonrpc;
  dynamic id;
  ReceiptModel result;

  ReceiptResponse({required this.jsonrpc, this.id, required this.result});

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptResponse(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'] ?? '',
      result: ReceiptModel.fromJson(json['result']),
    );
  }
}

class ReceiptModel {
  int estado;
  PaymentData data;

  ReceiptModel({required this.estado, required this.data});

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      estado: json['estado'] ?? 0,
      data: PaymentData.fromJson(json['data']['account.payment']),
    );
  }
}

class PaymentData {
  int length;
  Map<String, String> fields;
  List<Payment> data;

  PaymentData({required this.length, required this.fields, required this.data});

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      length: json['length'] ?? 0,
      fields: Map<String, String>.from(json['fields']),
      data: List<Payment>.from(json['data'].map((x) => Payment.fromJson(x))),
    );
  }
}

class Payment {
  int id;
  Company companyId;
  User createUid;
  String date;
  Journal journalId;
  String nameReceipt;
  Partner partnerId;
  String ref;
  String amount;

  Payment({
    required this.id,
    required this.companyId,
    required this.createUid,
    required this.date,
    required this.journalId,
    required this.nameReceipt,
    required this.partnerId,
    required this.ref,
    required this.amount
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? 0,
      companyId: Company.fromJson(json['company_id']),
      createUid: User.fromJson(json['create_uid']),
      date: json['date'] ?? '',
      journalId: Journal.fromJson(json['journal_id']),
      nameReceipt: json['name_receipt'] ?? '',
      partnerId: Partner.fromJson(json['partner_id']),
      ref: json['ref'] ?? '',
      amount: json['amount'] != null ? json['amount'].toStringAsFixed(2) : '0',
    );
  }
}

class Company {
  int id;
  String name;
  String street;
  String street2;

  Company({required this.id, required this.name, required this.street, required this.street2});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      street: json['street'] ?? '',
      street2: json['street2'] ?? '',
    );
  }
}

class User {
  int id;
  String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class Journal {
  int id;
  String name;

  Journal({required this.id, required this.name});

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class Partner {
  int id;
  String name;

  Partner({required this.id, required this.name});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
*/

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
      accountPayment: json['account.payment'] != null ? AccountPayment.fromJson(json['account.payment'])
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
  final String paymentRef;
  final String companyName;
  final String companyPhone;
  final String companyStreet;
  final String companyStreet2;
  final String companyWebsite;
  final String journalName;
  final String customerName;
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
