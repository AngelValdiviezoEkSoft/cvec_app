import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

bool verValChangPassword = false;
bool tieneMayusculaChangPassword = false;
bool tieneMinusculaChangPassword = false;
bool tieneNumeroChangPassword = false;
bool tieneCaracterEspecialChangPassword = false;
bool tieneDiezCaracteresChangPassword = false;

bool nivelIntermedioBajoMedioCuartaParteChangPassword = false;
bool nivelIntermedioBajoMedioChangPassword = false;
bool nivelMedioChangPassword = false;
bool nivelIntermedioMedioAltoChangPassword = false;
bool nivelAltoChangPassword = false;
bool nivelBajoChangPassword = false;

class CambiarContrasenaScreen extends StatefulWidget {

  const CambiarContrasenaScreen(Key? key) : super (key: key);

  @override
  CambiarContrasenaScreenState createState() => CambiarContrasenaScreenState();
}

class CambiarContrasenaScreenState extends State<CambiarContrasenaScreen> {
  bool _ocultar1 = true;
  bool _ocultar2 = true;
  bool _ocultar3 = true;

  final passwordActController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    verValChangPassword = false;
    tieneMayusculaChangPassword = false;
    tieneMinusculaChangPassword = false;
    tieneNumeroChangPassword = false;
    tieneCaracterEspecialChangPassword = false;
    tieneDiezCaracteresChangPassword = false;

