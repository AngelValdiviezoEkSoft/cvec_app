import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// principal_user_screen.dart
class PrincipalUserScreen extends StatelessWidget {
  const PrincipalUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gnrBloc = Provider.of<GenericBloc>(context, listen: false);
    final fontSizeManager = Provider.of<FontSizeManager>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: const Color(0xFF53C9EC)),
          drawer: MenuLateralWidget(
            size: size,
            gnrBloc: gnrBloc,
            locGen: locGen,
            objRutas: objRutas,
            fontSizeManager: fontSizeManager,
            stateGen: state,
          ),
          body: _buildBody(state, size, fontSizeManager, themeProvider),
        );
      },
    );
  }

  Widget _buildBody(GenericState state, Size size, FontSizeManager fontSizeManager, ThemeProvider themeProvider) {
    // Determinamos el índice actual según el estado
    int currentIndex = 0;

    if (state.viewAccountStatement) { currentIndex = 1; }
    else if (state.viewViewDebts) { currentIndex = 2; }
    else if (state.viewSendDeposits) { currentIndex = 3; }
    else if (state.viewFrmDeposits) { currentIndex = 4; }
    else if (state.viewPrintReceipts) { currentIndex = 5; }
    else if (state.viewViewReservations) { currentIndex = 6; }

    return IndexedStack(
      index: currentIndex,
      children: [
        // Pantalla principal por defecto
        _buildHome(size, fontSizeManager, themeProvider),

        const AccountStatementView(null),
        const DebtView(null),
        const DepositView(null),
        const DepositFrmView(null),
        const PrintReceiptView(null),
        const ReservationsView(null),
      ],
    );
  }

  Widget _buildHome(Size size, FontSizeManager fontSizeManager, ThemeProvider themeProvider) {
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://centrodeviajesecuador.com/wp-content/uploads/2020/11/PORTADA-PRINCIPAL-scaled.jpg'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo_app_pequenio.png",
                width: size.width * 0.35,
                height: size.height * 0.09,
              ),
              const SizedBox(height: 20),
              Text(
                "Centro de Viajes Ecuador",
                style: TextStyle(
                  fontSize: fontSizeManager.get(FontSizesConfig().fontSize25),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: fontSizeManager.get(FontSizesConfig().fontSize18),
                  color: themeProvider.themeMode != ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    ScaleAnimatedText(locGen!.titulo1Introduccion),
                    ScaleAnimatedText(locGen!.titulo2Introduccion),
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


/*
// principal_user_screen.dart
class PrincipalUserScreen extends StatelessWidget {
  const PrincipalUserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final gnrBloc = Provider.of<GenericBloc>(context, listen: false);
    final fontSizeManager = Provider.of<FontSizeManager>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: const Color(0xFF53C9EC)),
          drawer: MenuLateralWidget(
            size: size,
            gnrBloc: gnrBloc,
            locGen: locGen,
            objRutas: objRutas,
            fontSizeManager: fontSizeManager,
            stateGen: state,
          ),
          body: _buildBody(state, size, fontSizeManager, themeProvider),
        );
      },
    );
  }

  Widget _buildBody(GenericState state, Size size, FontSizeManager fontSizeManager, ThemeProvider themeProvider) {
    
    if (state.viewAccountStatement) {
      return const AccountStatementView(null);
    }
    if (state.viewViewDebts) {
      return const DebtView(null);
    }
    if (state.viewSendDeposits) {
      return const DepositView(null);
    }
    if (state.viewFrmDeposits) {
      return const DepositFrmView(null);
    }
    if (state.viewPrintReceipts) {
      return const PrintReceiptView(null);
    }
    if (state.viewViewReservations) {
      return const ReservationsView(null);
    }

    // Pantalla principal por defecto
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://centrodeviajesecuador.com/wp-content/uploads/2020/11/PORTADA-PRINCIPAL-scaled.jpg'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo_app_pequenio.png",
                  width: size.width * 0.35, height: size.height * 0.09),
              const SizedBox(height: 20),
              Text(
                "Centro de Viajes Ecuador",
                style: TextStyle(
                  fontSize: fontSizeManager.get(FontSizesConfig().fontSize25),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: fontSizeManager.get(FontSizesConfig().fontSize18),
                  color: themeProvider.themeMode != ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    ScaleAnimatedText(locGen!.titulo1Introduccion),
                    ScaleAnimatedText(locGen!.titulo2Introduccion),
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
*/

/*
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

    final fontSizeManager = Provider.of<FontSizeManager>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {
        return Scaffold( 
          appBar: AppBar(
            backgroundColor: const Color(0xFF53C9EC),
          ),
          drawer: MenuLateralWidget(
            size: MediaQuery.of(context).size,
            gnrBloc: gnrBloc,
            locGen: locGen,
            objRutas: objRutas,
            fontSizeManager: fontSizeManager,
            stateGen: state,
          ),
          body: 
          !state.viewAccountStatement && !state.viewPrintReceipts 
          && !state.viewSendDeposits && !state.viewViewDebts && 
          !state.viewViewReservations && !state.viewWebSite && !state.viewFrmDeposits ?
          
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
                    height: size.height * 0.29,
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
                          width: size.width * 0.95,
                          height: size.height * 0.97,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
        
                              Text(
                                "Centro de Viajes Ecuador",
                                style: TextStyle(fontSize: fontSizeManager.get(FontSizesConfig().fontSize25), fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: size.height * 0.02,),
        
                              DefaultTextStyle(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Canterbury',
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  pause: const Duration(microseconds: 1000),
                                  animatedTexts: [
                                    ScaleAnimatedText(
                                      locGen!.titulo1Introduccion, 
                                      textAlign: TextAlign.center, 
                                      textStyle: TextStyle(
                                        fontSize: fontSizeManager.get(FontSizesConfig().fontSize18),
                                        color: themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? 
                                          Colors.black : Colors.white,
                                      )
                                    ),
                                    ScaleAnimatedText(
                                      locGen!.titulo2Introduccion, 
                                      textAlign: TextAlign.center, 
                                      textStyle: TextStyle(
                                        fontSize: fontSizeManager.get(FontSizesConfig().fontSize18),
                                        color: themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? 
                                          Colors.black : Colors.white,
                                      )
                                    ),
                                  ],
                                  onTap: () {
                                  },
                                ),
                              )
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
            child: const AccountStatementView(null),
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

          state.viewFrmDeposits ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: const DepositFrmView(null),
          )

          :

          state.viewPrintReceipts ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: const PrintReceiptView(null),
          )


          :

          state.viewViewReservations ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: const ReservationsView(null),
          )

/*
          :

          state.viewWebSite ?
          Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: const Column(
              children: [

                WebSiteView(null),
              ],
            ),
          )
*/

          :

          Container(color: Colors.red,)

        );
      }
    );
  }

}
*/
