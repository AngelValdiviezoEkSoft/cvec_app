import 'package:cve_app/config/config.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:flutter/material.dart';
import 'package:cve_app/auth_services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//import 'package:cve_app/config/config.dart';

//import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
//import 'package:go_router/go_router.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/services.dart';

class WebSiteView extends StatelessWidget {

  const WebSiteView(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;        

    return Center(
      child: ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: WebSiteViewSt(size: size),
      )        
    );
  }
}

class WebSiteViewSt extends StatelessWidget {
  const WebSiteViewSt({
    super.key,
    required this.size
  });

  final Size size;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size.width,
      height: size.height * 0.89,
      color: Colors.transparent,
      child: const ContenidoWebSiteView(null)
    );
            
  }
  
}


class ContenidoWebSiteView extends StatefulWidget {

  const ContenidoWebSiteView(Key? key) : super(key: key);

  @override
  WebSiteStScreen createState() => WebSiteStScreen();
}

class WebSiteStScreen extends State<ContenidoWebSiteView> {

  //Size? size;// = MediaQuery.of(contextPrincipalGen!).size!;

  static const platform = MethodChannel('call_channel');

  static const platformEmail = MethodChannel('email_channel');

  @override
  void initState() {    
    super.initState();
  }

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

    if(x == null && y == null){
      x = size.width * 0.84;
      y = size.height * 0.6;//0.74;
    }

    final objRutas = RoutersApp();

    List<MenuOptionWebSiteStScreen> options = [];

    if(locGen != null) {
      options = [
        MenuOptionWebSiteStScreen(icon: Icons.place, label: locGen!.menuDestinations, url: 'https://centroviajes.odoo.com/web/image/240615-c23d9c72/destinos.jpg'),//"https://centrodeviajesecuador.com/wp-content/uploads/2020/11/PLAN-GOLD1.jpg"),
        MenuOptionWebSiteStScreen(icon: Icons.home, label: locGen!.menuMemberships, url: 'https://centroviajes.odoo.com/web/image/218466-2df9071d/1.jpg'),//'https://centrodeviajesecuador.com/wp-content/uploads/2020/12/MENBRES%C3%8DA.jpg'),
        MenuOptionWebSiteStScreen(icon: Icons.web, label: locGen!.menuBuyYourLand, url: 'https://centroviajes.odoo.com/web/image/218467-d64b14b1/foto%20editada%20casa.jpg '),//'https://centrodeviajesecuador.com/wp-content/uploads/2020/12/PLAN-TERRENO-2048x1536.jpg'),
        MenuOptionWebSiteStScreen(icon: Icons.info, label: locGen!.menuYourPlannedHome, url: 'https://centroviajes.odoo.com/web/image/218465-1f2a80d8/2.JPG'),//'https://centrodeviajesecuador.com/wp-content/uploads/2020/11/Webp.net-resize!image-2-1.jpg'),    
        MenuOptionWebSiteStScreen(icon: Icons.archive_rounded, label: locGen!.menuMagazine, url: 'https://centrodeviajesecuador.com/wp-content/uploads/2024/01/image-2-980x551.png'),
      ];
    }

    Widget buildFloatingButton() {
      return FloatingActionButton(
        onPressed: () {
          launchUrl(Uri.parse('https://wa.me/593979856428?text=Unos%20de%20nuestros%20asesores%20se%20comunicara%20con%20usted'));
        },
        backgroundColor: Colors.green,
        child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white,),
      );
    }

    final languageProvider = Provider.of<LanguageProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        
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
             DropdownButton<String>(
              dropdownColor: const Color(0xFF53C9EC),
              //value: Localizations.localeOf(context).languageCode,
              value: languageProvider.locale.languageCode,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English', style: TextStyle(color: Colors.white, backgroundColor: Color(0xFF53C9EC), decorationColor: Color(0xFF53C9EC), ),)),
                DropdownMenuItem(value: 'es', child: Text('Español', style: TextStyle(color: Colors.white, backgroundColor: Color(0xFF53C9EC), decorationColor: Color(0xFF53C9EC),))),
              ],
              onChanged: (value) {
                if (value != null) {
                  /*
                  final posicionInicial = BlocProvider.of<LanguageBloc>(context);
                  posicionInicial.setLanguage(Locale(value));
                  */
                  languageProvider.changeLocale(value);
                }
              },
            ),
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
            child: Stack(
              children:
              [
                Column(
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
                            width: size.width * 0.87,
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
                                  width: size.width * 0.99,
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
                                        ScaleAnimatedText(locGen!.titulo1Introduccion, textStyle: const TextStyle(color: Colors.black)),
                                        ScaleAnimatedText(locGen!.titulo2Introduccion, textStyle: const TextStyle(color: Colors.black)),
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
                              return MenuTileWebSiteStScreen(null, option: options[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Botón flotante movible
                Positioned(
              left: x,
              top: y,
              child: Draggable(
                feedback: buildFloatingButton(),
                childWhenDragging: Container(), // Para que desaparezca mientras se arrastra
                onDragEnd: (details) {
                  setState(() {
                    x = details.offset.dx;
                    y = details.offset.dy - AppBar().preferredSize.height; // compensar la barra de estado
                  });
                },
                child: buildFloatingButton(),
              ),
            ),
              ]
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
        ),
      ),
    );
  }

}


class MenuOptionWebSiteStScreen {
  final IconData icon;
  final String label;
  final String url;

  MenuOptionWebSiteStScreen({required this.icon, required this.label, required this.url});
}

class MenuTileWebSiteStScreen extends StatelessWidget {
  final MenuOptionWebSiteStScreen option;

  const MenuTileWebSiteStScreen(Key? key,{required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        String ruta = '';
        if(option.label == locGen!.menuDestinations){//"Destinos"){          
          ruta = '${objRouts.newRoutCve}destinos';
        }
        if(option.label == locGen!.menuMemberships){//"Membresías"){
          ruta = '${objRouts.newRoutCve}mis-planes';
        }
        if(option.label == locGen!.menuBuyYourLand){//"Compra tu terreno"){
          ruta = '${objRouts.newRoutCve}plan-terrenos';          
        }
        if(option.label == locGen!.menuYourPlannedHome){//"Tu casa programada"){
          ruta = '${objRouts.newRoutCve}tu-casa-programada';          
        }
        if(option.label == locGen!.menuMagazine){//"Revista"){
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
            height: size.height * 0.03,
            color: Colors.transparent,
            child: Text(option.label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))
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

