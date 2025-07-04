/*
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:cve_app/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class AccountStatementView extends StatelessWidget {

  const AccountStatementView(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;        

    return Center(
      child: ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: AccountStatementViewSt(size: size),
      )        
    );
  }
}

class AccountStatementViewSt extends StatelessWidget {
  const AccountStatementViewSt({
    super.key,
    required this.size
  });

  final Size size;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: state.getEstadoCuentas(),
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
                
                String objPerm = rspTmp;//.split('---')[2];

                List<ItemBoton> lstMenu = state.deserializeItemBotonMenuList(objPerm);

                List<Widget> itemMap = lstMenu.map(
                (item) => FadeInLeft(
                  duration: const Duration( milliseconds: 250 ),
                  child: 
                    ItemsListasWidget(
                      null,
                      varIdPosicionMostrar: 0,
                      varEsRelevante: item.esRelevante,
                      varIdNotificacion: item.ordenNot,
                      varNumIdenti: numeroIdentificacion,
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                                  
                        Container(
                          width: size.width,
                          height: size.height * 0.85,
                          color: Colors.transparent,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: <Widget>[
                              const SizedBox( height: 3, ),
                              ...itemMap,
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
*/

import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

String searchQueryAcc = '';
late TextEditingController searchAccTxt;

class AccountStatementView extends StatefulWidget {  

  const AccountStatementView(Key? key) : super (key: key);
  
  @override
  AccountStatementViewSt createState() => AccountStatementViewSt();
}

class AccountStatementViewSt extends State<AccountStatementView> {

  @override
  void initState() {
    super.initState();

    searchAccTxt = TextEditingController();
    searchQueryAcc = '';
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          //future: state.getEstadoCuentas(),
          future: DebsService().getDebts(),
          //builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
              if(snapshot.data != null && snapshot.data!.isNotEmpty) {

                List<Subscription> lstSubs = snapshot.data as List<Subscription>;
                List<Subscription> lstSubsResp = [];

                if(searchQueryAcc.isNotEmpty){
                  
                  for(int i = 0; i < lstSubs.length; i++){
                    if(lstSubs[i].contractPlan.toLowerCase().contains(searchQueryAcc.toLowerCase())){
                      lstSubsResp.add(lstSubs[i]);
                    }
                  }

                  lstSubs = [];
                  lstSubs = lstSubsResp;
                }
                
/*
                String rspTmp = snapshot.data as String;
                
                String objPerm = rspTmp;//.split('---')[2];

                List<ItemBoton> lstMenu = state.deserializeItemBotonMenuList(objPerm);

                List<Widget> itemMap = lstMenu.map(
                (item) => FadeInLeft(
                  duration: const Duration( milliseconds: 250 ),
                  child: 
                    ItemsListasWidget(
                      null,
                      varIdPosicionMostrar: 0,
                      varEsRelevante: item.esRelevante,
                      varIdNotificacion: item.ordenNot,
                      varNumIdenti: numeroIdentificacion,
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
                */

                return Container(
                  width: size.width,
                  height: size.height * 0.83,
                  color: Colors.transparent,
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchAccTxt,
                            decoration: InputDecoration(
                              hintText: locGen!.searchContPlanLbl,//'Buscar por plan del contrato',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  
                                  setState(() {                                      
                                    searchQueryAcc = '';
                                    searchAccTxt.text = searchQueryAcc;
                                  });
                                  
                                },
                                icon: const Icon(Icons.close, color: Colors.black,),
                              )
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                    
                              setState(() {
                                searchQueryAcc = searchAccTxt.text;
                              });
                              
                            },
                          ),
                        ),

                        SizedBox(height: size.height * 0.009,),
                        
                        Expanded(
                          child: ListView.builder(
                            itemCount: lstSubs.length,
                            itemBuilder: (context, index) {
                              final item = lstSubs[index];
                              
                              return GestureDetector(
                                onTap: () {
                                  idContrato = item.contractId;
                                  nameContrato = item.contractName;
                                  namePlan = item.contractPlan;

                                  DateTime dateQuote = DateTime.parse(item.contractInscriptionDate);
                                  fechaInsc = DateFormat("dd/MM/yyyy").format(dateQuote);

                                  context.push(objRutas.rutaDebsDetScrn);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: size.width,
                                      color: Colors.grey[100],
                                      height: size.height * 0.19,
                                      alignment: Alignment.center,
                                      //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: size.width * 0.85,
                                            height: size.height * 0.17,
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            //alignment: Alignment.center,
                                            child: Container(
                                              width: size.width * 0.78,
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    color: Colors.transparent,
                                                    width: size.width * 0.36,
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        
                                                        SizedBox(height: size.height * 0.019),

                                                        Text(item.contractName,
                                                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, ), maxLines: 1, overflow: TextOverflow.ellipsis,
                                                        ),
                                                        
                                                        SizedBox(height: size.height * 0.005),
                                                        
                                                        Text(item.contractPlan, maxLines: 1,  overflow: TextOverflow.ellipsis,),
                                                        
                                                        SizedBox(height: size.height * 0.008),
                                                        
                                                        Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(item.contractInscriptionDate)),style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic,)),
                                                        
                                                      ],
                                                    ),
                                                  ),
                                
                                                  Container(
                                                    width: size.width * 0.41,
                                                    color: Colors.transparent,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          color: Colors.transparent,
                                                          width: size.width * 0.3,
                                                          alignment: Alignment.centerRight,
                                                          child: Text('Total: \$${item.contractResidual.toStringAsFixed(2)}',
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize: 15)),
                                                        ),
                                                        SizedBox(height: size.height * 0.02,),
                                                        Container(
                                                          color: Colors.transparent,
                                                          width: size.width * 0.3,
                                                          alignment: Alignment.centerRight,
                                                          child: Text('Pagado: \$${item.contractResidual.toStringAsFixed(2)}',
                                                          maxLines: 1, overflow: TextOverflow.ellipsis,

                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize: 15)),
                                                        ),
                                                        SizedBox(height: size.height * 0.02,),
                                                        Container(
                                                          color: Colors.transparent,
                                                          width: size.width * 0.3,
                                                          alignment: Alignment.centerRight,
                                                          child: Text('Saldo: \$${item.contractResidual.toStringAsFixed(2)}',
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize: 15)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                
                                                  SizedBox(width: size.width * 0.0004),
                                                ],
                                              ),
                                            ),
                                          
                                          ),
                                
                                          SizedBox(height: size.height * 0.14,),
                                        
                                          Positioned(
                                            left: size.width * 0.075,//5,
                                            top: size.height * 0.12,
                                            child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE3F0FF),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text("Estado",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500, color: Colors.black)),
                                                                                    ),
                                          )
                                        ],
                                      ),
                                    ),
                                
                                    SizedBox(height: size.height * 0.04,),
                                
                                      
                                      // Ícono exterior al card
                                      Positioned(
                                        left: size.width * 0.028,//5,
                                        top: size.height * 0.042,
                                        child: const Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Color(0xFF007AFF),
                                                  child: Icon(Icons.notifications_none_outlined, //Icon(item['icon'] as IconData,
                                                      color: Colors.white),
                                                ),
                                            
                                                //if (item['unread'] as bool)
                                                   Positioned(
                                                    left: -2,
                                                    top: -2,
                                                    child: Icon(Icons.circle,
                                                        size: 10, color: Colors.blue),
                                                  )
                                          
                                          ],
                                        ),
                                      ),
                                    
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

