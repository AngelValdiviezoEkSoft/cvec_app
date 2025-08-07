
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

BuildContext? contextWidgetRecibo;

//ignore: must_be_immutable
class ItemsListaRecibosWidget extends StatelessWidget {

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
  final Color color1;
  final Color color2;
  @required final VoidCallback? onPress;

  @required final int? varMuestraNotificacionesTrAp;
  @required final int? varMuestraNotificacionesTrProc;
  @required final int? varMuestraNotificacionesTrComp;
  @required final int? varMuestraNotificacionesTrInfo;
  @required final bool? permiteGestion;
  @required final String? rutaNavegacion;

  ItemsListaRecibosWidget(
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
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey,
      this.onPress,
      this.varMuestraNotificacionesTrAp,
      this.varMuestraNotificacionesTrProc,
      this.varMuestraNotificacionesTrComp,
      this.varMuestraNotificacionesTrInfo,      
      this.varIconoNotTrans,
      this.permiteGestion,
      this.rutaNavegacion
    }
  ): super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListaRecibos(
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
        esRelevante: varEsRelevante,
        varContadorNotificacionLst: varContadorNotificacion,
        varMuestraNotificacionesTrApLst: varMuestraNotificacionesTrAp,
        varMuestraNotificacionesTrProcLst: varMuestraNotificacionesTrProc,
        varMuestraNotificacionesTrCompLst: varMuestraNotificacionesTrComp,
        varMuestraNotificacionesTrInfoLst: varMuestraNotificacionesTrInfo,
        varIconoNot: varIconoNot,        
        varIconoNotTransLstNot: varIconoNotTrans,
        rutaNavegacionFin: rutaNavegacion,
      ),
      );
  
  }
}

//ignore: must_be_immutable
class ListaRecibos extends StatelessWidget {

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
  Color color1;
  final Color color2;
  @required final VoidCallback? onPress2;

  @required final int? varMuestraNotificacionesTrApLst;
  @required final int? varMuestraNotificacionesTrProcLst;
  @required final int? varMuestraNotificacionesTrCompLst;
  @required final int? varMuestraNotificacionesTrInfoLst;  
  @required final String? rutaNavegacionFin;


  ListaRecibos(
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
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    this.onPress2,
    this.varMuestraNotificacionesTrApLst,
    this.varMuestraNotificacionesTrProcLst,
    this.varMuestraNotificacionesTrCompLst,
    this.varMuestraNotificacionesTrInfoLst,
    //this.objUserSolicVacLst,
    this.varIconoNotTransLstNot,
    this.rutaNavegacionFin
  }) : super (key: key);
  
  @override
  Widget build(BuildContext context) {

    contextWidgetRecibo = context;

    final sizeLstNot = MediaQuery.of(context).size;
    initializeDateFormatting('es');       

  return Container(
    color: Colors.transparent,
    width: sizeLstNot.width,
    //height: sizeLstNot.height * 0.2,
    child: GestureDetector(
          onTap: () async {
            const storage = FlutterSecureStorage();

            await storage.write(key: 'IdRecibo', value: '');
            await storage.write(key: 'IdRecibo', value: "$varIdNotificacionLst");
            
            //ignore: use_build_context_synchronously
            context.push(rutaNavegacionFin!);
          },
          child: Column(
            children: [
              Container(
                width: sizeLstNot.width,
                height: sizeLstNot.height * 0.1,
                margin: const EdgeInsets.all(3), 
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
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  dense: true,
                  minVerticalPadding: 15,
                  title:  Container( 
                    width: sizeLstNot.width * 0.98,//65,
                    height: sizeLstNot.height * 0.08,
                    //height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.11 : sizeLstNot.height * 0.3,
                    alignment: Alignment.center, 
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
          
                        Container(
                          width: sizeLstNot.width * 0.65,
                          height: sizeLstNot.height * 0.3,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Container(color: Colors.transparent, width: sizeLstNot.width * 0.7, height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.05,child: AutoSizeText( texto!, style: const TextStyle( color: Colors.black, fontWeight: FontWeight.bold ), presetFontSizes: const [18,16,14,12], maxLines: 2,)),
                              
                              Container(color: Colors.transparent, width: sizeLstNot.width * 0.7, height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.05,child: AutoSizeText( texto2!, style: const TextStyle( color: Colors.black,   ), presetFontSizes: const [14,12,10,8], maxLines: 2,)),                              
                            ],
                          ),
                        ),
          
                        Container(color: Colors.transparent, width: sizeLstNot.width * 0.25, height: sizeLstNot.height * 0.056, alignment: Alignment.centerRight, child: AutoSizeText( varNumIdentifLst ?? '', style: const TextStyle( color: Colors.black, fontSize: 22), maxLines: 1,)),
                      
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

class ItemsListaRecibosWidgetBackground extends StatelessWidget {
  
    final IconData icon;
    final Color color1;
    final Color color2;
    final String varImgNot;

  const ItemsListaRecibosWidgetBackground( Key? key, this.icon, this.color1, this.color2, this.varImgNot ) : super (key: key);

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
