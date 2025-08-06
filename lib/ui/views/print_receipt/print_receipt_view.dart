//import 'package:animate_do/animate_do.dart';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/models/models.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
//import 'package:cve_app/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

String searchQuery = '';

List<ItemBoton> filteredTransactions = [];

Map<String, List<ItemBoton>> groupedTransactions = {};
//TextEditingController passWordTxt = TextEditingController();
late TextEditingController searchTxt;

class PrintReceiptView extends StatefulWidget {
  
  const PrintReceiptView(Key? key) : super (key: key);
  
  @override
  PrintReceiptViewSt createState() => PrintReceiptViewSt();
}

class PrintReceiptViewSt extends State<PrintReceiptView> {

  @override
  void initState() {
    super.initState();

    searchQuery = '';
    filteredTransactions = [];
    groupedTransactions = {};
    searchTxt = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;    

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: getReceipts(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if(!snapshot.hasData) {
              return Scaffold(
                //backgroundColor: Colors.white,
                body: Center(
                  child: Image.asset(
                    AppConfig().rutaGifCarga,
                    height: size.width * 0.85,
                    width: size.width * 0.85,
                  ),
                ),
              );
            }
            else
            {  
              if(snapshot.data != null && snapshot.data!.isNotEmpty) {
                String rspTmp = snapshot.data as String;
                
                String objPerm = rspTmp;

                List<ItemBoton> lstMenu = state.deserializeItemBotonMenuList(objPerm);
                List<ItemBoton> lstMenuFiltrado = lstMenu;

                if(searchQuery.isNotEmpty){
                  lstMenuFiltrado = [];

                  lstMenuFiltrado = lstMenu
                    .where((tx) => tx.mensajeNotificacion.toLowerCase().contains(searchQuery.toLowerCase()))
                    .toList();

                  //objPayment = bookingList.firstWhere((x) => x.paymentId == idFinal);

                  //if(filteredTransactions.isNotEmpty){
                    groupedTransactions = {};

                    for (var tx in filteredTransactions) {
                      groupedTransactions.putIfAbsent(tx.mensaje2, () => []).add(tx);
                    }
                  //}
                  
                }
                else{
                  if(groupedTransactions.isEmpty){
                    for (var tx in lstMenu) {
                      groupedTransactions.putIfAbsent(tx.mensaje2, () => []).add(tx);
                    }
                  }                  
                }

                List<Widget> itemMap = lstMenuFiltrado.map(
                (item) => FadeInLeft(
                  duration: const Duration( milliseconds: 250 ),
                  child: 
                    ItemsListaRecibosWidget(
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
                      onPress: () {  },
                      varMuestraNotificacionesTrAp: 0,
                      varMuestraNotificacionesTrProc: 0,
                      varMuestraNotificacionesTrComp: 0,
                      varMuestraNotificacionesTrInfo: 0,
                      varIconoNot: item.iconoNotificacion,
                      varIconoNotTrans: item.rutaImagen,
                      permiteGestion: permiteGestion,
                      rutaNavegacion: item.rutaNavegacion,
                    ),
                  )
                ).toList();                

                
                return Container(
                  width: size.width,
                  height: size.height * 0.82,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height * 0.06,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Text(locGen!.receiptsLbl, style: TextStyle(fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize20)),)
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchTxt,
                            decoration: InputDecoration(
                              hintText: locGen!.searchLbl,
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {                                      
                                    searchQuery = '';
                                    searchTxt.text = searchQuery;
                                  });
                                },
                                icon: const Icon(Icons.close, color: Colors.black,),
                              )
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                    
                              setState(() {
                                searchQuery = searchTxt.text;
                              });
                            },
                          ),
                        ),
                    
                        Expanded(
                          child: LiquidPullToRefresh(
                            onRefresh: refreshReceipts,
                            color: Colors.blue[300],
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                const SizedBox( height: 3, ),
                                ...itemMap,
                                const SizedBox( height: 3, ),
                              ],
                            ),
                          ),
                        ),
                              
                      ],
                    ),
                  ),
                );
              
              }
              
            }

            return Container();
          }
        );
      }
    );
  
  }
}

String capitalizarPrimeraLetra(String texto) {
  if (texto.isEmpty) return texto;
  return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
}

Future<String> getReceipts() async {

    try{
      List<Payment>? rsp = await ReceiptsService().getReceipts();

      final items = <ItemBoton>[];

      if(rsp != null && rsp.isNotEmpty){
        for(int i = 0; i < rsp.length; i++){
          items.add(            
            ItemBoton('','','',rsp[i].paymentId, Icons.group_add, '${locGen!.receiptLbl}# ${rsp[i].paymentName}', '${locGen!.paymentDateLbl}: ${rsp[i].paymentDate}', '', '', '\$${rsp[i].paymentAmount.toStringAsFixed(2)}','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
              RoutersApp().routPrintReceiptView,
              () {
                
              }
            ),
          );
        }
      }

      final jsonString = serializeItemBotonMenuList(items);

      return jsonString;
    }
    catch(ex){
      return '';
    }
  }

String serializeItemBotonMenuList(List<ItemBoton> items) {    
  final serializedList = items.map((item) => serializeItemBotonMenu(item)).toList();

  return jsonEncode(serializedList);
}

Map<String, dynamic> serializeItemBotonMenu(ItemBoton item) {
  return {
    'tipoNotificacion': item.tipoNotificacion,
    'idSolicitud': item.idSolicitud,
    'idNotificacionGen': item.idNotificacionGen,
    'ordenNot': item.ordenNot,
    'icon': item.icon.codePoint,
    'mensajeNotificacion': item.mensajeNotificacion,
    'mensaje2': item.mensaje2,
    'fechaNotificacion': item.fechaNotificacion,
    'tiempoDesde': item.tiempoDesde,
    'color1': item.color1.value,
    'color2': item.color2.value,
    'requiereAccion': item.requiereAccion,
    'esRelevante': item.esRelevante,
    'estadoLeido': item.estadoLeido,
    'numIdenti': item.numIdenti,
    'iconoNotificacion': item.iconoNotificacion,
    'rutaImagen': item.rutaImagen,
    'idTransaccion': item.idTransaccion,
    'rutaNavegacion': item.rutaNavegacion,
  };
}

Future<void> refreshReceipts() async {
  lstReceipts = [];
  await getReceipts();
  return Future.delayed(const Duration(seconds: 1));
}