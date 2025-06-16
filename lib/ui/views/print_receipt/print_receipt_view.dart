//import 'package:animate_do/animate_do.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cve_app/domain/models/models.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
//import 'package:cve_app/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
*/
//import 'package:provider/provider.dart';

/*
class PrintReceiptView extends StatelessWidget {

  const PrintReceiptView(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;        

    return Center(
      child: ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: PrintReceiptViewSt(size: size),
      )        
    );
  }
}

class PrintReceiptViewSt extends StatelessWidget {

  const PrintReceiptViewSt({
    super.key,
    required this.size
  });

  final Size size;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: state.getReceipts(),
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

                return Container(
                  width: size.width,
                  height: size.height * 0.82,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                                    
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
*/

String searchQuery = '';

List<ItemBoton> filteredTransactions = [];

Map<String, List<ItemBoton>> groupedTransactions = {};
//TextEditingController passWordTxt = TextEditingController();
late TextEditingController searchTxt;

class PrintReceiptView extends StatefulWidget {
  @override
  PrintReceiptViewSt createState() => PrintReceiptViewSt();
}

class PrintReceiptViewSt extends State<PrintReceiptView> {

  @override
  void initState() {
    super.initState();

    searchQuery = '';
    filteredTransactions = [];
    groupedTransactions = {};
    searchTxt = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;    

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context,state) {
        return FutureBuilder(
          future: state.getReceipts(),
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

                if(searchQuery.isNotEmpty){
                  filteredTransactions = lstMenu
                    .where((tx) => tx.mensajeNotificacion.toLowerCase().contains(searchQuery.toLowerCase()))
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

                
                return Container(
                  width: size.width,
                  height: size.height * 0.82,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                                    
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
                
/*
                return Scaffold(
                  body: Container(
                    width: size.width,
                    height: size.height * 0.82,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchTxt,
                            decoration: InputDecoration(
                              hintText: 'Buscar',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                  
                                  setState(() {
                                    groupedTransactions = {};
                                    searchQuery = '';
                                    searchTxt.text = '';
                                  });
                  
                                },
                                icon: const Icon(Icons.cancel, color: Colors.black,)
                              ),
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
                        Expanded(
                          child: ListView(
                            children: groupedTransactions.entries.map((entry) {
                              
                              String descDia = '';
                              String descMes = '';
                              String descAnio = '';
                    
                              String fecTrx = '${entry.key.split('/')[2]}-${entry.key.split('/')[1]}-${entry.key.split('/')[0]}';
                    
                              DateTime date = DateTime.parse(fecTrx);
                    
                              if(date.day == DateTime.now().day){
                                descDia = 'Hoy';
                              }
                              else{
                                if(date.day == DateTime.now().day - 1){
                                  descDia = 'Ayer';
                                }
                                else{
                                  descDia = DateFormat('EEEE', 'es_ES').format(date);
                                  descDia = capitalizarPrimeraLetra(descDia);
                                }
                              }
                    
                              descMes = DateFormat('MMMM', 'es_ES').format(date);
                              descMes = capitalizarPrimeraLetra(descMes);
                              descAnio = '${date.year}';                  
                    
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [                                
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$descDia ${date.day}',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '$descMes $descAnio',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...entry.value.map((tx) => Card(
                                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: GestureDetector(
                                          onTap: () async {
                                            const storage = FlutterSecureStorage();
                    
                                            await storage.write(key: 'IdRecibo', value: '');
                                            await storage.write(key: 'IdRecibo', value: '${tx.ordenNot}');
                                            
                                            //ignore: use_build_context_synchronously
                                            context.push(tx.rutaNavegacion);
                                          },
                                          child: ListTile(
                                            title: Text(tx.mensajeNotificacion),
                                            //subtitle: Text(tx.mensaje2),
                                            trailing: Text(
                                              //'${tx.fechaNotificacion < 0 ? '-' : ''} \$${tx.fechaNotificacion.abs().toStringAsFixed(2)}',
                                              tx.fechaNotificacion,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      // Acción al presionar el botón
                      //print('Botón flotante presionado');
                      //para consultas por fechas
                    },
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.add),
                    
                  ),
                );
*/
              }
              
            }

            return Container();
          }
        );
      }
    );
  
  }
}

String capitalizarPrimeraLetra(String texto) {
  if (texto.isEmpty) return texto;
  return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
}