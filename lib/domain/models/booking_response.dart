class BookingResponse {
  String jsonrpc;
  dynamic id;
  BookingResult result;

  BookingResponse({
    required this.jsonrpc,
    this.id,
    required this.result,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'] ?? '',
      result: BookingResult.fromJson(json['result']),
    );
  }
}

class BookingResult {
  int estado;
  BookingData data;

  BookingResult({
    required this.estado,
    required this.data,
  });

  factory BookingResult.fromJson(Map<String, dynamic> json) {
    return BookingResult(
      estado: json['estado'] ?? 0,
      data: BookingData.fromJson(json['data']),
    );
  }
}

class BookingData {
  BookingInfo bookings;

  BookingData({
    required this.bookings,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      bookings: BookingInfo.fromJson(json['ek.travel.contract.bookings']),
    );
  }
}

class BookingInfo {
  int length;
  Map<String, String> fields;
  List<Booking> data;

  BookingInfo({
    required this.length,
    required this.fields,
    required this.data,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      length: json['length'] ?? 0,
      fields: Map<String, String>.from(json['fields']),
      data: List<Booking>.from(json['data'].map((x) => Booking.fromJson(x))),
    );
  }
}

class Booking {
  int id;
  String dateBookingsEnd;
  String dateBookingsStart;
  String name;
  String personInclude;
  String roomInclude;
  String state;
  String subscriptionName;
  String tradeNameHotel;

  Booking({
    required this.id,
    required this.dateBookingsEnd,
    required this.dateBookingsStart,
    required this.name,
    required this.personInclude,
    required this.roomInclude,
    required this.state,
    required this.subscriptionName,
    required this.tradeNameHotel,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? 0,
      dateBookingsEnd: json['date_bookings_end'] ?? '',
      dateBookingsStart: json['date_bookings_start'] ?? '',
      name: json['name'] ?? '',
      personInclude: json['person_include'] ?? '',
      roomInclude: json['room_include'] ?? '',
      state: json['state'] ?? '',
      subscriptionName: json['subscription_name'] ?? '',
      tradeNameHotel: json['trade_name_hotel'] ?? '',
    );
  }
}
