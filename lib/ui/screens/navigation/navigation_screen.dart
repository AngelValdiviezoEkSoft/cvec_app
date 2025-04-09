import 'package:flutter/material.dart';
/*
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
*/
import 'package:webview_flutter/webview_flutter.dart';

String rutaGen = '';

class NavigationScreen extends StatefulWidget {
  
  NavigationScreen(Key? key, {required ruta}) : super(key: key) {
    rutaGen = ruta;
  }

  @override
  State<NavigationScreen> createState() => NavigationScreenState();

}

class NavigationScreenState extends State<NavigationScreen>  {

  late final WebViewController _wvController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _wvController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true; // Muestra el cargando
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false; // Oculta el cargando
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(rutaGen));
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold( 
      /*     
      floatingActionButton: FloatingActionButton(        
        isExtended: true,
        enableFeedback: true,
        elevation: 10,        
        onPressed: () {
          launchUrl(Uri.parse('https://wa.me/593979856428?text=Unos%20de%20nuestros%20asesores%20se%20comunicara%20con%20usted'));
        },        
        tooltip: 'Agregar',                
        backgroundColor: Colors.green,
        child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white,),
      ),
      */
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.home, color: Color(0xFF53C9EC)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          //title: const Text('Página informativa'),
          
        ),
      
      body: Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height * 0.9,//300,
        child: 
        !isLoading ?
        WebViewWidget(controller: _wvController)
        :
        const Center(
          child: CircularProgressIndicator(color: Color(0xFF53C9EC),),
        ),
      ),
    );
  }

}
