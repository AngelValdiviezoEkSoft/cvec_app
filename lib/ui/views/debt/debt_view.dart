
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String searchQueryDebt = '';
List<ItemBoton> filteredTransactionsDeb = [];
late TextEditingController searchDebTxt;
int idContrato = 0;
/*
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
*/

class DebtView extends StatelessWidget {
  const DebtView(Key? key) : super (key: key);  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notifications = [
      {
        'title': 'Primer Contrato',
        'date': 'mayo 31-2025 12:15 p. m.',
        'message': 'Plan Identidad 1',
        'amount': '\$500.00',
        'tag': 'Plan',
        'icon': Icons.notifications,
        'unread': true,
      },
      {
        'title': 'Segundo Contrato',
        'date': 'mayo 31-2025 12:15 p. m.',
        'message': 'Plan Identidad 2',
        'tag': 'Contrato',
        'amount': '\$200.00',
        'icon': Icons.credit_card,
        'unread': false,
      },
      {
        'title': 'Tercer Contrato',
        'date': 'mayo 30-2025 07:07 p. m.',
        'message': 'Plan Identidad 3',
        'tag': 'Plan',
        'amount': '\$100.00',
        'icon': Icons.notifications,
        'unread': true,
      },
      {
        'title': 'Cuarto Contrato',
        'date': 'mayo 06-2025 01:35 p. m.',
        'message': 'Plan Identidad 4',
        'tag': 'Plan',
        'amount': '\$20.00',
        'icon': Icons.notifications,
        'unread': true,
      },
    ];

    return FutureBuilder(
    future: DebsService().getDebts(),
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
          //
          if(snapshot.data != null && snapshot.data!.isNotEmpty) {

            List<Subscription> lstSubs = snapshot.data as List<Subscription>;

            return Container(
                width: size.width,
                height: size.height * 0.85,
                color: Colors.transparent,
                child: Column(
                    children: [
                      // Tabs
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF007AFF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: const Text('Todas',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF007AFF)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: const Text('No leídas',
                                    style: TextStyle(color: Color(0xFF007AFF))),
                              ),
                            ),
                            /*
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Marcar todas como leídas',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            */
                          ],
                        ),
                      ),
                
                      // Lista de notificaciones
                      Expanded(
                        child: ListView.builder(
                          itemCount: lstSubs.length,
                          itemBuilder: (context, index) {
                            final item = lstSubs[index];
                            
                            return GestureDetector(
                              onTap: () {
                                idContrato = item.contractId;

                                context.push(objRutas.rutaDebsDetScrn);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: size.width,
                                    color: Colors.grey[100],
                                    alignment: Alignment.center,
                                    //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    child: Stack(
                                      children: [
                                          
                                      
                                        Container(
                                          width: size.width * 0.92,
                                          height: size.height * 0.14,
                                          alignment: Alignment.centerRight,
                                          //color: Colors.blue,
                                          //padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          //alignment: Alignment.center,
                                          child: Container(
                                            width: size.width * 0.75,
                                            color: Colors.transparent,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    
                                                    SizedBox(height: size.height * 0.019),
                                                    Text(item.contractName,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w600, fontSize: 18)),
                                                    //const SizedBox(height: 2),
                                                    SizedBox(height: size.height * 0.005),
                                                    Text(item.contractPlan),
                                                    //const SizedBox(height: 6),
                                                    SizedBox(height: size.height * 0.008),
                                                    
                                                    Text(item.contractInscriptionDate,style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic,)),
                                                    //const SizedBox(height: 8),
                                                    /*
                                                    SizedBox(height: size.height * 0.01),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 12, vertical: 6),
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFE3F0FF),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: Text(
                                                        item['tag'] as String,
                                                        style: const TextStyle(color: Colors.black),
                                                      ),
                                                    ),
                                                    */
                                                
                                                  ],
                                                ),
                              
                                                Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.3,
                                                  alignment: Alignment.center,
                                                  child: Text('\$${item.contractResidual}',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w600, fontSize: 20)),
                                                ),
                              
                                                SizedBox(width: size.width * 0.0004),
                                              ],
                                            ),
                                          ),
                                        
                                        ),
                              
                                        SizedBox(height: size.height * 0.18,),
                                      
                                      ],
                                    ),
                                  ),
                              
                                  SizedBox(height: size.height * 0.04,),
                              
                                    
                                    // Ícono exterior al card
                                    Positioned(
                                      left: size.width * 0.006,//5,
                                      top: size.height * 0.05,
                                      child: Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          CircleAvatar(
                                                radius: 20,
                                                backgroundColor: const Color(0xFF007AFF),
                                                child: Icon(Icons.notifications_none_outlined, //Icon(item['icon'] as IconData,
                                                    color: Colors.white),
                                              ),
                                          /*
                                              if (item['unread'] as bool)
                                                const Positioned(
                                                  left: -2,
                                                  top: -2,
                                                  child: Icon(Icons.circle,
                                                      size: 10, color: Colors.blue),
                                                )
                                        */
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

        return Container(
              color: Colors.transparent,
              width: size.width,
              height: size.height * 0.78,
              alignment: Alignment.center,
              child: const Text("No hay datos"),
            );
      }
    );
    
  }
}
