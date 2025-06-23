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
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
      backgroundColor: Color(0xFF0076E4),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          context.pop();
        },
      ),
      elevation: 0,
      toolbarHeight: 80,
      centerTitle: true,
      title: Row(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  'Cambiar Contraseña',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ),
                  
                  SizedBox(height: 8),
        
                  Text(
                    'Crea una contraseña nueva que al menos tenga 8 caracteres.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
        
                  SizedBox(height: 32),
        
                  TextField(
                    obscureText: _ocultar1,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu nueva contraseña',
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
                      fillColor: Color(0xFFF0F0F0),
                    ),
                  ),
                  
                  SizedBox(height: 20),
        
                  TextField(
                    obscureText: _ocultar2,
                    controller: _repeatPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Repite tu nueva contraseña',
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
                      fillColor: Color(0xFFF0F0F0),
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción de guardar contraseña
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0076E4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Guardar contraseña',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}