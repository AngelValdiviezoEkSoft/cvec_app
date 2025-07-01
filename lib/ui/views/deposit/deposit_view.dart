
import 'package:animate_do/animate_do.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

String searchQueryDeposit = '';
List<ReceiptModelResponse> lstReceipts = [];
ReceiptModelResponse? objReciboDet;

class DepositView extends StatefulWidget {
  
  const DepositView(Key? key) : super (key: key);
  
  @override
  DepositViewSt createState() => DepositViewSt();
}

class DepositViewSt extends State<DepositView> {

  @override
  void initState() {    
    super.initState();

    searchQueryDeposit = '';

    lstReceipts = [];
    objReciboDet = ReceiptModelResponse(
      receiptAmount: 0,
      receiptBankAccountHolder: '',
      receiptBankAccountId: 0,
      receiptBankName: '',
      receiptConcept: '',
      receiptDate: '',
      receiptNumber: '',
      receiptState: '',
      receiptNotes: '',
      receiptFile: '',
      receiptComment: '',
      receiptDateApproving: ''
    );
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final gnrBloc = Provider.of<GenericBloc>(context);

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: DepositService().getDeposit(),
          builder: (context, snapshot) {

            gnrBloc.setCargando(true);

            if(!snapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Image.asset(
                    "assets/gifs/gif_carga.gif",
                    height: size.width * 0.85,
                    width: size.width * 0.85,
                  ),
                ),
              );
            }
            else
            {  

              if(snapshot.data != null && snapshot.data!.isNotEmpty) {

                lstReceipts = snapshot.data as List<ReceiptModelResponse>;

                List<ItemBoton> lstMenu = [];//state.deserializeItemBotonMenuList(objPerm);

                for(int i = 0; i < lstReceipts.length; i++){
                  String statusDeposit = lstReceipts[i].receiptState;
                  Color colorStatus = Colors.transparent;

                  String fechaStr = lstReceipts[i].receiptDate;

                  //String fechaStr = "2025-06-28 00:00:00";

                  // Parsear la fecha
                  DateTime fecha = DateTime.parse(fechaStr);

                  // Formatear al estilo "Sábado 28, Junio"
                  String fechaFormateada = DateFormat("EEEE d, MMMM", "es_ES").format(fecha);

                  // Capitalizar la primera letra
                  fechaFormateada = fechaFormateada[0].toUpperCase() + fechaFormateada.substring(1);


                  if(statusDeposit.toLowerCase() == 'draft'){
                    statusDeposit = locGen!.pendingReviewLbl;
                    colorStatus = Colors.grey;
                  }

                  if(statusDeposit.toLowerCase() == 'rejected'){
                    statusDeposit = locGen!.rejectedReviewLbl;
                    colorStatus = Colors.red;
                  }

                  if(statusDeposit.toLowerCase() == 'approved'){
                    statusDeposit = locGen!.approveReviewLbl;
                    colorStatus = Colors.green;
                  }

                  lstMenu.add(
                    ItemBoton(
                      '','\$${lstReceipts[i].receiptAmount}',statusDeposit,
                      i,Icons.person,lstReceipts[i].receiptConcept,fechaFormateada,'','',
                      Colors.white,colorStatus,false,false,'','','','','',
                      objRutas.rutaDetalleDepositFrmScrn,
                      (){
                        objReciboDet = lstReceipts[i];
                        context.push(objRutas.rutaDetalleDepositFrmScrn);                        
                      }
                    )
                  );
                }

                if(searchQueryDeposit.isNotEmpty){
                  filteredTransactions = lstMenu
                    .where((tx) => tx.mensajeNotificacion.toLowerCase().contains(searchQueryDeposit.toLowerCase()))
                    .toList();

                  if(filteredTransactions.isNotEmpty){
                    groupedTransactions = {};

                    for (var tx in filteredTransactions) {
                      groupedTransactions.putIfAbsent(tx.mensaje2, () => []).add(tx);
                    }
                  }
                }
                else{
                  if(groupedTransactions.isEmpty){
                    for (var tx in lstMenu) {
                      groupedTransactions.putIfAbsent(tx.mensaje2, () => []).add(tx);
                    }
                  }                  
                }

                List<Widget> itemMap = lstMenu.map(
                (item) => FadeInLeft(
                  duration: const Duration( milliseconds: 250 ),
                  child: 
                    ItemsDepositsWidget(
                      null,
                      colorTexto: item.color2,
                      varIdPosicionMostrar: 0,
                      varEsRelevante: item.esRelevante,
                      varIdNotificacion: item.ordenNot,
                      varNumIdenti: item.fechaNotificacion,                      
                      icon: item.icon,
                      texto: item.mensajeNotificacion,
                      texto2: item.mensaje2,
                      color1: item.color1,
                      color2: item.color1,
                      onPress: item.onPress,
                      varMuestraNotificacionesTrAp: 0,
                      varMuestraNotificacionesTrProc: 0,
                      varMuestraNotificacionesTrComp: 0,
                      varMuestraNotificacionesTrInfo: 0,
                      varIconoNot: item.idNotificacionGen,
                      varIconoNotTrans: item.rutaImagen,
                      permiteGestion: permiteGestion,
                      rutaNavegacion: item.rutaNavegacion,
                      amount: item.idSolicitud
                    ),
                  )
                ).toList();                

                gnrBloc.setCargando(false);
                
                return !state.cargando ?
                Container(
                  width: size.width,
                  height: size.height * 0.79,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //AQUI PONER TABS
/*
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: locGen!.searchLbl,
                                prefixIcon: const Icon(Icons.search),
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
*/
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF007AFF),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text('Todas',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                
                                /*
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Aprobadas', maxLines: 1,
    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                */
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text('Aprobadas',maxLines: 1,
    overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Color(0xFF007AFF))),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text('Rechazadas',maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Color(0xFF007AFF))),
                                  ),
                                ),
                                
                                const SizedBox(width: 8),

                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text('En Progreso',maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Color(0xFF007AFF))),
                                  ),
                                ),
                                
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),

                          Container(
                            width: size.width,
                            height: size.height * 0.2 * lstMenu.length,
                            color: Colors.transparent,
                            child: ListView(

                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                const SizedBox( height: 3, ),
                                ...itemMap,
                              ],
                            ),
                          ),
          
                        ],
                      ),
                    ),
                  ),
                )
                :                
                Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height * 0.78,
                  alignment: Alignment.center,
                  child: Image.asset(AppConfig().rutaGifLoading),
                );
              
              }
              
            }

            return Container(
              color: Colors.transparent,
              width: size.width,
              height: size.height * 0.78,
              alignment: Alignment.center,
              child: const Text("No hay datos"),
            );
          }
        );
      }
    );
  

  }
}
