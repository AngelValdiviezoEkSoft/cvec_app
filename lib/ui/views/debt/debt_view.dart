
import 'package:animate_do/animate_do.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String searchQueryDebt = '';
List<ItemBoton> filteredTransactionsDeb = [];
late TextEditingController searchDebTxt;

class DebtView extends StatefulWidget {
  
  const DebtView(Key? key) : super (key: key);
  
  @override
  DebtViewSt createState() => DebtViewSt();
}

class DebtViewSt extends State<DebtView> {

  @override
  void initState() {
    super.initState();
    searchQueryDebt = '';
    searchDebTxt = TextEditingController();
    filteredTransactionsDeb = [];
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;    

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: state.getDebitos(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

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
                String rspTmp = snapshot.data as String;
                
                String objPerm = rspTmp;

                List<ItemBoton> lstMenu = state.deserializeItemBotonMenuList(objPerm);
                filteredTransactionsDeb = lstMenu;

                if(searchQueryDebt.isNotEmpty){
                  filteredTransactionsDeb = lstMenu
                    .where((tx) => tx.tipoNotificacion.toLowerCase().contains(searchQueryDebt.toLowerCase()))
                    .toList();

                  if(filteredTransactionsDeb.isNotEmpty){
                    groupedTransactions = {};

                    for (var tx in filteredTransactionsDeb) {
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


                List<Widget> itemMap = filteredTransactionsDeb.map(
                (item) => FadeInLeft(
                  duration: const Duration( milliseconds: 250 ),
                  child: 
                    ItemsListaDebitoWidget(
                      null,                      
                      varIdPosicionMostrar: 0,
                      varEsRelevante: item.esRelevante,
                      varIdNotificacion: item.ordenNot,
                      varNumIdenti: item.fechaNotificacion,                      
                      icon: item.icon,
                      texto: item.mensajeNotificacion,
                      texto2: item.mensaje2,
                      tipoNotificacion: item.tipoNotificacion,
                      monto: item.tiempoDesde,
                      cabecera2: item.idSolicitud,
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

                
                return //lstMenu.isNotEmpty ?
                Container(
                  width: size.width,
                  height: size.height * 0.8,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchDebTxt,
                              decoration: InputDecoration(
                                hintText: locGen!.searchLbl,
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    searchDebTxt.text = '';
                                    searchQueryDebt = '';

                                    setState(() {
                                      
                                    });
                                  },
                                  icon:
                                  const Icon(
                                    Icons.cancel,
                                    size: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ),
                              onTapOutside: (event) => FocusScope.of(context).unfocus(),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                      
                                setState(() {
                                  searchQueryDebt = searchDebTxt.text;
                                });
                              },
                            ),
                          ),
                      
                          Container(
                            width: size.width,
                            height: size.height * 0.22 * lstMenu.length,
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
