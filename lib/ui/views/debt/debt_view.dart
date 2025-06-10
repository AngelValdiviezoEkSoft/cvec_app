
import 'package:flutter/material.dart';
import 'package:cve_app/auth_services.dart';
import 'package:provider/provider.dart';

class DebtView extends StatelessWidget {

  const DebtView(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;        

    return Center(
      child: ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: DebtViewSt(size: size),
      )        
    );
  }
}

class DebtViewSt extends StatelessWidget {
  const DebtViewSt({
    super.key,
    required this.size
  });

  final Size size;

  @override
  Widget build(BuildContext context) {

    //final authService = Provider.of<AuthService>(context);
    //final objRutas = RoutersApp();

    return Container(
      width: size.width,//double.infinity,
      height: size.height * 0.98,//* 1.3
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: size.height * 0.07),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 115.0),
              child: ElevatedButton(
                onPressed: () {
                  
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
                  'Deuda',
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
