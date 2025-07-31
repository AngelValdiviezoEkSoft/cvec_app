import 'dart:convert';

import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:cve_app/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
//export 'package:cve_app/infraestructure/services/services.dart';

TextEditingController userTxt = TextEditingController();
TextEditingController passWordTxt = TextEditingController();
String displayName = '';

class AuthScreen extends StatelessWidget {

  const AuthScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF2EA3F2),      
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF2EA3F2),        
          title: Center(child: Text(locGen!.barNavLogInLbl, style: const TextStyle(color: Colors.white),)),
          leading: GestureDetector(
            onTap: () {
              context.push(objRutas.rutaDefault);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios)
            ),
          ),
          
        ),
        body: Center(
          child: SingleChildScrollView(
            child: ChangeNotifierProvider(
              create: (_) => AuthService(),
              child: AuthScreenSt(size: size),
            ),
          )        
        ),
      ),
    );
  }
}

class AuthScreenSt extends StatelessWidget {
  const AuthScreenSt({
    super.key,
    required this.size
  });

  final Size size;

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final fontSizeManager = Provider.of<FontSizeManager>(context);
    //final objRutas = RoutersApp();

    return Container(
      width: size.width,//double.infinity,
      height: size.height * 0.98,//* 1.3
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,   // Inicia desde la parte superior derecha
          end: Alignment.bottomLeft,
          colors: [Colors.blue.shade600, Colors.blue.shade600, Colors.white],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              width: size.width * 0.9,
              alignment: Alignment.centerLeft,
              child: Text(
                locGen!.bienvenidaLogin,
                style: TextStyle(
                  fontSize: fontSizeManager.get(FontSizesConfig().fontSize30),
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            
            TextFormField(
              style: const TextStyle(color: Colors.white),
              autocorrect: false,
              controller: userTxt,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: '',
                labelText: locGen!.userLbl,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeManager.get(FontSizesConfig().fontSize17),
                )
              ),
            ),
            
            SizedBox(height: size.height * 0.07,),
              
            TextField(
              style: const TextStyle(color: Colors.white),
                  obscureText: authService.varIsOscured,
                  controller: passWordTxt,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: fontSizeManager.get(FontSizesConfig().fontSize17),
                    ),
                    labelText: locGen!.passwordLbl,
                    suffixIcon: 
                    !authService.varIsOscured
                      ? IconButton(
                          onPressed: () {
                            authService.varIsOscured =
                                !authService.varIsOscured;
                          },
                          icon: const Icon(Icons.visibility,
                              size: 24,
                              color: Colors.white),
                        )
                      : IconButton(
                          onPressed: () {
                            authService.varIsOscured =
                                !authService.varIsOscured;
                          },
                          icon: const Icon(
                              size: 24,
                              Icons.visibility_off,
                              color: Colors.white),
                        ),                                
                    
                  ),
                ),
              
            SizedBox(height: size.height * 0.07),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 115.0),
              child: ElevatedButton(
                onPressed: () async {
                  
                  if(userTxt.text.isEmpty || passWordTxt.text.isEmpty){
        
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return ContentAlertDialog(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          onPressedCont: () {
                            Navigator.of(context).pop();
                          },
                          tipoAlerta: AlertsType().alertAccion,
                          numLineasTitulo: 2,
                          numLineasMensaje: 2,
                          titulo: 'Error',
                          mensajeAlerta: 'Ingrese sus credenciales.'
                        );
                      },
                    );
        
                    return;
                  }
        
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => SimpleDialog(
                      alignment: Alignment.center,
                      children: [
                        SimpleDialogLoad(
                          null,
                          mensajeMostrar: locGen!.msmLog1Lbl,
                          mensajeMostrarDialogCargando: locGen!.msmLog2Lbl,
                        ),
                      ]
                    ),
                  );
      
                  AuthRequest objAuthRequest  = AuthRequest(
                    db: '',
                    login: userTxt.text,
                    password: passWordTxt.text
                  );
      
                  try {
                    
                    var resp = await AuthServices().login(objAuthRequest);
      
                    userTxt = TextEditingController();
                    passWordTxt = TextEditingController();
      
                    if(resp == 'NI'){
                      //ignore: use_build_context_synchronously
                      context.pop();
      
                      showDialog(
                        //ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Container(
                              color: Colors.transparent,
                              height: size.height * 0.22,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  Container(
                                    color: Colors.transparent,
                                    height: size.height * 0.1,
                                    child: Image.asset('assets/gifs/gifErrorBlanco.gif'),
                                  ),
      
                                  Container(
                                    color: Colors.transparent,
                                    width: size.width * 0.95,
                                    height: size.height * 0.11,
                                    alignment: Alignment.center,
                                    child: const AutoSizeText(
                                      'No tiene acceso a internet',
                                      maxLines: 2,
                                      minFontSize: 2,
                                    ),
                                  ),
                                  
                                ],
                              )
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Aceptar', style: TextStyle(color: Colors.blue[200]),),
                              ),
                            ],
                          );
                        },
                      );
                    
                      return;
                    }
                  
                    final data = json.decode(resp);
                    
                    final objError = data['error'];
                    
                    //ignore: use_build_context_synchronously
                    context.pop();
      
                    if(objError == null) {
                      displayName = data["result"]["user_name"] ?? '';
      
                      const storage = FlutterSecureStorage();
      
                      await storage.write(key: 'DataUser', value: resp);
                      await storage.write(key: 'PartnerDisplayName', value: displayName);
                      /*
                      await storage.write(key: 'StreetUser', value: data["result"]["street"] ?? '');
                      await storage.write(key: 'EmailUser', value: data["result"]["email"] ?? '');
                      await storage.write(key: 'PhoneUser', value: data["result"]["phone"] ?? '');
      */
                      //ignore: use_build_context_synchronously
                      context.push(objRutas.rutaPrincipalUser);
                    } else {
                      final msmError = data['error']['data']['name'];
      
                      showDialog(
                        //ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Container(
                              color: Colors.transparent,
                              height: size.height * 0.22,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  Container(
                                    color: Colors.transparent,
                                    height: size.height * 0.1,
                                    child: Image.asset('assets/gifs/gifErrorBlanco.gif'),
                                  ),
      
                                  Container(
                                    color: Colors.transparent,
                                    width: size.width * 0.95,
                                    height: size.height * 0.11,
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      msmError,
                                      maxLines: 2,
                                      minFontSize: 4,
                                    ),
                                  ),
                                  
                                ],
                              )
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Acción para solicitar revisión
                                  Navigator.of(context).pop();
                                  //Navigator.of(context).pop();
                                },
                                child: Text('Aceptar', style: TextStyle(color: Colors.blue[200]),),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  catch(ex){
                    //ignore: use_build_context_synchronously
                    context.pop();
      
                    showDialog(
                      //ignore: use_build_context_synchronously
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Container(
                            color: Colors.transparent,
                            height: size.height * 0.22,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Container(
                                  color: Colors.transparent,
                                  height: size.height * 0.1,
                                  child: Image.asset('assets/gifs/gifErrorBlanco.gif'),
                                ),
      
                                Container(
                                  color: Colors.transparent,
                                  width: size.width * 0.95,
                                  height: size.height * 0.11,
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    ex.toString(),
                                    maxLines: 2,
                                    minFontSize: 4,
                                  ),
                                ),
                                
                              ],
                            )
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Aceptar', style: TextStyle(color: Colors.blue[200]),),
                            ),
                          ],
                        );
                      },
                    );                        
                  }
                    
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  locGen!.logInLbl,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
              
          ],
        ),
      ),
    );
  }
}
