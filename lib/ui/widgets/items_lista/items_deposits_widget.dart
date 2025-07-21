import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ItemsDepositsWidget extends StatelessWidget {

  @required String? varIconoNot;
  @required String? varIconoNotTrans;
  @required String? amount;
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
  final Color colorTexto;
  @required final VoidCallback? onPress;

  @required final int? varMuestraNotificacionesTrAp;
  @required final int? varMuestraNotificacionesTrProc;
  @required final int? varMuestraNotificacionesTrComp;
  @required final int? varMuestraNotificacionesTrInfo;
  @required final bool? permiteGestion;
  @required final String? rutaNavegacion;

  ItemsDepositsWidget(
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
      this.colorTexto = Colors.transparent,
      this.onPress,
      this.varMuestraNotificacionesTrAp,
      this.varMuestraNotificacionesTrProc,
      this.varMuestraNotificacionesTrComp,
      this.varMuestraNotificacionesTrInfo,
      this.varIconoNotTrans,
      this.permiteGestion,
      this.rutaNavegacion,
      this.amount
    }
  ): super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListaDeposits(
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
        colorTexto: colorTexto,
        amount: amount
      ),
      );
  
  }
}

//ignore: must_be_immutable
class ListaDeposits extends StatelessWidget {

  @required String? varIconoNot;
  @required String? amount;
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
  final Color colorTexto;
  @required final VoidCallback? onPress2;

  @required final int? varMuestraNotificacionesTrApLst;
  @required final int? varMuestraNotificacionesTrProcLst;
  @required final int? varMuestraNotificacionesTrCompLst;
  @required final int? varMuestraNotificacionesTrInfoLst;
  @required final String? rutaNavegacionFin;


  ListaDeposits(
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
    this.colorTexto = Colors.blueGrey,
    this.onPress2,
    this.varMuestraNotificacionesTrApLst,
    this.varMuestraNotificacionesTrProcLst,
    this.varMuestraNotificacionesTrCompLst,
    this.varMuestraNotificacionesTrInfoLst,
    //this.objUserSolicVacLst,
    this.varIconoNotTransLstNot,
    this.rutaNavegacionFin,
    this.amount
  }) : super (key: key);
  
  @override
  Widget build(BuildContext context) {

    final sizeLstNot = MediaQuery.of(context).size;
    initializeDateFormatting('es'); 
    
    return Container(
      color: Colors.transparent,
      width: sizeLstNot.width,
      //height: sizeLstNot.height * 0.2,
      child: GestureDetector(
            onTap: () async {
              if(onPress2 != null){
                onPress2!();
              }
              else{
                const storage = FlutterSecureStorage();

                await storage.write(key: 'IdReservaciones', value: '');
                await storage.write(key: 'IdReservaciones', value: "$varIdNotificacionLst");
                
                //ignore: use_build_context_synchronously
                context.push(rutaNavegacionFin!);
              }            
            },
            child: Column(
              children: [
                Container(
                  width: sizeLstNot.width,
                  height: sizeLstNot.height * 0.17,
                  //height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.13 : sizeLstNot.height * 0.3,
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
                      height: sizeLstNot.height * 0.45,
                      //height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.11 : sizeLstNot.height * 0.3,
                      alignment: Alignment.center, 
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
            
                          if(texto2 != null && texto2!.isNotEmpty )
                          Container(
                            width: sizeLstNot.width * 0.75,
                            height: sizeLstNot.height * 0.45,
                            color: Colors.transparent,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.transparent, 
                                  width: sizeLstNot.width * 0.7, 
                                  height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.035,
                                  child: Text( 
                                      varIconoNot!, 
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle( 
                                          color: colorTexto, 
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17)
                                        ),
                                        maxLines: 1,
                                      ),
                                ),
                                
                                Container(
                                  color: Colors.transparent, 
                                  width: sizeLstNot.width * 0.7, 
                                  height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.035,
                                  child: Text(
                                      amount!, 
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

                                if(texto != null && texto!.isNotEmpty)
                                Container(
                                    color: Colors.transparent, 
                                    width: sizeLstNot.width * 0.7, 
                                    height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.035,
                                    child: Text(
                                      texto!, 
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle( 
                                        color: Colors.black, 
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17)
                                    ), 
                                    //presetFontSizes: const [16,14,12], 
                                    maxLines: 1,
                                  )
                                ),
                                
                                if(texto2 != null && texto2!.isNotEmpty)
                                Container(
                                  color: Colors.transparent, 
                                  width: sizeLstNot.width * 0.7, 
                                  height: varNumIdentifLst != null && varNumIdentifLst!.isNotEmpty ? sizeLstNot.height * 0.036 : sizeLstNot.height * 0.035,
                                  child: Text(
                                    texto2!, 
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
            
                          if(texto != null && texto!.isNotEmpty )
                          GestureDetector(
                            onTap: () {
                              context.push(rutaNavegacionFin!);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // El círculo de fondo
                                Container(
                                  width: sizeLstNot.width * 0.1,  // Tamaño del círculo (ajusta según sea necesario)
                                  height: sizeLstNot.height * 0.08,
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
            
                          if(texto2 == null || texto2!.isEmpty)
                          GestureDetector(
                            onTap: () {    
                              context.push(rutaNavegacionFin!);
                            },
                            child: Container(
                              
                              width: sizeLstNot.width * 0.14,//44,
                              height: sizeLstNot.height * 0.13,//44, 
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

class ItemsDepositsWidgetBackground extends StatelessWidget {
  
    final IconData icon;
    final Color color1;
    final Color color2;
    final String varImgNot;

  const ItemsDepositsWidgetBackground( Key? key, this.icon, this.color1, this.color2, this.varImgNot ) : super (key: key);

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
