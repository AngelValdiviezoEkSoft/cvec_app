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
                  child: LiquidPullToRefresh(
                    onRefresh: refreshReceipts,
                    color: Colors.blue[300],
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: searchTxt,
                                decoration: InputDecoration(
                                  hintText: 'Buscar',
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
                        
                            //if(lstMenu.isNotEmpty)  
                            Container(
                              width: size.width,
                              height: lstMenu.isNotEmpty ? size.height * 0.2 * lstMenu.length : size.height * 0.75,
                              color: Colors.transparent,
                              child: ListView(                      
                                physics: const BouncingScrollPhysics(),
                                children: <Widget>[
                                  ...itemMap,
                                ],
                              ),
                            ),
                                  
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                
/*
                return Scaffold(
                  body: Container(
                    width: size.width,
                    height: size.height * 0.82,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchTxt,
                            decoration: InputDecoration(
                              hintText: 'Buscar',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                  
                                  setState(() {
                                    groupedTransactions = {};
                                    searchQuery = '';
                                    searchTxt.text = '';
                                  });
                  
                                },
                                icon: const Icon(Icons.cancel, color: Colors.black,)
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                          child: ListView(
                            children: groupedTransactions.entries.map((entry) {
                              
                              String descDia = '';
                              String descMes = '';
                              String descAnio = '';
                    
                              String fecTrx = '${entry.key.split('/')[2]}-${entry.key.split('/')[1]}-${entry.key.split('/')[0]}';
                    
                              DateTime date = DateTime.parse(fecTrx);
                    
                              if(date.day == DateTime.now().day){
                                descDia = 'Hoy';
                              }
                              else{
                                if(date.day == DateTime.now().day - 1){
                                  descDia = 'Ayer';
                                }
                                else{
                                  descDia = DateFormat('EEEE', 'es_ES').format(date);
                                  descDia = capitalizarPrimeraLetra(descDia);
                                }
                              }
                    
                              descMes = DateFormat('MMMM', 'es_ES').format(date);
                              descMes = capitalizarPrimeraLetra(descMes);
                              descAnio = '${date.year}';                  
                    
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [                                
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$descDia ${date.day}',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '$descMes $descAnio',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...entry.value.map((tx) => Card(
                                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: GestureDetector(
                                          onTap: () async {
                                            const storage = FlutterSecureStorage();
                    
                                            await storage.write(key: 'IdRecibo', value: '');
                                            await storage.write(key: 'IdRecibo', value: '${tx.ordenNot}');
                                            
                                            //ignore: use_build_context_synchronously
                                            context.push(tx.rutaNavegacion);
                                          },
                                          child: ListTile(
                                            title: Text(tx.mensajeNotificacion),
                                            //subtitle: Text(tx.mensaje2),
                                            trailing: Text(
                                              //'${tx.fechaNotificacion < 0 ? '-' : ''} \$${tx.fechaNotificacion.abs().toStringAsFixed(2)}',
                                              tx.fechaNotificacion,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      // Acción al presionar el botón
                      //print('Botón flotante presionado');
                      //para consultas por fechas
                    },
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.add),
                    
                  ),
                );
*/
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
            //ItemBoton('','','',rsp[i].paymentId, Icons.group_add, 'Recibo #${rsp[i].paymentName}', 'Fecha de pago ${rsp[i].paymentDate}', '\$${rsp[i].paymentAmount.toStringAsFixed(2)}','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
            ItemBoton('','','',rsp[i].paymentId, Icons.group_add, 'Recibo #${rsp[i].paymentName}', rsp[i].paymentDate, '\$${rsp[i].paymentAmount.toStringAsFixed(2)}','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
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