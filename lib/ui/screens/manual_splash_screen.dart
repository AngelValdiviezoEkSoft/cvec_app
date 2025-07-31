
import 'dart:convert';

import 'package:cve_app/config/config.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String userNameSplash = '';
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

    userNameSplash = '';

    // Tiempo de espera antes de navegar (en segundos)
    Future.delayed(const Duration(seconds: 7), () {
      //ignore: use_build_context_synchronously
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
        child: FutureBuilder(
          future: AuthServices().getDatosPerfil(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if(snapshot.hasData){
              userNameSplash = '';

              if(snapshot.data != null && snapshot.data!.isNotEmpty) {
                var rsp = jsonDecode('${snapshot.data}');
            
                if(rsp != null && rsp['result'] != null){
                  //userNameSplash = rsp['result']['data'][0]['name'] ?? '';
                  userNameSplash = rsp["result"]["user_name"] ?? '';
                }
              }
              
            }

            return Column(
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
                          text: AppLocalizations.of(context)!.bienvenidaCvec,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,                        
                          ),                      
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.bienvenidaCvec2(userNameSplash.toUpperCase()),
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
                socialImage('${RoutersApp().rutaImages}redes_sociales.png', size.width * 0.5, size.height * 0.4),
              ],
            );
          }
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
