
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

String numeroIdentificacionNotificaciones = '';
BuildContext? contextWidget;
int posicionNotificacioRelevante = 0;
Color colorRefreshList = Colors.transparent;
//CadenaConexion objCadConNotificaciones = CadenaConexion();
List<String> varLstIdsNots = [];
//UsuarioType? objUserSolicPrincipal;
bool permiteGestionItemsNot = false;
//final objFeaturesNotificacionesItem = FeatureApp();
bool muestraListaTramArob = false;
bool muestraListaTramProc = false;
bool muestraListaCompras = false;
bool muestraListaInformativo = false;

//NotificacionEnviroment objNotificacionEnviroment = NotificacionEnviroment();

//ignore: must_be_immutable
class ItemsListasWidget extends StatelessWidget {

  @required String? varIconoNot;
  @required String? varIconoNotTrans;
  @required int? varContadorNotificacion;
  @required int? varIdPosicionMostrar;
  @required final bool? varEsRelevante;
  final int? varIdNotificacion;
  @required String? varNumIdenti;
  final IconData icon;
  @required final String? texto;
  @required final String? texto2;
  @required final String? texto3;
  @required final String? texto4;
  final Color color1;
  final Color color2;
  @required final VoidCallback? onPress;

  @required final int? varMuestraNotificacionesTrAp;
  @required final int? varMuestraNotificacionesTrProc;
  @required final int? varMuestraNotificacionesTrComp;
  @required final int? varMuestraNotificacionesTrInfo;
  @required final bool? permiteGestion;
  @required final String? rutaNavegacion;

  ItemsListasWidget(
    Key? key,
    {      
      this.varIconoNot,
      this.varContadorNotificacion,
      this.varIdPosicionMostrar,
      this.varEsRelevante,
      this.varIdNotificacion,
      this.varNumIdenti,
      this.icon = Icons.circle,
      this.texto,
      this.texto2,
      this.texto3,
      this.texto4,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey,
      this.onPress,
      this.varMuestraNotificacionesTrAp,
      this.varMuestraNotificacionesTrProc,
      this.varMuestraNotificacionesTrComp,
      this.varMuestraNotificacionesTrInfo,
      //this.objUserSolicVac,
      this.varIconoNotTrans,
      this.permiteGestion,
      this.rutaNavegacion
    }
  ): super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //objUserSolicPrincipal = objUserSolicVac;
    permiteGestionItemsNot = permiteGestion!;

    return Center(
      child: ListaNotificaciones(
        null,
        varIdPosicionMostrarLst: varIdPosicionMostrar,
        varIdNotificacionLst: varIdNotificacion,
        varNumIdentifLst: varNumIdenti,
        color1: color1,
        color2: color2,
        icon: icon,
        onPress2: onPress,
        texto: texto,
        texto2: texto2,
        texto3: texto3,
        texto4: texto4,
        esRelevante: varEsRelevante,
        varContadorNotificacionLst: varContadorNotificacion,
        varMuestraNotificacionesTrApLst: varMuestraNotificacionesTrAp,
        varMuestraNotificacionesTrProcLst: varMuestraNotificacionesTrProc,
        varMuestraNotificacionesTrCompLst: varMuestraNotificacionesTrComp,
        varMuestraNotificacionesTrInfoLst: varMuestraNotificacionesTrInfo,
        varIconoNot: varIconoNot,
        //objUserSolicVacLst: objUserSolicVac,
        varIconoNotTransLstNot: varIconoNotTrans,
        rutaNavegacionFin: rutaNavegacion,
      ),
      );
  
  }
}

//ignore: must_be_immutable
class ListaNotificaciones extends StatelessWidget {

  @required String? varIconoNot;
  @required String? varIconoNotTransLstNot;
  @required int? varContadorNotificacionLst;
  @required int? varIdPosicionMostrarLst;
  @required final bool? esRelevante;
  final int? varIdNotificacionLst;
  @required String? varNumIdentifLst;
  final IconData icon;
  @required final String? texto;
  @required final String? texto2;
  @required final String? texto3;
  @required final String? texto4;
  Color color1;
  final Color color2;
  @required final VoidCallback? onPress2;

  @required final int? varMuestraNotificacionesTrApLst;
  @required final int? varMuestraNotificacionesTrProcLst;
  @required final int? varMuestraNotificacionesTrCompLst;
  @required final int? varMuestraNotificacionesTrInfoLst;
  //@required final UsuarioType? objUserSolicVacLst;
  @required final String? rutaNavegacionFin;


