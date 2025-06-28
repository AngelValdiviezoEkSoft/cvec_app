
class DepositRequestModel {
    String receiptFile;
    double amount;
    String receiptNumber;
    DateTime date;    
    String name;
    String customerNotes;
    int idAccountBank;
    int idUser;
    double idPartner;

    DepositRequestModel({
        required this.receiptFile,
        required this.amount,
        required this.receiptNumber,
        required this.date,
        required this.name,
        required this.customerNotes,
        required this.idAccountBank,
        required this.idUser,
        required this.idPartner
    });
/*
    factory DepositRequestModel.fromRawJson(String str) => DepositRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DepositRequestModel.fromJson(Map<String, dynamic> json) => DepositRequestModel(
        receiptFile: json["receipt_file"],
        amount: json["amount"],
        receiptNumber: json["receipt_number"],
        tockenValidDate: DateTime.parse(json["tocken_valid_date"]),
        date: json["date"],
        name: json["name"],
        customerNotes: json["customer_notes"],
        tockenValidDate: DateTime.parse(json["tocken_valid_date"]),
        partnerId: json["partner_id"] ?? 0,
        idConsulta: 0,
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "tocken": tocken,
        "imei": imei,
        "uid": uid,
        "company": company,
        "bearer": bearer,
        "tocken_valid_date": tockenValidDate.toIso8601String(),
        "partner_id": partnerId,
        "idConsulta": idConsulta,
    };
    */
}
