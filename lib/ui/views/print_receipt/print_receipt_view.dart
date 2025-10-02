
import 'package:animate_do/animate_do.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PrintReceiptView extends StatefulWidget {
  const PrintReceiptView(Key? key) : super(key: key);

  @override
  State<PrintReceiptView> createState() => _PrintReceiptViewState();
}

class _PrintReceiptViewState extends State<PrintReceiptView> {
  late TextEditingController _searchTxt;
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  @override
  void initState() {
    super.initState();
    _searchTxt = TextEditingController();
    context.read<ReceiptBloc>().add(LoadReceipts());
  }

  @override
  void dispose() {
    _searchTxt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, stateGeneric) {
        return BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state is ReceiptsLoading) {
              return Scaffold(
                body: Center(
                  child: Image.asset(
                    AppConfig().rutaGifCarga,
                    height: size.width * 0.85,
                    width: size.width * 0.85,
                  ),
                ),
              );
            }
        
            if (state is ReceiptsError) {
              return Scaffold(
                body: Center(
                  child: Text(state.message),
                ),
              );
            }
        
            if (state is ReceiptsLoaded) {
              return LoadingOverlay(
                null,
                isLoading: stateGeneric.cargando,
                child: Container(
                  width: size.width,
                  height: size.height * 0.92,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          locGen!.receiptsLbl,
                          style: TextStyle(fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize20)),
                        ),
                        SizedBox(height: size.height * 0.02),
                        _buildSearchBar(context, size),
                        _buildDateRangeDisplay(),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          color: Colors.transparent,
                          width: size.width,
                          height: state.receipts.length > 8 ? size.height * 0.72 : size.height * 0.5,
                          child: LiquidPullToRefresh(
                            onRefresh: _onRefresh,
                            color: Colors.blue[300],
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.receipts.length,
                              itemBuilder: (context, index) {
                                final item = state.receipts[index];
        
                                return FadeInLeft(
                                  duration: const Duration(milliseconds: 250),
                                  child: ItemsListaRecibosWidget(
                                    null,
                                    varIdPosicionMostrar: 0,
                                    varEsRelevante: item.esRelevante,
                                    varIdNotificacion: item.ordenNot,
                                    varNumIdenti: item.fechaNotificacion,
                                    icon: item.icon,
                                    texto: item.mensajeNotificacion,
                                    texto2: item.mensaje2,
                                    color1: item.color1,
                                    color2: item.color2,
                                    onPress: () {},
                                    varMuestraNotificacionesTrAp: 0,
                                    varMuestraNotificacionesTrProc: 0,
                                    varMuestraNotificacionesTrComp: 0,
                                    varMuestraNotificacionesTrInfo: 0,
                                    varIconoNot: item.iconoNotificacion,
                                    varIconoNotTrans: item.rutaImagen,
                                    permiteGestion: permiteGestion,
                                    rutaNavegacion: item.rutaNavegacion,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        
            return Container();
          },
        );
      }
    );
  }

  Widget _buildSearchBar(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.75,
          child: TextField(
            controller: _searchTxt,
            decoration: InputDecoration(
              hintText: locGen!.searchLbl,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchTxt.clear();
                  _applyFilters();
                },
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ),
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              _applyFilters();
            },
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
          ),
        ),
        SizedBox(
          width: size.width * 0.15,
          height: size.height * 0.06,
          child: GestureDetector(
            onTap: () => _showDateRangePicker(context),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.calendar_month, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangeDisplay() {
    if (_fechaInicio != null && _fechaFin != null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${DateFormat("dd/MM/yyyy").format(_fechaInicio!)} - ${DateFormat("dd/MM/yyyy").format(_fechaFin!)}'),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _fechaInicio = null;
                  _fechaFin = null;
                });
                _applyFilters();
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar rango de fechas'),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.maxFinite,
          child: SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {
                _fechaInicio = args.value.startDate;
                _fechaFin = args.value.endDate;
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _fechaInicio = null;
                _fechaFin = null;
              });
              _applyFilters();
            },
            child: const Text('Limpiar', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _applyFilters();
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    context.read<ReceiptBloc>().add(
          FilterReceipts(
            searchQuery: _searchTxt.text,
            startDate: _fechaInicio,
            endDate: _fechaFin,
          ),
        );
  }

  Future<void> _onRefresh() async {
    _searchTxt.clear();
    setState(() {
      _fechaInicio = null;
      _fechaFin = null;
    });
    context.read<ReceiptBloc>().add(LoadReceipts());
  }
}

