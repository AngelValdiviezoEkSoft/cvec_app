
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
          future: DepositService().getDeposit(),
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

                    if(tabProgreso && statusDeposit.toLowerCase() == locGen!.pendingReviewLbl.toLowerCase() && lstMenu.length < lstPendientes.length){
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

                    if(tabAprobadas && lstReceipts[i].receiptState.toLowerCase() == 'approved' && lstMenu.length < lstAprobadas.length){
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

                    if(tabRechazadas && lstReceipts[i].receiptState.toLowerCase() == 'rejected' && lstMenu.length < lstRechazadas.length){
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
                                          //physics: const BouncingScrollPhysics(),
                                          children: <Widget>[
                                            const SizedBox( height: 3, ),
                                            ...itemMap,
                                          ],
                                        ),
                                        
/*
                                        ListView.builder(
                                          controller: scrollListaClt,
                                          itemCount: lstMenu.length,
                                          itemBuilder: ( _, int index ) {

                                            Color colorEstado = Colors.transparent;

                                            if(lstMenu[index].idNotificacionGen == locGen!.pendingReviewLbl){
                                              //statusDeposit = locGen!.pendingReviewLbl;
                                              colorEstado = Colors.grey;
                                            }

                                            if(lstMenu[index].idNotificacionGen == locGen!.rejectedReviewLbl){
                                              //statusDeposit = locGen!.rejectedReviewLbl;
                                              colorEstado = Colors.red;
                                            }

                                            if(lstMenu[index].idNotificacionGen == locGen!.approveReviewLbl){
                                              //statusDeposit = locGen!.approveReviewLbl;
                                              colorEstado = Colors.green;
                                            }
                                        
                                            return ListTile(
                                                title: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: const Color.fromARGB(255, 217, 217, 217)),
                                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                                  ),
                                                width: size.width * 0.98,
                                                height: size.height * 0.195,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    //AQUIII
                                                    /*
                                                    Container(
                                                      color: Colors.transparent,
                                                      width: size.width * 0.7,
                                                      height: size.height * 0.25,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          SizedBox(width: size.width * 0.01,),
                                                          Container(
                                                            color: Colors.transparent,
                                                            width: size.width * 0.14,
                                                            height: size.height * 0.1,
                                                            child: CircleAvatar(
                                                              radius: 30.0,
                                                              backgroundColor: Colors.grey[200],
                                                              child: const Icon(Icons.person, color: Colors.grey, size: 40.0),
                                                            ),
                                                          ),
                                                          SizedBox(width: size.width * 0.02,),
                                                          Container(
                                                            color: Colors.transparent,
                                                            width: size.width * 0.52,
                                                            height: size.height * 0.25,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                color: Colors.transparent,
                                                                width: size.width * 0.54,
                                                                height: size.height * 0.04,
                                                                child: Text(
                                                                  lstMenu[index].mensajeNotificacion,
                                                                  style: const TextStyle(
                                                                    fontWeight: FontWeight.bold,                                                                
                                                                    color: Colors.black
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  textAlign: TextAlign.left,
                                                                ),
                                                              ),
                                                              ],
                                                            ),
                                                          ),
                                                          
                                                          
                                                        ],
                                                      )
                                                    ),
                                                    SizedBox(width: size.width * 0.01,)
                                                    */
                                                
                                                    GestureDetector(
                                                      onTap: () async {
                                                        const storage = FlutterSecureStorage();
                                                    
                                                        await storage.write(key: 'IdReservaciones', value: '');
                                                        //await storage.write(key: 'IdReservaciones', value: "$varIdNotificacionLst");
                                                        
                                                        //ignore: use_build_context_synchronously
                                                        //context.push(rutaNavegacionFin!);           
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: size.width * 0.82,
                                                            height: size.height * 0.17,
                                                            margin: const EdgeInsets.all(3), 
                                                            child: ListTile(
                                                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                                              dense: true,
                                                              minVerticalPadding: 10,
                                                              title:  Container( 
                                                                width: size.width * 0.95,//65,
                                                                height: size.height * 0.45,
                                                                //height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? size.height * 0.11 : size.height * 0.3,
                                                                alignment: Alignment.center, 
                                                                color: Colors.white,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                      
                                                                    Container(
                                                                      width: size.width * 0.72,
                                                                      height: size.height * 0.45,
                                                                      color: Colors.transparent,
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Column(
                                                                        children: [
                                                                          Container(
                                                                            color: Colors.transparent, 
                                                                            width: size.width * 0.7, 
                                                                            height: size.height * 0.035,
                                                                            child: Text( 
                                                                                lstMenu[index].mensajeNotificacion, 
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle( 
                                                                                    color: Colors.black, 
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17)
                                                                                  ),
                                                                                  maxLines: 1,
                                                                                ),
                                                                          ),
                                                                          
                                                                          Container(
                                                                            color: Colors.transparent, 
                                                                            width: size.width * 0.7, 
                                                                            height: size.height * 0.035,
                                                                            child: Text(
                                                                                lstMenu[index].idSolicitud,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle( 
                                                                                  color: Colors.grey, 
                                                                                  fontWeight: FontWeight.bold, 
                                                                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17) 
                                                                                ), 
                                                                                //presetFontSizes: const [18, 16,14,12], 
                                                                                maxLines: 1,
                                                                              ),
                                                                          ),
                                                    
                                                                          Container(
                                                                              color: Colors.transparent, 
                                                                              width: size.width * 0.7, 
                                                                              height: size.height * 0.035,
                                                                              child: Text(
                                                                                lstMenu[index].idNotificacionGen,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle( 
                                                                                  color: colorEstado, 
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17)
                                                                              ), 
                                                                              //presetFontSizes: const [16,14,12], 
                                                                              maxLines: 1,
                                                                            )
                                                                          ),
                                                                          
                                                                          Container(
                                                                            color: Colors.transparent, 
                                                                            width: size.width * 0.7, 
                                                                            height: size.height * 0.035,
                                                                            child: Text(
                                                                              lstMenu[index].mensaje2, 
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle( 
                                                                                color: Colors.black,
                                                                                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17)
                                                                              ), 
                                                                              maxLines: 1,
                                                                            )
                                                                          ),
                                                                        
                                                                        ],
                                                                      ),
                                                                    ),
                                                      
                                                                    
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        //context.push(rutaNavegacionFin!);
                                                                      },
                                                                      child: Stack(
                                                                        alignment: Alignment.center,
                                                                        children: [
                                                                          // El círculo de fondo
                                                                          Container(
                                                                            width: size.width * 0.1,  // Tamaño del círculo (ajusta según sea necesario)
                                                                            height: size.height * 0.08,
                                                                            decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: Color.fromARGB(255, 224, 232, 235),  // Color de fondo
                                                                            ),
                                                                          ),
                                                                          // El icono central (usamos un icono de grupo de personas)
                                                                          Icon(
                                                                            Icons.arrow_forward_ios_rounded, // Icono similar al de personas
                                                                            size: 18,  // Tamaño del icono
                                                                            color: Colors.blue[900],  // Color del icono
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      
                                                                    ),
                                                      /*
                                                                    if(texto2 == null || texto2!.isEmpty)
                                                                    GestureDetector(
                                                                      onTap: () {    
                                                                        context.push(rutaNavegacionFin!);
                                                                      },
                                                                      child: Container(
                                                                        
                                                                        width: size.width * 0.14,//44,
                                                                        height: size.height * 0.13,//44, 
                                                                        color: Colors.transparent,
                                                                        child: Center(
                                                                          child: GestureDetector(
                                                                            onTap: () {                                  
                                                                              context.push(rutaNavegacionFin!);
                                                                            },
                                                                            child: Icon(icon, color: Colors.black,))
                                                                        )
                                                                      ),
                                                                    ),
                                                                    */
                                                                  ],
                                                                ),                
                                                              ),
                                                            ),
                                                          ),
                                                              
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                      */
                                      ),
                                      
                                    ],
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
}
