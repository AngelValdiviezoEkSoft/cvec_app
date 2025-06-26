
import 'package:animate_do/animate_do.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String searchQueryDeposit = '';

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
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: DepositService().getDeposit(),
          builder: (context, snapshot) {

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
              /* 
              if(snapshot.hasData){
              lstBankAccount = snapshot.data as List<BankAccount>;

              if(lstBankAccount.isNotEmpty){

                for(int i = 0; i < lstBankAccount.length; i++){
                  cmbBancoCve.add(lstBankAccount[i].bankName);
                }

                selectedValueBanco = lstBankAccount[0].bankName;
                holderName = lstBankAccount[0].bankAccountHolder;
              }
              
            }
              */

              if(snapshot.data != null && snapshot.data!.isNotEmpty) {
                String rspTmp = snapshot.data as String;
                
                String objPerm = rspTmp;

                List<ItemBoton> lstMenu = state.deserializeItemBotonMenuList(objPerm);

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

                
                return //lstMenu.isNotEmpty ?
                Container(
                  width: size.width,
                  height: size.height * 0.79,
                  color: Colors.transparent,
                  //alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

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

                          Container(
                            width: size.width,
                            height: size.height * 0.12 * lstMenu.length,
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
