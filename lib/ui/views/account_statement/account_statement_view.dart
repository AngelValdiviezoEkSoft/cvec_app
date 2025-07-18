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

int idContratoAccountStatement = 0;
String nameContratoAccountStatement = '';
String namePlanAccountStatement = '';
String fechaInscAccountStatement = '';

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

    idContratoAccountStatement = 0;
    nameContratoAccountStatement = '';
    namePlanAccountStatement = '';
    fechaInscAccountStatement = '';
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          //future: state.getEstadoCuentas(),
          future: AccountStatementService().getAccountStatement(),
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

                String estadoAccount = '';

                if(searchQueryAcc.isNotEmpty){
                  
                  for(int i = 0; i < lstSubs.length; i++){
                    if(lstSubs[i].contractPlan.toLowerCase().contains(searchQueryAcc.toLowerCase())){
                      lstSubsResp.add(lstSubs[i]);
                    }
                  }

                  lstSubs = [];
                  lstSubs = lstSubsResp;
                }

                return Container(
                  width: size.width,
                  height: size.height * 0.8,
                  color: Colors.transparent,
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchAccTxt,
                            decoration: InputDecoration(                              
                              hintStyle: TextStyle(fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize32)),
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

                              switch (item.contractState) {
                                case Constants.stateAnulled:
                                  estadoAccount = locGen!.stateAnullLbl;
                                  break;
                                case Constants.stateClosed:
                                  estadoAccount = locGen!.stateClosLbl;
                                  break;
                                case Constants.stateDraft:
                                  estadoAccount = locGen!.statePreContLbl;
                                  break;
                                case Constants.stateFin:
                                  estadoAccount = locGen!.stateFinalizedLbl;
                                  break;
                                case Constants.stateOpen:
                                  estadoAccount = locGen!.stateOpenLbl;
                                  break;
                                case Constants.statePreLiq:
                                  estadoAccount = locGen!.statePreLiqLbl;
                                  break;
                                case Constants.stateLiq:
                                  estadoAccount = locGen!.stateLiquidationLbl;
                                  break;
                                default:
                                  estadoAccount = ''; // o algún valor por defecto apropiado
                              }

                              return GestureDetector(
                                onTap: () {
                                  idContratoAccountStatement = item.contractId;
                                  nameContratoAccountStatement = item.contractName;
                                  namePlanAccountStatement = item.contractPlan;

                                  DateTime dateQuote = DateTime.parse(item.contractInscriptionDate);
                                  fechaInscAccountStatement = DateFormat("dd/MM/yyyy").format(dateQuote);

                                  context.push(objRutas.rutaAccountDetScrn);
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
                                                    width: size.width * 0.45,
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        
                                                        SizedBox(height: size.height * 0.019),

                                                        Text(item.contractName,
                                                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, ), maxLines: 1, overflow: TextOverflow.ellipsis,
                                                        ),
                                                        
                                                        SizedBox(height: size.height * 0.008),
                                                        
                                                        Text('${DateFormat("dd/MM/yyyy").format(DateTime.parse(item.contractInscriptionDate))} - ${DateFormat("dd/MM/yyyy").format(DateTime.parse(item.contractDueDate))}',style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic,)),

                                                        SizedBox(height: size.height * 0.008),
                                                        Text('\$${item.contractPaidAmount.toStringAsFixed(2)}',style: const TextStyle(fontSize: 25, color: Colors.grey, fontWeight: FontWeight.bold,)),

                                                        SizedBox(height: size.height * 0.008),
                                                        LinearProgressIndicator(
                                                          value: item.contractPaidPercent,//0.75, // 0.0 a 1.0
                                                          minHeight: 10,
                                                          backgroundColor: Colors.grey[300],
                                                          color: Colors.blue,
                                                        ),
                                                        
                                                      ],
                                                    ),
                                                  ),
                                
                                                  Container(
                                                    width: size.width * 0.3,
                                                    color: Colors.transparent,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          color: Colors.transparent,
                                                          width: size.width * 0.3,
                                                          alignment: Alignment.centerRight,
                                                          /*
                                                          child: Text('${locGen!.totalLbl}: \$${item.contractResidual.toStringAsFixed(2)}',
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize: 15)),
                                                                  */
                                                        ),
                                                        
                                                        SizedBox(height: size.height * 0.02,),
                                                        
                                                        Text(item.contractPlan, maxLines: 1,  overflow: TextOverflow.ellipsis,),
                                                        
                                                        SizedBox(height: size.height * 0.02,),

                                                        Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xFFE3F0FF),
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                          child: Text(estadoAccount,style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                                                        ),
                                                        /*
                                                        SizedBox(height: size.height * 0.02,),
                                                        Container(
                                                          color: Colors.transparent,
                                                          width: size.width * 0.3,
                                                          alignment: Alignment.centerRight,
                                                          child: Text('${locGen!.balanceLbl}: \$${item.contractResidual.toStringAsFixed(2)}',
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w600, fontSize: 15)),
                                                        ),
                                                        */
                                                      ],
                                                    ),
                                                  ),
                                
                                                  SizedBox(width: size.width * 0.0004),
                                                ],
                                              ),
                                            ),
                                          
                                          ),
                                /*
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
                                            child: Text(locGen!.stateLbl,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500, color: Colors.black)),
                                                                                    ),
                                          )
                                          */
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

