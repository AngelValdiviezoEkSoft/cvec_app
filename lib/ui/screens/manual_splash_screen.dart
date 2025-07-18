
import 'package:cve_app/config/config.dart';
import 'package:cve_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppLocalizations? locGen;

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
      //locGen = AppLocalizations.of(context);//IDIOMA DEL TELÉFONO
      context.push(objRouter.rutaDefault);
    });
    
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    locGen = AppLocalizations.of(context);

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
              width: size.width * 0.65,
              height: size.height * 0.2,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,                
                text: TextSpan(                  
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.bienvenidaCvec,//'BIENVENIDO A CENTRO',                      
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,                        
                      ),                      
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.bienvenidaCvec2('Angel'),// ' DE VIAJES ECUADOR',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
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
