import 'dart:math';

import 'package:cve_app/config/config.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

int cantNotificaciones = 2;

class PrincipalUserScreen extends StatefulWidget {
  
  const PrincipalUserScreen(Key? key) : super (key: key);

  @override
  PrincipalUserScreenState createState() => PrincipalUserScreenState();

}

class PrincipalUserScreenState extends State<PrincipalUserScreen> with SingleTickerProviderStateMixin {  
  
  late AnimationController varController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))
    ..repeat(reverse: true);

  late Animation<Offset> animationHorizontal = Tween(begin: const Offset(-0.07, 0), end: const Offset(0.07, 0)).animate(varController);

  @override
  void initState(){
    super.initState();
    
    contextPrincipalGen = context;

    NotificationFirebaseService.messagesStream.listen((message) { 
      
      //ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 5),
        ),
      );

      setState(() {
        cantNotificaciones += 1;
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gnrBloc = Provider.of<GenericBloc>(context, listen: false);
    final fontSizeManager = Provider.of<FontSizeManager>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    double angle = pi / 420.0;

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF53C9EC),
            actions: [
              //if(mostrarBoton)
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
                tween: Tween<double>(begin: -pi / 12.0, end: angle),
                onEnd: () {
                  if (angle == pi / 12.0) {
                    setState(() {
                      angle = -pi / 12.0;
                    });
                  } else {
                    setState(() {
                      angle = 0;
                    });
                  }
                },
                builder: (_, double value, __) {
                  return Transform.rotate(
                    angle: value,
                    child: Stack(
                      children: [
                        SlideTransition(
                          position: animationHorizontal,
                          child: IconButton(
                            icon: const Icon(Icons.notifications_active),
                            color: Colors.deepOrangeAccent,
                            tooltip: 'Notificaciones',
                            onPressed: () async {
                              await context.push(objRutas.rutaListaNotificaciones);
                            },
                          ),
                        ),
                        Positioned(
                          top: 2.0,
                          right: 5.0,
                          child: Container(
                            width: 16,
                            height: 16,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                            child: 
                            /*
                            state.cantidadTotalNotificaciones < 100
                              ? Text(
                                  '${state.cantidadTotalNotificaciones}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: numNotificaciones < 100 ? 9 : 6
                                  ),
                                )
                              : 
                              */
                              Text(
                                  '$cantNotificaciones',//'99+',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 6
                                  ),
                                ),
                          )
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          onDrawerChanged: (isOpened) {
            if (isOpened) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FocusScope.of(context).requestFocus(FocusNode());
              });
            }
          },
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              SizedBox(height: size.height * 0.006),

              Container(
                color: Colors.transparent,
                height: size.height * 0.35,
                child: CarouselWidget(
                  imagePaths: [
                    '${RoutersApp().rutaImages}carrusel_1.jpg',
                    '${RoutersApp().rutaImages}carrusel_2.jpg',
                    '${RoutersApp().rutaImages}carrusel_3.jpg',
                    '${RoutersApp().rutaImages}carrusel_4.jpg'
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.15),

              Image.asset(
                "assets/logo_app_pequenio.png",
                width: size.width * 0.35,
                height: size.height * 0.09,
              ),

              //SizedBox(height: size.height * 0.08),

              Text(
                "Centro de Viajes Ecuador",
                style: TextStyle(
                  fontSize: fontSizeManager.get(FontSizesConfig().fontSize25),
                  fontWeight: FontWeight.bold,
                ),
              ),

              //SizedBox(height: size.height * 0.08),

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

              SizedBox(height: size.height * 0.25),
            ],
          ),
        ),
      ),
    );
  }
}
