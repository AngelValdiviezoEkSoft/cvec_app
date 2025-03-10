import 'package:cve_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:cve_app/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {

  const AuthScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;        

    return Scaffold(
      backgroundColor: const Color(0xFF2EA3F2),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2EA3F2),        
        title: const Center(child: Text("Ingrese sus credenciales", style: TextStyle(color: Colors.white),)),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (_) => AuthService(),
          child: AuthScreenSt(size: size),
        )        
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
    final objRutas = RoutersApp();

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
              child: const Text(
                '¡Bienvenido de nuevo!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            /*
            TextField(
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            */
            TextFormField(
              style: const TextStyle(color: Colors.white),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: '',
                labelText: 'Usuario',
                labelStyle: TextStyle(color: Colors.white)
              ),
              //onChanged: (value) => loginForm.email = value,
              /*
              validator: (value) {
                String pattern = regularExp.regexToEmail;
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
              */
            ),
            /*
            TextField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            */
            SizedBox(height: size.height * 0.07,),
      
            TextField(
              style: const TextStyle(color: Colors.white),
                  obscureText: authService.varIsOscured,
                  //controller: passWordTxt,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: 'Contraseña',
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
                onPressed: () {
                  context.push(objRutas.rutaPrincipalClient);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Acceder',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}
