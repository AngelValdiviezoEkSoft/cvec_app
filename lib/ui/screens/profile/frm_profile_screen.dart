import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

String userNameProf = '';
String identNumbProf = '';
String phoneProf = '';
String emailProf = '';

class FrmProfileScreen extends StatelessWidget {
  
  const FrmProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final brightness = MediaQuery.of(context).platformBrightness;

    Color colorFondo1 = Colors.transparent;

    if(themeProvider.themeMode.index == 0){
      if (brightness == Brightness.dark) {                
        colorFondo1 = Colors.black;
      } else {
        colorFondo1 = Colors.blue;
      }
    } else {
      if(themeProvider.themeMode.index == 1){        
        colorFondo1 = Colors.blue;
      }

      if(themeProvider.themeMode.index == 2){        
        
      }
    }

    return Scaffold(
      backgroundColor: colorFondo1,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(locGen!.profileLbl, style: const TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          /*
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white,),
            onPressed: () {
              context.push(objRutas.rutaFrmProfileEditScrn);
            },
          ),
          */
          IconButton(
            icon: const Icon(Icons.lightbulb_circle, color: Colors.white,),
            onPressed: () {
              showDialog(
                //ignore:use_build_context_synchronously
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Container(
                      color: Colors.transparent,
                      height: size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.95,
                            height: size.height * 0.19,
                            alignment: Alignment.center,
                            child: Center(
                              child: AutoSizeText(
                                //"Si desea actualizar sus datos, envíenos un correo a balcon@centrodeviajesecuador.com solicitando esta acción y los datos que desea actualizar.",
                                locGen!.detailDataProfileLbl,
                                maxLines: 7,
                                minFontSize: 12,
                              ),
                            ),
                          )

                        ],
                      )
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {                                                            
                          Navigator.of(context).pop();
                        },
                        child: Text(locGen!.aceptLbl, style: TextStyle(color: Colors.blue[200]),),
                      ),
                    ],
                  );
                },
              );
                  
            },
          ),
        
        ],
      ),
      body: FutureBuilder(
        future: AuthServices().getDatosPerfil(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

          if(snapshot.hasData){
            userNameProf = '';
            identNumbProf = '';
            phoneProf = '';
            emailProf = '';

            if(snapshot.data != null){
              var rsp = jsonDecode('${snapshot.data}');
          
              userNameProf = rsp["result"]["user_name"] ?? '';
              identNumbProf = rsp["result"]["vat"] ?? '';
              phoneProf = rsp["result"]["phone"] ?? '';
              emailProf = rsp["result"]["email"] ?? '';
            }

          }

          if(!snapshot.hasData){
            return Center(
              child: Image.asset(
                AppConfig().rutaGifCarga,
                height: size.width * 0.9,
                width: size.width * 0.9,
              ),
            );
          }

          return Container(
            color: Colors.transparent,
            width: size.width,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Column(
                  children: [
                      SizedBox(height: size.height * 0.06),
                              
                      Stack(
                        children: [
                          Container(
                            width: size.width * 0.95,
                            height: size.height * 0.8,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  
                                  SizedBox(height: size.height * 0.07),
                                  Card(
                                    margin: const EdgeInsets.all(6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(46.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ProfileField(label: locGen!.namLastNameLbl, value: userNameProf),
                                          ProfileField(label: locGen!.idNumberLbl, value: identNumbProf),
                                          ProfileField(label: locGen!.cellNumberLbl, value: phoneProf),
                                          ProfileField(label: locGen!.emailLbl, value: emailProf),
                                          ProfileField(label: locGen!.directionLbl, value: direccionUserPrp),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                ),
                
                if (fotoUserPrp.isEmpty)
                Positioned(
                  left: 143,
                  child: Container(
                    padding: const EdgeInsets.all(4), // grosor del borde
                    decoration: const BoxDecoration(
                      color: Colors.white, // color del borde
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[350],
                      child: const Icon(Icons.person_outline, size: 50, color: Colors.white,),
                    ),
                  ),
                ),
            
                if (fotoUserPrp.isNotEmpty)
                Positioned(
                  left: 143,
                  child: Container(
                    padding: const EdgeInsets.all(4), // grosor del borde
                    decoration: const BoxDecoration(
                      color: Colors.white, // color del borde
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[350],
                      backgroundImage: CachedNetworkImageProvider(fotoUserPrp),
                    ),
                  ),
                ),
            
              ],
            ),
          );
        }
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final brightness = MediaQuery.of(context).platformBrightness;

    Color colorFondo = Colors.transparent;

    if(themeProvider.themeMode.index == 0){
      if (brightness == Brightness.dark) {        
        colorFondo = Colors.white;
      } else {
        colorFondo = Colors.black;
      }
    } else {
      if(themeProvider.themeMode.index == 1){
        colorFondo = Colors.black;
      }

      if(themeProvider.themeMode.index == 2){        
        colorFondo = Colors.white;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: RichText(
        text: TextSpan(
          text: '$label\n',
          style: TextStyle(
            color: colorFondo, 
            fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14)
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                color: colorFondo,
                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
