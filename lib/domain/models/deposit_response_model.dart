class DepositResponseModel {
  final String jsonrpc;
  final dynamic id;
  final ResultDepositResponse result;

  DepositResponseModel({
    required this.jsonrpc,
    this.id,
    required this.result,
  });

  factory DepositResponseModel.fromJson(Map<String, dynamic> json) => DepositResponseModel(
        jsonrpc: json['jsonrpc'] ?? '',
        id: json['id'] ?? 0,
        result: ResultDepositResponse.fromJson(json['result']),
      );
}

class ResultDepositResponse {
  final int estado;
  final String mensaje;
  final List<DataItem> data;

  ResultDepositResponse({
    required this.estado,
    required this.mensaje,
    required this.data,
  });

  factory ResultDepositResponse.fromJson(Map<String, dynamic> json) => ResultDepositResponse(
        estado: json['estado'] ?? 0,
        mensaje: json['mensaje'] ?? '',
        data: List<DataItem>.from(json['data'].map((x) => DataItem.fromJson(x))),
      );
}

class DataItem {
  final int id;
  final String? lastUpdate;
  final Map<String, dynamic> activityCalendarEventId;
  final List<dynamic> activityIds;
  final Map<String, dynamic> activityTypeId;
  final Map<String, dynamic> activityUserId;
  final double amount;
  final Map<String, dynamic> approvingUserId;
  final String bankAccountHolder;
  final BankAccountId bankAccountId;
  final String bankAccountNumber;
  final String bankName;
  final Company companyId;
  final String createDate;
  final User createUid;
  final Currency currencyId;
  final String customerNotes;
  final String date;
  final String displayName;
  final bool hasMessage;
  final int messageAttachmentCount;
  final List<MessageFollower> messageFollowerIds;
  final bool messageHasError;
  final int messageHasErrorCounter;
  final bool messageHasSmsError;
  final List<dynamic> messageIds;

  DataItem({
    required this.id,
    this.lastUpdate,
    required this.activityCalendarEventId,
    required this.activityIds,
    required this.activityTypeId,
    required this.activityUserId,
    required this.amount,
    required this.approvingUserId,
    required this.bankAccountHolder,
    required this.bankAccountId,
    required this.bankAccountNumber,
    required this.bankName,
    required this.companyId,
    required this.createDate,
    required this.createUid,
    required this.currencyId,
    required this.customerNotes,
    required this.date,
    required this.displayName,
    required this.hasMessage,
    required this.messageAttachmentCount,
    required this.messageFollowerIds,
    required this.messageHasError,
    required this.messageHasErrorCounter,
    required this.messageHasSmsError,
    required this.messageIds,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        id: json['id'] ?? 0,
        lastUpdate: json['__last_update'] ?? '',
        activityCalendarEventId: json['activity_calendar_event_id'] ?? {},
        activityIds: json['activity_ids'] ?? [],
        activityTypeId: json['activity_type_id'] ?? {},
        activityUserId: json['activity_user_id'] ?? {},
        amount: json['amount'] != null ? (json['amount'] as num).toDouble() : 0,
        approvingUserId: json['approving_user_id'] ?? {},
        bankAccountHolder: json['bank_account_holder'] ?? '',
        bankAccountId: json['bank_account_id'] != null ? 
          BankAccountId.fromJson(json['bank_account_id']) : BankAccountId(id: 0, name: ''),
        bankAccountNumber: json['bank_account_number'] ?? '',
        bankName: json['bank_name'] ?? '',
        companyId: json['company_id'] != null ? 
        Company.fromJson(json['company_id']) : Company(id: 0, name: ''),
        createDate: json['create_date'] ?? '',
        createUid: json['create_uid'] != null ? 
        User.fromJson(json['create_uid']) : User(id: 0, name: ''),
        currencyId: json['currency_id'] != null ? 
        Currency.fromJson(json['currency_id']) : Currency(id: 0, name: ''),
        customerNotes: json['customer_notes'] ?? '',
        date: json['date'] ?? '',
        displayName: json['display_name'] ?? '',
        hasMessage: json['has_message'] ?? false,
        messageAttachmentCount: json['message_attachment_count'] ?? 0,
        messageFollowerIds: json['message_follower_ids'] != null ? 
        List<MessageFollower>.from(json['message_follower_ids'].map((x) => MessageFollower.fromJson(x))) : [],
        messageHasError: json['message_has_error'] ?? false,
        messageHasErrorCounter: json['message_has_error_counter'] ?? 0,
        messageHasSmsError: json['message_has_sms_error'] ?? false,
        messageIds: json['message_ids'] ?? [],
      );
}

class BankAccountId {
  final int id;
  final dynamic name;

  BankAccountId({
    required this.id,
    this.name,
  });

  factory BankAccountId.fromJson(Map<String, dynamic> json) => BankAccountId(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}

class Company {
  final int id;
  final String name;

  Company({
    required this.id,
    required this.name,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}

class Currency {
  final int id;
  final String name;

  Currency({
    required this.id,
    required this.name,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}

class MessageFollower {
  final int id;
  final String name;

  MessageFollower({
    required this.id,
    required this.name,
  });

  factory MessageFollower.fromJson(Map<String, dynamic> json) => MessageFollower(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}
