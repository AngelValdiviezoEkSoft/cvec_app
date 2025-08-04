import 'dart:convert';

import 'package:cve_app/config/config.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String userNameProf = '';
String identNumbProf = '';
String phoneProf = '';
String emailProf = '';

class FrmProfileScreen extends StatelessWidget {
  
  const FrmProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
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
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white,),
            onPressed: () {
              context.push(objRutas.rutaFrmProfileEditScrn);
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: RichText(
        text: TextSpan(
          text: '$label\n',
          style: TextStyle(
            color: Colors.grey, 
            fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14)
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.black, 
                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
