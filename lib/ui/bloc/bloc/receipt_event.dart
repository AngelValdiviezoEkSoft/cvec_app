
part of 'receipt_bloc.dart';

abstract class ReceiptEvent {}

class LoadReceipts extends ReceiptEvent {}

class FilterReceipts extends ReceiptEvent {
  final String? searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  FilterReceipts({this.searchQuery, this.startDate, this.endDate});
}