import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PrincipalUserScreen extends StatelessWidget {

  const PrincipalUserScreen(Key? key) : super (key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Info App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PrincipalClientStScreen()
      ),
    );
  }
}


class PrincipalClientStScreen extends StatelessWidget {

  static const platform = MethodChannel('call_channel');

  static const platformEmail = MethodChannel('email_channel');

  final List<MenuOption> options = [
    MenuOption(icon: Icons.place, label: "Destinos", url: "https://centrodeviajesecuador.com/wp-content/uploads/2020/11/PLAN-GOLD1.jpg"),
    MenuOption(icon: Icons.home, label: "Membresías", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2020/12/MENBRES%C3%8DA.jpg'),
    MenuOption(icon: Icons.web, label: "Compra tu terreno", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2020/12/PLAN-TERRENO-2048x1536.jpg'),
    MenuOption(icon: Icons.info, label: "Tu casa programada", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2020/11/Webp.net-resizeimage-2-1.jpg'),    
    MenuOption(icon: Icons.archive_rounded, label: "Revista", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2024/01/image-2-980x551.png'),
  ];

  void makePhoneCall() async {
    
    if(Platform.isAndroid){
      try {
        await platform.invokeMethod('makePhoneCall', {'phone': "+593979856428"});
      } on PlatformException catch (_) {
        //print("Error al hacer la llamada: ${e.message}");
      }
    }
    
  }

  void openEmailApp(email) async {    
    try {
      await platformEmail.invokeMethod('openEmailApp', {'email': email});
    } on PlatformException catch (_) {
      //print("Error al abrir la app de correos: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final gnrBloc = Provider.of<GenericBloc>(context);
    //final objRutas = RoutersApp();
    //AccountStatementView

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {
        return Scaffold( 
          appBar: AppBar(
            backgroundColor: const Color(0xFF53C9EC),
          ),     
          drawer: Drawer(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      gnrBloc.setShowViewAccountStatementEvent(false);
                      gnrBloc.setShowViewDebts(false);
                      gnrBloc.setShowViewPrintRecipts(false);
                      gnrBloc.setShowViewReservetions(false);
                      gnrBloc.setShowViewSendDeposits(false);
                      
                      Navigator.pop(context); // Cierra el menú 
                    },
                    child: Container(
                      width: size.width * 0.35,
                      height: size.height * 0.09,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo_app_pequenio.png'),//Image(),//NetworkImage('https://centrodeviajesecuador.com/wp-content/uploads/2021/07/NARBONI-CORPORATION-PNG.png'), // URL de la imagen
                          fit: BoxFit.fitHeight, // Ajusta la imagen al tamaño del contenedor                            
                        ),
                      ),
                    ),
                  ),
                ),
                
                ListTile(
                  leading: const Icon(Icons.document_scanner),
                  title: const Text('Estado de cuenta'),
                  onTap: () {
                    
                    gnrBloc.setShowViewAccountStatementEvent(true);
                    gnrBloc.setShowViewDebts(false);
                    gnrBloc.setShowViewPrintRecipts(false);
                    gnrBloc.setShowViewReservetions(false);
                    gnrBloc.setShowViewSendDeposits(false);
                    
                    Navigator.pop(context); // Cierra el menú 
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Deudas'),
                  onTap: () {
                    gnrBloc.setShowViewAccountStatementEvent(false);
                    gnrBloc.setShowViewDebts(true);
                    gnrBloc.setShowViewPrintRecipts(false);
                    gnrBloc.setShowViewReservetions(false);
                    gnrBloc.setShowViewSendDeposits(false);
                    
                    Navigator.pop(context); // Cierra el menú 
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.send),
                  title: const Text('Enviar depósitos'),
                  onTap: () {
                    gnrBloc.setShowViewAccountStatementEvent(false);
                    gnrBloc.setShowViewDebts(false);
                    gnrBloc.setShowViewPrintRecipts(false);
                    gnrBloc.setShowViewReservetions(false);
                    gnrBloc.setShowViewSendDeposits(true);
                    
                    Navigator.pop(context); // Cierra el menú 
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.print),
                  title: const Text('Imprimir recibos'),
                  onTap: () {
                    gnrBloc.setShowViewAccountStatementEvent(false);
                    gnrBloc.setShowViewDebts(false);
                    gnrBloc.setShowViewPrintRecipts(true);
                    gnrBloc.setShowViewReservetions(false);
                    gnrBloc.setShowViewSendDeposits(false);

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.visibility),
                  title: const Text('Ver reservas'),
                  onTap: () {
                    gnrBloc.setShowViewAccountStatementEvent(false);
                    gnrBloc.setShowViewDebts(false);
                    gnrBloc.setShowViewPrintRecipts(false);
                    gnrBloc.setShowViewReservetions(true);
                    gnrBloc.setShowViewSendDeposits(false);

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Cerrar Sesión'),
                  onTap: () {
                    
                    gnrBloc.setShowViewAccountStatementEvent(false);
                    gnrBloc.setShowViewDebts(false);
                    gnrBloc.setShowViewPrintRecipts(false);
                    gnrBloc.setShowViewReservetions(false);
                    gnrBloc.setShowViewSendDeposits(false);
                    
                    Navigator.pop(context); // Cierra el menú 

                    context.push(objRutas.rutaAuth);
                  },
                ),
              ],
            ),
          ),
          body: 
          !state.viewAccountStatement && !state.viewPrintReceipts 
          && !state.viewSendDeposits && !state.viewViewDebts && 
          !state.viewViewReservations ?
          
          SingleChildScrollView(
            child: Container(        
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://centrodeviajesecuador.com/wp-content/uploads/2020/11/PORTADA-PRINCIPAL-scaled.jpg'),
                  fit: BoxFit.fitHeight, // Ajusta la imagen al tamaño del contenedor
                  opacity: 0.3
                ),
              ),        
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.15,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [     
                        Positioned(
                          top: size.height * 0.03,
                          left: size.width * 0.235,
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.09,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/logo_app_pequenio.png'),//Image(),//NetworkImage('https://centrodeviajesecuador.com/wp-content/uploads/2021/07/NARBONI-CORPORATION-PNG.png'), // URL de la imagen
                                fit: BoxFit.fitHeight, // Ajusta la imagen al tamaño del contenedor
                                opacity: 0.1
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.79,
                          height: size.height * 0.12,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: size.height * 0.02,),
        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.75,
                                height: size.height * 0.03,
                                child: const Text(
                                  "Centro de Viajes Ecuador",
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
            
                              SizedBox(
                                height: size.height * 0.02,
                              ),
        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.97,
                                height: size.height * 0.035,
                                alignment: Alignment.center,
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Canterbury',
                                  ),
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    pause: const Duration(microseconds: 1000),
        
                                    animatedTexts: [
                                      ScaleAnimatedText('VACACIONES SEGURAS SIEMPRE', textStyle: const TextStyle(color: Colors.black)),
                                      ScaleAnimatedText('¡PLANIFICA Y LOGRA LO IMPOSIBLE!', textStyle: const TextStyle(color: Colors.black)),
                                    ],
                                    onTap: () {
                                    },
                                  ),
                                ),
                              )
                              /*
                              const Text(
                                "VACACIONES SEGURAS",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: size.height * 0.004),
                              Text(
                                "SIEMPRE",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: size.height * 0.004), // Espacio entre la primera y segunda línea
                              Text(
                                "Centro de Viajes Ecuador",
                                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: size.height * 0.004), // Aumenta el espacio entre la segunda y tercera línea
                              Text(
                                "¡PLANIFICA Y LOGRA LO IMPOSIBLE!",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            */
                            ],
                          )
                          
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )

          :

          state.viewAccountStatement ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: Column(
              children: [

                Container(
                  width: size.width,
                  height: size.height * 0.06,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: const Text('Estados de cuenta', style: TextStyle(fontSize: 25),)
                ),

                const AccountStatementView(null),
              ],
            ),
          )

          :

          state.viewViewDebts ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: const DebtView(null),
          )

          :

          state.viewSendDeposits ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: const DepositView(null),
          )

          :

          state.viewPrintReceipts ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: Column(
              children: [

                Container(
                  width: size.width,
                  height: size.height * 0.06,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: const Text('Recibos', style: TextStyle(fontSize: 25),)
                ),

                const PrintReceiptView(null),
              ],
            ),
          )


          :

          state.viewViewReservations ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: const ReservationsView(null),
          )

          :

          Container(color: Colors.red,)

        );
      }
    );
  }
}