    nivelIntermedioBajoMedioCuartaParteChangPassword = false;
    nivelIntermedioBajoMedioChangPassword = false;
    nivelMedioChangPassword = false;
    nivelIntermedioMedioAltoChangPassword = false;
    nivelAltoChangPassword = false;
    nivelBajoChangPassword = false;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    onPassWordChanged(String password) {
      final numericRegex = RegExp(r'[0-9]');
      final mayusculaRegex = RegExp(r'[A-Z]');
      final minusculaRegex = RegExp(r'[a-z]');
      final caracterEspecialRegex = RegExp(r'[\u0021-\u002b\u003c-\u0040]');

      if (numericRegex.hasMatch(password)) {
        tieneNumeroChangPassword = true;
      } else {
        tieneNumeroChangPassword = false;
      }

      if (mayusculaRegex.hasMatch(password)) {
        tieneMayusculaChangPassword = true;
      } else {
        tieneMayusculaChangPassword = false;
      }

      if (minusculaRegex.hasMatch(password)) {
        tieneMinusculaChangPassword = true;
      } else {
        tieneMinusculaChangPassword = false;
      }

      if (caracterEspecialRegex.hasMatch(password)) {
        tieneCaracterEspecialChangPassword = true;
      } else {
        tieneCaracterEspecialChangPassword = false;
      }

      if (password == '') {
        tieneNumeroChangPassword = false;
        tieneMayusculaChangPassword = false;
        tieneMinusculaChangPassword = false;
        tieneCaracterEspecialChangPassword = false;
        nivelBajoChangPassword = false;
        nivelMedioChangPassword = false;
        nivelAltoChangPassword = false;
        nivelIntermedioBajoMedioChangPassword = false;
        nivelIntermedioMedioAltoChangPassword = false;
        tieneDiezCaracteresChangPassword = false;
      } else {
        if (password.length <= 8) {
          tieneDiezCaracteresChangPassword = false;
          if (password.length >= 7 && password.length < 9) {
            nivelIntermedioBajoMedioChangPassword = true;
          } else {
            nivelIntermedioBajoMedioChangPassword = false;
          }
          nivelBajoChangPassword = true;
          nivelMedioChangPassword = false;
          nivelAltoChangPassword = false;
        } else {
          if (password.length >= 9 && password.length <= 13) {
            tieneDiezCaracteresChangPassword = false;
            if (password.length >= 10 && password.length < 14) {
              nivelIntermedioMedioAltoChangPassword = true;
              tieneDiezCaracteresChangPassword = true;
            } else {
              nivelIntermedioMedioAltoChangPassword = false;
            }
            nivelMedioChangPassword = true;
            nivelAltoChangPassword = false;
          } else {
            if (password.length >= 14 && password.length <= 20) {
              nivelAltoChangPassword = true;
            }
          }
        }
      }

      setState(() {});
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0076E4),
      appBar: AppBar(
      backgroundColor: const Color(0xFF0076E4),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          context.pop();
        },
      ),
      elevation: 0,
      toolbarHeight: 80,
      centerTitle: true,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home, color: Colors.white, size: 30),
            SizedBox(width: 8),
            Text(
              'CVE',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
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
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        locGen!.chngPsswLbl,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        ),
                        
                        SizedBox(height: size.height * 0.005),//8),
              
                        Text(
                          locGen!.orderPsswFrmLbl,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
              
                        SizedBox(height: size.height * 0.06),//32),

                        TextField(
                          obscureText: _ocultar3,
                          controller: passwordActController,
                          decoration: InputDecoration(
                            hintText: 'Contraseña actual',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _ocultar3 ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _ocultar3 = !_ocultar3;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF0F0F0),
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.015),//32),
              
                        TextField(
                          obscureText: _ocultar1,
                          controller: _passwordController,
                          onChanged: (value) {
                            verValChangPassword = true;

                            setState(() {
                              
                            });

                            onPassWordChanged(value.toString());
                          },
                          decoration: InputDecoration(
                            hintText: locGen!.enterNewPsswLbl,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _ocultar1 ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _ocultar1 = !_ocultar1;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF0F0F0),
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.015),////20),

                        if (verValChangPassword)
                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.8,
                          height: size.height * 0.27,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    locGen!.orderValidatePasswordLbl,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                                    
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.8, //- 75,
                                height: size.height * 0.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: tieneMayusculaChangPassword
                                              ? Colors.green
                                              : Colors.red,
                                            border: tieneMayusculaChangPassword
                                              ? Border.all(color: Colors.transparent)
                                              : Border.all(color: Colors.grey.shade400),
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                              child: Icon(
                                            tieneMayusculaChangPassword
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                            size: 12,
                                          )),
                                        ),
                                        Text(
                                          //'  Una mayúscula',
                                          locGen!.capitalLetterValidatePasswordLbl,
                                          style: TextStyle(
                                            color: !tieneMayusculaChangPassword
                                              ? Colors.red
                                              : Colors.green,
                                            fontSize: 11
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.54,)
                                      ],
                                    ),
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: tieneMinusculaChangPassword
                                              ? Colors.green
                                              : Colors.red,
                                            border: tieneMinusculaChangPassword
                                              ? Border.all(color: Colors.transparent)
                                              : Border.all(color: Colors.grey.shade400),
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                              child: Icon(
                                            tieneMinusculaChangPassword
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                            size: 12,
                                          )),
                                        ),
                                        Text(
                                          //'  Una minúscula',
                                          locGen!.lowerLetterValidatePasswordLbl,
                                          style: TextStyle(
                                              color:
                                                  !tieneMinusculaChangPassword
                                                      ? Colors
                                                          .red
                                                      : Colors
                                                          .green,
                                              //fontFamily: objFuentesPassWord.fuenteMonserate,
                                              fontSize: 11),
                                        ),
                                        SizedBox(width: size.width * 0.5,)
                                      ],
                                    ),
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(
                                                  milliseconds:
                                                      500),
                                          width: 16,
                                          height: 16,
                                          decoration:
                                              BoxDecoration(
                                            color: tieneNumeroChangPassword
                                              ? Colors.green
                                              : Colors.red,
                                          border: tieneNumeroChangPassword
                                              ? Border.all(color: Colors.transparent)
                                              : Border.all(color: Colors.grey.shade400),
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                              child: Icon(
                                            tieneNumeroChangPassword
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                            size: 12,
                                          )),
                                        ),
                                        Text(
                                          //'  Un número',
                                          locGen!.numberValidatePasswordLbl,
                                          style: TextStyle(
                                              color: !tieneNumeroChangPassword
                                                  ? Colors.red
                                                  : Colors
                                                      .green,
                                              fontSize: 11),
                                        ),
                                        SizedBox(width: size.width * 0.612,)
                                      ],
                                    ),
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds:500),
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: tieneCaracterEspecialChangPassword
                                              ? Colors.green
                                              : Colors.red,
                                            border: tieneCaracterEspecialChangPassword
                                              ? Border.all(color: Colors.transparent)
                                              : Border.all(color: Colors.grey.shade400),
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                              child: Icon(
                                            tieneCaracterEspecialChangPassword
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                            size: 12,
                                          )),
                                        ),
                                        Text(
                                          //'  Un caracter especial',
                                          locGen!.specialCharacterValidatePasswordLbl,
                                          style: TextStyle(
                                            color: !tieneCaracterEspecialChangPassword
                                              ? Colors.red
                                              : Colors.green,
                                            //fontFamily: objFuentesPassWord.fuenteMonserate,
                                            fontSize: 11
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.485,)
                                      ],
                                    ),
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          width: 16,
                                          height: 16,
                                          decoration:
                                              BoxDecoration(
                                            color: tieneDiezCaracteresChangPassword
                                              ? Colors.green
                                              : Colors.red,
                                            border: tieneDiezCaracteresChangPassword
                                              ? Border.all(color: Colors.transparent)
                                              : Border.all(color: Colors.grey.shade400),
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              tieneDiezCaracteresChangPassword
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                            size: 12,
                                          )),
                                        ),
                                        Text(
                                          //'  Mínimo 10 caracteres',
                                          locGen!.minimumTenCharacterValidatePasswordLbl,
                                          style: TextStyle(
                                            color: !tieneDiezCaracteresChangPassword
                                              ? Colors.red
                                              : Colors.green,
                                            //fontFamily: objFuentesPassWord.fuenteMonserate,
                                            fontSize: 11
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.426,)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            
                            ],
                          ),
                        ),
              
                        TextField(
                          obscureText: _ocultar2,
                          controller: _repeatPasswordController,
                          decoration: InputDecoration(
                            hintText: locGen!.repeatNewPsswLbl,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _ocultar2 ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _ocultar2 = !_ocultar2;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF0F0F0),
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.06),
                        
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Acción de guardar contraseña
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0076E4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              locGen!.saveLbl,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}