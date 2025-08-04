import 'package:animate_do/animate_do.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
//import 'package:cve_app/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
//import 'package:provider/provider.dart';

String searchQueryRsv = '';
late TextEditingController searchRsvtTxt;

class ReservationsView extends StatefulWidget {
  
  const ReservationsView(Key? key) : super (key: key);
  
  @override
  ReservationsViewSt createState() => ReservationsViewSt();
}

class ReservationsViewSt extends State<ReservationsView> {

  @override
  void initState() {
    super.initState();
    searchRsvtTxt = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: state.getReservation(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if(!snapshot.hasData) {
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
            else
            {  
              if(snapshot.data != null && snapshot.data!.isNotEmpty) {
                String rspTmp = snapshot.data as String;
                
                String objPerm = rspTmp;//.split('---')[2];

                List<ItemBoton> lstMenu = state.deserializeItemBotonMenuList(objPerm);

                List<ItemBoton> lstMenuFiltrado = lstMenu;

                if(searchQueryRsv.isNotEmpty){
                  lstMenuFiltrado = [];

                  lstMenuFiltrado = lstMenu
                    .where((tx) => tx.mensajeNotificacion.toLowerCase().contains(searchQueryRsv.toLowerCase()))
                    .toList();

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
                    ItemsListasWidget(
                      null,
                      varIdPosicionMostrar: 0,
                      varEsRelevante: item.esRelevante,
                      varIdNotificacion: item.ordenNot,
                      varNumIdenti: item.fechaNotificacion, //se usa para mostrar el campo de "room include"
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
                      rutaNavegacion: ''//item.rutaNavegacion,
                    ),
                  )
                ).toList();

                return Container(
                width: size.width,
                height: size.height * 0.82,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.94,
                          height: size.height * 0.08,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.65,
                                height: size.height * 0.06,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Text(locGen!.reservationsLbl, style: TextStyle(fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize20)),)
                              ),
                          
                              Container(
                                width: size.width * 0.25,
                                height: size.height * 0.06,
                                color: Colors.transparent,
                                //alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(RoutersApp().routReservationView);
                                  },
                                  child: Container(
                                    width: size.width * 0.04,
                                    height: size.height * 0.03,
                                    decoration: const BoxDecoration(
                                      color: Colors.green, // Color de fondo
                                      shape: BoxShape.circle, // Forma circular
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.picture_as_pdf, color: Colors.white), // Ícono dentro del botón
                                  ),
                                ),
                          
                              ),
                                    
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchRsvtTxt,
                            decoration: InputDecoration(
                              hintText: 'Buscar',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {                                      
                                    searchQueryRsv = '';
                                    searchRsvtTxt.text = searchQueryRsv;
                                  });
                                },
                                icon: const Icon(Icons.close, color: Colors.black,),
                              )
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();

                              setState(() {
                                searchQueryRsv = searchRsvtTxt.text;
                              });
                            },
                          ),
                        ),    
                        
                                  
                        Container(
                          width: size.width,
                          //height: size.height * 0.85,
                          height: size.height * 0.2 * lstMenu.length,
                          color: Colors.transparent,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: <Widget>[
                              const SizedBox( height: 3, ),
                              ...itemMap,
                              const SizedBox( height: 3, ),
                            ],
                          ),
                        ),
                                  
                        SizedBox(height: size.height * 0.07),
                      
                      ],
                    ),
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
