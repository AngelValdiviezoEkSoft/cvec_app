import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
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
                        //backgroundColor: Colors.white,
                      body: Center(
                        child: Image.asset(
                          AppConfig().rutaGifCarga,
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