  ListaNotificaciones(
    Key? key,
    {
    this.varIconoNot,
    this.varContadorNotificacionLst,
    this.varIdPosicionMostrarLst,
    this.esRelevante,
    this.varIdNotificacionLst,
    this.varNumIdentifLst,
    this.icon = Icons.circle,
    this.texto,
    this.texto2,
    this.texto3,
    this.texto4,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    this.onPress2,
    this.varMuestraNotificacionesTrApLst,
    this.varMuestraNotificacionesTrProcLst,
    this.varMuestraNotificacionesTrCompLst,
    this.varMuestraNotificacionesTrInfoLst,
    this.varIconoNotTransLstNot,
    this.rutaNavegacionFin
  }) : super (key: key);
  
  @override
  Widget build(BuildContext context) {
    contextWidget = context;

    numeroIdentificacionNotificaciones = varNumIdentifLst!;
    
    final sizeLstNot = MediaQuery.of(context).size;
    initializeDateFormatting('es'); 
    
  return Container(
    color: Colors.transparent,
    width: sizeLstNot.width,
    //height: sizeLstNot.height * 0.2,
    child: GestureDetector(
          onTap: () async {
            if(onPress2 != null){
              //onPress2!();
            }
            else{
              const storage = FlutterSecureStorage();
              await storage.write(key: 'IdReservaciones', value: '');
              await storage.write(key: 'IdReservaciones', value: "$varIdNotificacionLst");              
            }            
          },
          child: Column(
            children: [
              Container(
                width: sizeLstNot.width,
                height: sizeLstNot.height * 0.16,
                //height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.13 : sizeLstNot.height * 0.3,
                margin: const EdgeInsets.all(3), 
                decoration: BoxDecoration(
                  //color: Colors.red,
                  boxShadow: <BoxShadow>[
                    BoxShadow( color: Colors.black.withOpacity(0.2), offset: const Offset(4,6), blurRadius: 10 ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: <Color>[
                      color1,
                      color2,
                    ]
                  )
                
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  dense: true,
                  minVerticalPadding: 15,
                  title:  Container( 
                    width: sizeLstNot.width * 0.98,//65,
                    height: sizeLstNot.height * 0.16,
                    //height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.11 : sizeLstNot.height * 0.3,
                    alignment: Alignment.center, 
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        Container(
                          width: sizeLstNot.width * 0.85,
                          height: sizeLstNot.height * 0.2,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent, 
                                width: sizeLstNot.width * 0.85, 
                                height: sizeLstNot.height * 0.03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      texto!, 
                                      style: const TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20 ), maxLines: 1,
                                    ),
                                    /*
                                    Text(
                                      varIconoNot!, 
                                      style: const TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16 ), maxLines: 1,
                                    ),
                                    */
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE3F0FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(varIconoNot!,style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                                    ),
                                  ],
                                )
                              ),

                              Container(
                                color: Colors.transparent, 
                                width: sizeLstNot.width * 0.85, 
                                height: sizeLstNot.height * 0.04,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.transparent, 
                                      width: sizeLstNot.width * 0.4, 
                                      height: sizeLstNot.height * 0.02,//varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.05,
                                      child: Text( texto3 ?? '', style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold ), maxLines: 5,)
                                    ),

                                    Container(
                                      color: Colors.transparent, 
                                      width: sizeLstNot.width * 0.4, 
                                      height: sizeLstNot.height * 0.02,//varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.05,
                                      child: Text( texto4 ?? '', style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold ), maxLines: 5,)
                                    ),
                                  ],
                                ),
                              ),

                              //if(texto2 != null && texto2!.isNotEmpty)
                              Container(
                                color: Colors.transparent, 
                                width: sizeLstNot.width * 0.85, 
                                height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.05,
                                child: Text( texto2!, style: const TextStyle( color: Colors.black,  fontSize: 14 ),maxLines: 1,
                                )
                              ),
                              
                              Container(
                                color: Colors.transparent, 
                                width: sizeLstNot.width * 0.85, 
                                height: sizeLstNot.height * 0.04,//varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.05,
                                child: Text( varNumIdentifLst ?? '', style: const TextStyle( color: Colors.black,   ), maxLines: 1, overflow: TextOverflow.ellipsis)
                              ),
                            ],
                          ),
                        ),
          
                      ],
                    ),                
                  ),
                ),
              ),
                  
            ],
          ),
        )
      
    
  ); 

  }
}

class ItemsListasWidgetBackground extends StatelessWidget {
  
    final IconData icon;
    final Color color1;
    final Color color2;
    final String varImgNot;

  const ItemsListasWidgetBackground( Key? key, this.icon, this.color1, this.color2, this.varImgNot ) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.92,//- 35,//double.infinity,
      height: size.height * 0.03,//75,
      margin: const EdgeInsets.all( 10 ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow( color: Colors.black.withOpacity(0.2), offset: const Offset(4,6), blurRadius: 10 ),
        ],
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: <Color>[
            color1,
            color2,
          ]
        )
      ), 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 15,
              top: -10,
              child: Image.asset(
                "assets/loadingEnrolApp.gif",
                width: 25,
                height: 25,
              ),
            )
          ],
        ),
      ),

      
    );
  
  }
}
