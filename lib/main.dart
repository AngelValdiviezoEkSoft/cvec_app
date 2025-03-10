
import 'package:cve_app/app/app.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:secure_application/secure_application.dart';
import 'package:provider/provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'infraestructure/services/services.dart';

void main() async {

  setupServiceLocator();

  await initializeDateFormatting();

  runApp(
    MultiProvider(
      providers:[
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(AppStarted())),
        BlocProvider(create: (context) => getIt<GenericBloc>()),
      ],
      child: ProviderScope(
        child: SecureApplication(
          secureApplicationController: SecureApplicationController(
            SecureApplicationState(
              secured: true, 
              locked: true
            )
          ),
          child: const CentroViajesApp(null)
        )
      ),
    )
  );
}

//////////
/*
class LoginScreen extends StatelessWidget {

  const LoginScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF2EA3F2),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2EA3F2),        
        title: const Center(child: Text("Ingrese sus credenciales", style: TextStyle(color: Colors.white),)),
      ),
      body: Center(
        child: Container(
          width: size.width,//double.infinity,
          height: size.height * 0.98,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,   // Inicia desde la parte superior derecha
              end: Alignment.bottomLeft,
              colors: [Colors.blue.shade600, Colors.blue.shade600, Colors.white],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
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
                
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: '',
                    labelText: 'Usuario',
                    labelStyle: TextStyle(color: Colors.white)
                  ),
                  //onChanged: (value) => loginForm.email = value,
                  
                ),
                
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
                    onPressed: () {},
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
        ),
      ),
    );
  }
}
*/
//////////
