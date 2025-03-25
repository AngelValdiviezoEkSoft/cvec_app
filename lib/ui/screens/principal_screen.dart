import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

RoutersApp objRouts = RoutersApp();

class PrincipalScreen extends StatelessWidget {

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
        home: PrincipalStScreen()
      ),
    );
  }
}


class PrincipalStScreen extends StatelessWidget {

  static const platform = MethodChannel('call_channel');

  static const platformEmail = MethodChannel('email_channel');

  final List<MenuOption> options = [
    MenuOption(icon: Icons.place, label: "Destinos", url: "https://centrodeviajesecuador.com/wp-content/uploads/2020/11/PLAN-GOLD1.jpg"),
    MenuOption(icon: Icons.home, label: "Membresías", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2020/12/MENBRES%C3%8DA.jpg'),
    MenuOption(icon: Icons.web, label: "Compra tu terreno", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2020/12/PLAN-TERRENO-2048x1536.jpg'),
    MenuOption(icon: Icons.info, label: "Tu casa programada", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2020/11/Webp.net-resizeimage-2-1.jpg'),    
    MenuOption(icon: Icons.archive_rounded, label: "Revista", url: 'https://centrodeviajesecuador.com/wp-content/uploads/2024/01/image-2-980x551.png'),
  ];

/*
  void openDialer() async {
    final Uri dialerUri = Uri.parse("tel: +593979856428");
    if (await canLaunchUrl(dialerUri)) {
      await launchUrl(dialerUri);
    } else {
      //print("No se pudo abrir el teclado de llamadas.");
    }
  }
  */

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
    final objRutas = RoutersApp();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        /*
        drawer: Drawer(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menú Principal',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () {
                  Navigator.pop(context); // Cierra el menú
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Cerrar Sesión'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        */
        appBar: AppBar(
          backgroundColor: const Color(0xFF53C9EC),
          leading: GestureDetector(
            onTap: () {
              
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/logo_app_pequenio_blanco.png'),
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                //openDialer();
                makePhoneCall();
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: size.width * 0.14,
                height: size.height * 0.05,
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white, 
                  ),
                  color: Colors.white,
                  tooltip: '(593-9) 79856428',
                  onPressed: () async {
                    //openDialer();
                    makePhoneCall();
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                openEmailApp('info@centrodeviajesecuador.com');
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: size.width * 0.14,
                height: size.height * 0.05,
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.mail,
                    color: Colors.white, 
                  ),
                  color: Colors.white,
                  tooltip: 'info@centrodeviajesecuador.com',
                  onPressed: () async { 
                    openEmailApp('info@centrodeviajesecuador.com');                 
                  },
                ),
              ),
            ),        
            InkWell(
              onTap: () {
      
                context.push(objRutas.rutaAuth);
                
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: size.width * 0.14,
                height: size.height * 0.05,
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white, 
                  ),
                  color: Colors.white,
                  tooltip: 'Ingrese',
                  onPressed: () async {
                    context.push(objRutas.rutaAuth);
                    /*
                    
                    Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                        create: (_) => AuthService(),
                        child: const AuthScreen(null)),
                      ),
                    );
                    */
                    
                  },
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
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
              children: [
                /*
                Container(
                  width: size.width,
                  height: size.height * 0.15,
                  color: Colors.transparent,
                  child: Row(
                    children: [     
                      Container(
                        width: size.width * 0.35,
                        height: size.height * 0.04,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://centrodeviajesecuador.com/wp-content/uploads/2021/07/NARBONI-CORPORATION-PNG.png'), // URL de la imagen
                            fit: BoxFit.fitHeight, // Ajusta la imagen al tamaño del contenedor
                            opacity: 0.1
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.45,
                        height: size.height * 0.12,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.02,),
      
                            const Text(
                              "Centro de Viajes Ecuador",
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
          
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SizedBox(
                              width: size.width * 0.85,
                              height: size.height * 0.02,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Canterbury',
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    ScaleAnimatedText('SIEMPRE', textStyle: const TextStyle(color: Colors.black)),
                                    ScaleAnimatedText('VACACIONES SEGURAS', textStyle: const TextStyle(color: Colors.black)),
                                    ScaleAnimatedText('¡PLANIFICA Y LOGRA LO IMPOSIBLE!', textStyle: const TextStyle(color: Colors.black)),
                                  ],
                                  onTap: () {
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                        
                      ),
                    ],
                  ),
                ),
                */
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
                Container(
                  width: size.width,
                  height: size.height * 0.68,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: GridView.builder(              
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 20,                
                        ),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return MenuTile(option: options[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFF142950),
          height: size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: size.width * 0.01,),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://www.youtube.com/@centrodeviajesecuador',)),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.17,
                  height: size.height * 0.05,
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.youtube, color: Colors.white,),
                    color: Colors.white,                  
                    onPressed: () async {                                        
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://www.youtube.com/@centrodeviajesecuador',)),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://www.facebook.com/centrodeviajesecuador',)),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.14,
                  height: size.height * 0.05,
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.white,),
                    color: Colors.white,                  
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://www.facebook.com/',)),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://www.instagram.com/centrodeviajesecuadorec/',)),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.14,
                  height: size.height * 0.05,
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.white,),
                    color: Colors.white,                  
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://www.instagram.com/',)),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.14,
                  height: size.height * 0.05,
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white,),
                    color: Colors.white,                  
                    onPressed: () async {
                      launchUrl(Uri.parse('https://wa.me/593979856428?text=Unos%20de%20nuestros%20asesores%20se%20comunicara%20con%20usted'));
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://ec.linkedin.com/company/narbonicorp?trk=public_post_feed-actor-name&fbclid=PAY2xjawIl1XNleHRuA2FlbQIxMQABpt8RnB2MEMMis00GH4Hquz6axfRqy7xAtuH9r4MiSm8apL7fjoGfJXyTvQ_aem_2LR3oSPAZpWnTLw0Ylophg',)),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.14,
                  height: size.height * 0.05,
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.white,),
                    color: Colors.white,                  
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://ec.linkedin.com/company/narbonicorp',)),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://www.tiktok.com/@centrodeviajesecuadorof?_t=ZM-8u6yTh8chD3&_r=1 ',)),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.14,
                  height: size.height * 0.05,
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.tiktok, color: Colors.white,),
                    color: Colors.white,                  
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: 'https://x.com/',)),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.01,),
            ],
          ),
        )
      ),
    );
  }
}

