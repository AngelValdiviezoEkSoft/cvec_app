/*
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
      bookings: BookingInfo.fromJson(json['customer_bookings']),
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
*/

class BookingResponse {
  final String jsonrpc;
  final dynamic id;
  final BookingResult result;

  BookingResponse({
    required this.jsonrpc,
    this.id,
    required this.result,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      jsonrpc: json['jsonrpc'],
      id: json['id'],
      result: BookingResult.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "jsonrpc": jsonrpc,
      "id": id,
      "result": result.toJson(),
    };
  }
}

class BookingResult {
  final int estado;
  final BookingData data;

  BookingResult({
    required this.estado,
    required this.data,
  });

  factory BookingResult.fromJson(Map<String, dynamic> json) {
    return BookingResult(
      estado: json['estado'],
      data: BookingData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "estado": estado,
      "data": data.toJson(),
    };
  }
}

class BookingData {
  final BookingInfo customerBookings;

  BookingData({required this.customerBookings});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      customerBookings: BookingInfo.fromJson(json['customer_bookings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customer_bookings": customerBookings.toJson(),
    };
  }
}

class BookingInfo {
  final int length;
  final List<Booking> data;

  BookingInfo({
    required this.length,
    required this.data,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      length: json['length'],
      data: (json['data'] as List)
          .map((e) => Booking.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "length": length,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class Booking {
  final int bookingId;
  final String contractName;
  final String bookingName;
  final String bookingDate;
  final String bookingHotelName;
  final String bookingContent;
  final String bookingDateCheckIn;
  final String bookingEndCheckIn;
  final String bookingState;

  Booking({
    required this.bookingId,
    required this.contractName,
    required this.bookingName,
    required this.bookingDate,
    required this.bookingHotelName,
    required this.bookingContent,
    required this.bookingDateCheckIn,
    required this.bookingEndCheckIn,
    required this.bookingState,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'] ?? 0,
      contractName: json['contract_name'] ?? '',
      bookingName: json['booking_name'] ?? '',
      bookingDate: json['booking_date'] ?? '',
      bookingHotelName: json['booking_hotel_name'] ?? '',
      bookingContent: json['booking_content'] ?? '',
      bookingDateCheckIn: json['booking_date_check_in'] ?? '',
      bookingEndCheckIn: json['booking_end_check_in'] ?? '',
      bookingState: json['booking_state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "booking_id": bookingId,
      "contract_name": contractName,
      "booking_name": bookingName,
      "booking_date": bookingDate,
      "booking_hotel_name": bookingHotelName,
      "booking_content": bookingContent,
      "booking_date_check_in": bookingDateCheckIn,
      "booking_end_check_in": bookingEndCheckIn,
      "booking_state": bookingState,
    };
  }
}
