
import 'package:flutter/material.dart';

class GpsAccessScreen extends StatelessWidget {

  const GpsAccessScreen(Key? key) : super(key: key);
   
   @override
   Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

   return Scaffold(
      body: Center(
         child: AccessButton(null)
      ),
   );
   }
}

class AccessButton extends StatelessWidget {
  const AccessButton(
    Key? key,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width,
          height: size.height * 0.05,
          alignment: Alignment.topRight,
          color: Colors.transparent,
          child: Row(
            children: [
              SizedBox(width: size.width * 0.07,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20)
                ),
                width: size.width * 0.1,
                height: size.height * 0.05,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    /*
                    Future.microtask(() => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const PoliticasSeguridadScreen(),
                          transitionDuration: const Duration(seconds: 0),
                        )
                      )
                    );
                    */
                  },
                  child: const Icon(Icons.question_mark_outlined),
                ),
              ),
              //SizedBox(width: size.width * 0.07,),
            ],
          ),
        ),

        SizedBox(height: size.height * 0.06,),

        Icon(Icons.location_on, size: 50, color: Colors.deepOrange,),

        SizedBox(height: size.height * 0.02,),

        const Text('Uso de tu ubicación', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

        Container(
          color: Colors.transparent,
          width: size.width * 0.85,
          height: size.height * 0.15,
          alignment: Alignment.center,
          child: const Text('En esta opción de la aplicación, se accede a tu ubicación para permitir marcar tu hora de ingreso y salida de labores y de receso.', textAlign: TextAlign.center,)
        ),

        Container(
          color: Colors.transparent,
          width: size.width * 0.85,
          height: size.height * 0.05,
          alignment: Alignment.topCenter,
          child: const Text('No queda registro de tu ubicación, bajo ningún concepto.', textAlign: TextAlign.center,)
        ),

        SizedBox(height: size.height * 0.05,),

        Container(
          color: Colors.transparent,
          width: size.width * 0.92,
          height: size.height * 0.3,
          child: const Image(image: AssetImage('assets/gifs/geolocalizacion.gif'),),
        ),

        SizedBox(height: size.height * 0.05,),

        Container(
          color: Colors.transparent,
          width: size.width * 0.8,
          height: size.height * 0.08,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                minWidth: size.width * 0.35,
                color: Colors.black,
                shape: const StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                onPressed: () {
                  
                  Navigator.of(context, rootNavigator: true).pop(context);

                },
                child: const Text('Denegar', style: TextStyle( color: Colors.white )),
              ),

              MaterialButton(
                minWidth: size.width * 0.35,
                color: Colors.orange,
                shape: const StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                onPressed: () {
                  /*
                  final gpsBloc = BlocProvider.of<GpsBloc>(context);
                  gpsBloc.askGpsAccess();
                  */

                },
                child: const Text('Aceptar', style: TextStyle( color: Colors.white )),
              )
            
            ],
          )
        ),
      ],
    );
  }
}
