import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cve_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManualSplashScreen extends StatefulWidget {
  const ManualSplashScreen({super.key});

  @override
  State<ManualSplashScreen> createState() => _ManualSplashScreenState();
}

class _ManualSplashScreenState extends State<ManualSplashScreen> {

  final objRouter = RoutersApp();

  @override
  void initState() {
    super.initState();

    // Tiempo de espera antes de navegar (en segundos)
    Future.delayed(const Duration(seconds: 7), () {
      context.push(objRouter.rutaDefault);
    });    
  
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: size.height * 0.2,),
        
            Center(
              child: Image.asset(
                'assets/logo_app_pequenio.png',
                width: size.width * 0.95,
                height: size.height * 0.2,
              )
            ),
        
            SizedBox(height: size.height * 0.04,),
        
            Container(
              color: Colors.transparent,
              width: size.width * 0.97,
              height: size.height * 0.2,
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
                    ScaleAnimatedText('Bienvenido a', textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40)),
                    ScaleAnimatedText('¡CENTRO DE VIAJES ECUADOR!', textStyle: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                  onTap: () {
                  },
                ),
              ),
            ),
                          
        
            SizedBox(height: size.height * 0.08,),
        
            // Imágenes de redes sociales
            socialImage('assets/images/redes_sociales.png', size.width * 0.5, size.height * 0.4),
          ],
        ),
      ),
    );
  }

  Widget socialImage(String imagePath, double widthDb, double heightDb) {
    return Image.asset(
      imagePath,
      width: widthDb,
      height: heightDb,
    );
  }
}
