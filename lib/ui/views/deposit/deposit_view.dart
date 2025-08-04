
import 'package:animate_do/animate_do.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

List<ItemBoton> lstMenu = [];
List<Widget> itemMap = [];
String searchQueryDeposit = '';
List<ReceiptModelResponse> lstReceipts = [];
ReceiptModelResponse? objReciboDet;
bool tabTodas = true;
bool tabProgreso = false;
bool tabAprobadas = false;
bool tabRechazadas = false;

class DepositView extends StatefulWidget {
  
  const DepositView(Key? key) : super (key: key);
  
  @override
  DepositViewSt createState() => DepositViewSt();
}

class DepositViewSt extends State<DepositView> {

  late Future<List<ReceiptModelResponse>> _futureDeposits;
  bool showButtonScrool = false;
  final ScrollController scrollListaClt = ScrollController();

  void scrollToTop() {
    scrollListaClt.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {    
    super.initState();

    _futureDeposits = getDeposits();

    searchQueryDeposit = '';
    lstMenu = [];

    tabTodas = true;
    tabProgreso = false;
    tabAprobadas = false;
    tabRechazadas = false;
    itemMap = [];
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
    scrollListaClt.addListener(() {
      if (scrollListaClt.offset > 200 && !showButtonScrool) {
        setState(() {
          showButtonScrool = true;
        });
      } else if (scrollListaClt.offset <= 200 && showButtonScrool) {
        setState(() {
          showButtonScrool = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final gnrBloc = Provider.of<GenericBloc>(context);

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: _futureDeposits,
          builder: (context, snapshot) {

            gnrBloc.setCargando(true);

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

                lstReceipts = snapshot.data as List<ReceiptModelResponse>;

                if(lstReceipts.isNotEmpty){

                  var lstAprobadas = lstReceipts.where((x) => x.receiptState.toLowerCase() == 'approved').toList();
                  var lstRechazadas = lstReceipts.where((x) => x.receiptState.toLowerCase() == 'rejected').toList();
                  var lstPendientes = lstReceipts.where((x) => x.receiptState.toLowerCase() == 'draft').toList();

                  for(int i = 0; i < lstReceipts.length; i++){
                    String statusDeposit = lstReceipts[i].receiptState;
                    Color colorStatus = Colors.transparent;

                    String fechaStr = lstReceipts[i].receiptDate;

                    DateTime fecha = DateTime.parse(fechaStr);

                    String fechaFormateada = DateFormat("EEEE d, MMMM", "es_ES").format(fecha);

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

                    if(tabTodas && lstMenu.length <= lstReceipts.length){
                      lstMenu.add(
                        ItemBoton(
                          '','\$${lstReceipts[i].receiptAmount}',statusDeposit,
                          i,Icons.person,lstReceipts[i].receiptConcept,fechaFormateada,'','','','',
                          Colors.white,colorStatus,false,false,'','','','','',
                          objRutas.rutaDetalleDepositFrmScrn,
                          (){
                            objReciboDet = lstReceipts[i];
                            context.push(objRutas.rutaDetalleDepositFrmScrn);                        
                          }
                        )
                      );
                    }

                    if(tabProgreso && statusDeposit.toLowerCase() == locGen!.pendingReviewLbl.toLowerCase() && lstMenu.length < lstPendientes.length){
                      lstMenu.add(
                        ItemBoton(
                          '','\$${lstReceipts[i].receiptAmount}',statusDeposit,
                          i,Icons.person,
                          lstReceipts[i].receiptConcept,fechaFormateada,'','','','',
                          Colors.white,colorStatus,false,false,'','','','','',
                          objRutas.rutaDetalleDepositFrmScrn,
                          (){
                            objReciboDet = lstReceipts[i];
                            context.push(objRutas.rutaDetalleDepositFrmScrn);                        
                          }
                        )
                      );
                    }

                    if(tabAprobadas && lstReceipts[i].receiptState.toLowerCase() == 'approved' && lstMenu.length < lstAprobadas.length){
                      lstMenu.add(
                        ItemBoton(
                          '','\$${lstReceipts[i].receiptAmount}',statusDeposit,
                          i,Icons.person,lstReceipts[i].receiptConcept,fechaFormateada,'','','','',
                          Colors.white,colorStatus,false,false,'','','','','',
                          objRutas.rutaDetalleDepositFrmScrn,
                          (){
                            objReciboDet = lstReceipts[i];
                            context.push(objRutas.rutaDetalleDepositFrmScrn);                        
                          }
                        )
                      );
                    }

                    if(tabRechazadas && lstReceipts[i].receiptState.toLowerCase() == 'rejected' && lstMenu.length < lstRechazadas.length){
                      lstMenu.add(
                        ItemBoton(
                          '','\$${lstReceipts[i].receiptAmount}',statusDeposit,
                          i,Icons.person,
                          lstReceipts[i].receiptConcept,fechaFormateada,'','','','',
                          Colors.white,colorStatus,false,false,'','','','','',
                          objRutas.rutaDetalleDepositFrmScrn,
                          (){
                            objReciboDet = lstReceipts[i];
                            context.push(objRutas.rutaDetalleDepositFrmScrn);                        
                          }
                        )
                      );
                    }
                    
                  }

                  itemMap = lstMenu.map(
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

                }

                gnrBloc.setCargando(false);
                
              }
              
              return !state.cargando ?
                Scaffold(
                  body: Container(
                    width: size.width,
                    height: size.height * 0.85,//0.79,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    lstMenu = [];
                                    tabTodas = true;
                                    tabProgreso = false;
                                    tabAprobadas = false;
                                    tabRechazadas = false;
                                  
                                    setState(() {
                                      
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: tabTodas ? const Color(0xFF007AFF) : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(locGen!.tabAlsDebsLbl,
                                      style: TextStyle(
                                          color: tabTodas ? Colors.white : const Color(0xFF007AFF),
                                          fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                                        )
                                      ),
                                  ),
                                ),
                              ),
                                  
                              const SizedBox(width: 8),
                              
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                
                                    lstMenu = [];
                
                                    tabTodas = false;
                                    tabProgreso = false;
                                    tabAprobadas = true;
                                    tabRechazadas = false;
                                  
                                    setState(() {
                                      
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: tabAprobadas ? const Color(0xFF007AFF) : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(locGen!.approveReviewLbl,maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: tabAprobadas ? Colors.white : const Color(0xFF007AFF),
                                        fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                                      )
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    lstMenu = [];
                
                                    tabTodas = false;
                                    tabProgreso = false;
                                    tabAprobadas = false;
                                    tabRechazadas = true;
                                  
                                    setState(() {
                                      
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: tabRechazadas ? const Color(0xFF007AFF) : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(locGen!.rejectedReviewLbl,maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: tabRechazadas ? Colors.white : const Color(0xFF007AFF),
                                          fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 8),
                                  
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    lstMenu = [];
                
                                    tabTodas = false;
                                    tabProgreso = true;
                                    tabAprobadas = false;
                                    tabRechazadas = false;
                                  
                                    setState(() {
                                      
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: tabProgreso ? const Color(0xFF007AFF) : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(locGen!.pendingReviewLbl,maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: tabProgreso ? Colors.white : const Color(0xFF007AFF),
                                        fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                                      )
                                    ),
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        
                        Container(
                          width: size.width,
                          height: size.height * 0.75,//0.79,
                          color: Colors.transparent,
                            child: Scaffold(
                              body: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: LiquidPullToRefresh(
                                  onRefresh: refreshDeposits,
                                  color: Colors.blue[300],
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                                  
                                        Container(
                                          width: size.width,
                                          height: size.height * 0.18 * lstMenu.length,
                                          color: Colors.transparent,
                                          child: 
                                          
                                          ListView(
                                            controller: scrollListaClt,
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
                              ),
                              floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
                              floatingActionButton: showButtonScrool
                              ? FloatingActionButton(
                                  onPressed: scrollToTop,
                                  backgroundColor: Colors.black45,
                                  child: const Icon(Icons.arrow_upward, color: Colors.white,),
                                )
                              : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(                
                    onPressed: () {
                      gnrBloc.setShowViewAccountStatementEvent(false);
                      gnrBloc.setShowViewDebts(false);
                      gnrBloc.setShowViewPrintRecipts(false);
                      gnrBloc.setShowViewReservetions(false);
                      gnrBloc.setShowViewSendDeposits(false);
                      gnrBloc.setShowViewWebSite(false);
                      gnrBloc.setShowViewFrmDeposit(true);
                    },
                    backgroundColor: const Color.fromRGBO(75, 57, 239, 1.0),
                    child: const Icon(Icons.add_card_sharp, color: Colors.white,),
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
        );
      }
    );
  }
  
  Future<void> refreshDeposits() async {
    lstReceipts = [];
    final data = await DepositService().getDeposit();
    setState(() {
      lstReceipts = data;
      _futureDeposits = Future.value(data); // Actualizamos el future
    });
    
    return Future.delayed(const Duration(seconds: 1));
  }
}


Future<List<ReceiptModelResponse>> getDeposits() async {
  lstReceipts = [];
  return await DepositService().getDeposit();
}
