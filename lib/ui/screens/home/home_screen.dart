import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';

BuildContext? contextPrincipalGen;
//DonePermissions? objPermisosGen;

String compSelect = '';
String rutaFotoPerfil = '';
String numeroIdentificacion = '';
final FeatureApp objFeaturesNotificaciones = FeatureApp();
bool permiteConsulta = false;
bool permiteGestion = false;

class HomeScreen extends StatefulWidget {
  
  const HomeScreen(Key? key) : super (key: key);

  @override
  HomeScreenState createState() => HomeScreenState();

}

//ignore: must_be_immutable
class HomeScreenState extends State<HomeScreen> {

  int varPosicionMostrar = 0;

  @override
  void initState(){
    super.initState();

    contextPrincipalGen = context;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    List<String> lstComp = [];

    return SafeArea(
      child: WillPopScope(        
        onWillPop: () async => false,
        child: BlocBuilder<GenericBloc, GenericState>(
            builder: (context,state) {

              return FutureBuilder(
                future: state.readPrincipalPage(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  
                  if(!snapshot.hasData) {
                    return Scaffold(
                        backgroundColor: Colors.white,
                      body: Center(
                        child: Image.asset(
                          "assets/gifs/gif_carga.gif",
                          height: size.width * 0.85,
                          width: size.width * 0.85,
                        ),
                      ),
                    );
                  }
                  else {
                    if(snapshot.data != null && snapshot.data!.isNotEmpty) {

/*
                    if(msmInternet == 'G'){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Container(
                              color: Colors.transparent,
                              height: size.height * 0.17,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  Container(
                                    color: Colors.transparent,
                                    height: size.height * 0.09,
                                    child: Image.asset('assets/gifs/exito.gif'),
                                  ),

                                  Container(
                                    color: Colors.transparent,
                                    width: size.width * 0.95,
                                    height: size.height * 0.08,
                                    alignment: Alignment.center,
                                    child: const AutoSizeText(
                                      'Los datos que se encontraban en memoria han sido registrados.',
                                      maxLines: 2,
                                      minFontSize: 2,
                                    ),
                                  )
                                ],
                              )
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  msmInternet = "";
                                  Navigator.of(context).pop();
                                },
                                child: Text('Aceptar', style: TextStyle(color: Colors.blue[200]),),
                              ),
                            ],
                          );
                        },
                      );
                      });
                    }
                    */

                    return Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        leading: GestureDetector(
                          onTap: () {
                            //context.push(objRutasGen.rutaPerfil);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150'), // Reemplaza con la URL de la imagen del avatar
                            ),
                          ),
                        ),
                        title: const Text(
                          'Dashboard',
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: [
                              
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.65,
                            height: size.height * 0.055,
                            child:   DropdownButton<String>(
                                hint: const Icon(Icons.flip_camera_android_rounded), // Ícono del ComboBox
                                value: compSelect,
                                onChanged: (String? newValue) {
                                  //compSelect = newValue ?? '';
                                  setState(() {
                                    compSelect = newValue ?? '';
                                  });
                                },
                                items: lstComp
                                .map((activityPrsp) =>
                                    DropdownMenuItem(
                                      value: activityPrsp,
                                      child: Text(activityPrsp),
                                    ))
                                .toList(),
                              ),
                          ),
                              IconButton(
                  icon: const Icon(Icons.notifications_active, color: Colors.black),
                  onPressed: () {},
                              ),
                            ],
                          ),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Scaffold(
                              backgroundColor: Colors.white,
                              body: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    const SizedBox(height: 16.0),
                                          
                                    Container(
                                      color: Colors.transparent,
                                      width: size.width * 0.99,
                                      height: size.height * 0.55,
                                      child: Stack(
                                        children: <Widget>[
                                          
                                          Container(
                                            color: Colors.transparent,
                                            width: size.width,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.35,
                                                  child: const Text('Operaciones', style: TextStyle(fontSize: 12),)
                                                ),
                                                Container(
                                                  width: size.width * 0.35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade700,
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.grid_view_outlined, color: Colors.white,),
                                                      SizedBox(
                                                        width: size.width * 0.02,
                                                      ),
                                                      const Text('Avance del día', style: TextStyle(fontSize: 12, color: Colors.white),),
                                                    ],
                                                  )
                                                ),
                                              ],
                                            ),
                                          ),
                                      
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                      )                      
                    );
                  
                    }
                  }

                  return Container();
                }
              );
            
              
            }
        )
      ),
    );
  }
}

  Widget _buildCard({
    required String title,
    required String meta,
    required String amount,
    required double progress,
    required Color backgroundColor,
    required Color progressColor,
    required Size tamanio,
    Color textColor = Colors.white,
  }) {
    return Container(
      height: tamanio.height * 0.21,
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            width: tamanio.width * 0.35,
            height: tamanio.height * 0.28,
            color: Colors.transparent,
            child: Column(
              children: [

                SizedBox(
                  height: tamanio.height * 0.02,
                ),
                
                Container(
                  width: tamanio.width * 0.3,
                  color: Colors.transparent,
                  child: Text(
                              title,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                ),
                
                Container(
                  width: tamanio.width * 0.3,
                  color: Colors.transparent,
                  child: Text(
                    meta,
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),

              ],
            ),
          ),

          Container(
            width: tamanio.width * 0.4,
            height: tamanio.height * 0.1,
            color: Colors.transparent,
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: tamanio.width * 0.317,
                  height: tamanio.height * 0.035,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        width: tamanio.width * 0.3,
                        height: tamanio.height * 0.035,
                        color: Colors.transparent,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(                      
                            backgroundColor: Colors.grey.shade700,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FaIcon(FontAwesomeIcons.chartLine, size: 20, color: Colors.white,),
                              Text('Detalles', style: TextStyle(color:  Colors.white, fontSize: 12),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: tamanio.width * 0.01,
                        color: Colors.transparent,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
