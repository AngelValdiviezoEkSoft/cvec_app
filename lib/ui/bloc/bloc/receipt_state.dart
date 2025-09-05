
part of 'receipt_bloc.dart';


abstract class ReceiptState {}

class ReceiptInitial extends ReceiptState {}

class ReceiptsLoading extends ReceiptState {}

class ReceiptsLoaded extends ReceiptState {
  final List<ItemBoton> receipts;

  ReceiptsLoaded({required this.receipts});
}

class ReceiptsError extends ReceiptState {
  final String message;

  ReceiptsError({required this.message});
}