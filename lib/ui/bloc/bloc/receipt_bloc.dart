import 'package:bloc/bloc.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/models/models.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final ReceiptsService _receiptsService;

  ReceiptBloc(this._receiptsService) : super(ReceiptInitial()) {
    on<LoadReceipts>(_onLoadReceipts);
    on<FilterReceipts>(_onFilterReceipts);
  }

  List<ItemBoton> _allReceipts = [];

  Future<void> _onLoadReceipts(
      LoadReceipts event, Emitter<ReceiptState> emit) async {
    emit(ReceiptsLoading());
    try {
      final List<Payment>? rsp = await _receiptsService.getReceipts();
      if (rsp != null && rsp.isNotEmpty) {
        _allReceipts = _convertPaymentsToItemBoton(rsp);
        emit(ReceiptsLoaded(receipts: _allReceipts));
      } else {
        emit(ReceiptsLoaded(receipts: const []));
      }
    } catch (ex) {
      emit(ReceiptsError(message: 'Error al cargar los recibos'));
    }
  }

  void _onFilterReceipts(
      FilterReceipts event, Emitter<ReceiptState> emit) {
    List<ItemBoton> filteredList = _allReceipts;

    if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
      filteredList = filteredList
          .where((tx) => tx.mensajeNotificacion
              .toLowerCase()
              .contains(event.searchQuery!.toLowerCase()))
          .toList();
    }

    if (event.startDate != null && event.endDate != null) {
      filteredList = getFilteredReceiptsByDateRange(
          receipts: filteredList,
          startDate: event.startDate!,
          endDate: event.endDate!);
    }

    emit(ReceiptsLoaded(receipts: filteredList));
  }

  List<ItemBoton> _convertPaymentsToItemBoton(List<Payment> payments) {
    final items = <ItemBoton>[];
    for (var payment in payments) {
      items.add(
        ItemBoton(
          '',
          '',
          '',
          payment.paymentId,
          Icons.group_add,
          '${locGen!.receiptLbl}# ${payment.paymentName}',
          '${locGen!.paymentDateLbl}: ${payment.paymentDate}',
          '',
          '',
          '\$${payment.paymentAmount.toStringAsFixed(2)}',
          '',
          Colors.white,
          Colors.white,
          false,
          false,
          '',
          '',
          'icCompras.png',
          'icComprasTrans.png',
          '',
          RoutersApp().routPrintReceiptView,
          () {},
        ),
      );
    }
    return items;
  }
  
  List<ItemBoton> getFilteredReceiptsByDateRange({
    required List<ItemBoton> receipts,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return receipts.where((item) {
      DateTime? paymentDate;
      try {
        paymentDate = DateFormat("dd/MM/yyyy").parse(item.mensaje2.split(': ').last);
      } catch (e) {
        return false;
      }
      return paymentDate != null &&
          paymentDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          paymentDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }
}