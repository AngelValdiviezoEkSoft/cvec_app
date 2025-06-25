import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CambiarContrasenaScreen extends StatefulWidget {

  const CambiarContrasenaScreen(Key? key) : super (key: key);

  @override
  CambiarContrasenaScreenState createState() => CambiarContrasenaScreenState();
}

class CambiarContrasenaScreenState extends State<CambiarContrasenaScreen> {
  bool _ocultar1 = true;
  bool _ocultar2 = true;

  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

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
                          obscureText: _ocultar1,
                          controller: _passwordController,
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
                        
                        SizedBox(height: size.height * 0.06),//32),
                        
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