class MenuOption {
  final IconData icon;
  final String label;
  final String url;

  MenuOption({required this.icon, required this.label, required this.url});
}

class MenuTile extends StatelessWidget {
  final MenuOption option;

  const MenuTile({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        String ruta = '';
        if(option.label == "Destinos"){          
          ruta = '${objRouts.newRoutCve}destinos';
        }
        if(option.label == "Membresías"){
          ruta = '${objRouts.newRoutCve}mis-planes';
        }
        if(option.label == "Compra tu terreno"){
          ruta = 'https://centrodeviajesecuador.com/plan-terrenos/';          
        }
        if(option.label == "Tu casa programada"){
          ruta = '${objRouts.newRoutCve}tu-casa-programada';          
        }
        if(option.label == "Revista"){
          ruta = 'https://drive.google.com/file/d/1vvXUqg5oZ6zkmhZNjmdAZsTvO3xj4xOZ/view?usp=sharing';          
        }        

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen(null, ruta: ruta,)),
        );
      },
      child: Column(
        children: [
          Container(
            width: size.width * 0.45,
            height: size.height * 0.04,
            color: Colors.transparent,
            child: Text(option.label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
          ),
          Container(
            width: size.width * 0.45,
            height: size.height * 0.15,            
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(option.url), // URL de la imagen
                fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
              ),
              borderRadius: BorderRadius.circular(20), // Bordes redondeados
            ),
          ),
          
        ],
      ),
    );
  }
}
