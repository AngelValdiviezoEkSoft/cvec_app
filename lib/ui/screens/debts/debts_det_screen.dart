import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';


//ignore: must_be_immutable
class DebsDetScreen extends StatefulWidget {  

  const DebsDetScreen(Key? key) : super(key: key);

  @override
  DebsDetScreenState createState() => DebsDetScreenState();
}

class DebsDetScreenState extends State<DebsDetScreen> {

  Timer? _timer;
  //FileImage? _fileImage;
  String state = '';
  Color colorTextoEstado = Colors.transparent;

  var currencyFormatter = CurrencyInputFormatter(
    thousandSeparator: ThousandSeparator.None,
  );

  @override
  void initState() {
    super.initState();
    convertBase64();    

  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el timer si el usuario sale antes
    super.dispose();
  }

  void convertBase64() async {
    //FileImage image = await base64ToFileImage(objReciboDet!.receiptFile, 'mi_imagen.png');

    setState(() {
      //_fileImage = image;
    });
  }

  Future<FileImage> base64ToFileImage(String base64String, String fileName) async {
  // Elimina encabezado si lo tiene
  final pureBase64 = base64String.contains(',')
      ? base64String.split(',').last
      : base64String;

  // Decodifica a bytes
  Uint8List bytes = base64Decode(pureBase64);

  // Obtén directorio temporal
  final tempDir = await getTemporaryDirectory();

  // Crea archivo
  File file = File('${tempDir.path}/$fileName');

  // Escribe los bytes
  await file.writeAsBytes(bytes);

  // Retorna FileImage
  return FileImage(file);
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final detalleCuota = [
      {
        'title': '05 FEB 2025',
        'date': 'Cuota 05/12',
        'message': 'Plan Identidad 1',
        'amount': '\$500.00',
        'tag': 'Plan',
        'icon': Icons.notifications,
        'unread': true,
      },
      {
        'title': '05 MAR 2025',
        'date': 'Cuota 06/12',
        'message': 'Plan Identidad 2',
        'tag': 'Contrato',
        'amount': '\$200.00',
        'icon': Icons.credit_card,
        'unread': false,
      },
      {
        'title': '05 ABR 2025',
        'date': 'Cuota 07/12',
        'message': 'Plan Identidad 3',
        'tag': 'Plan',
        'amount': '\$100.00',
        'icon': Icons.notifications,
        'unread': true,
      },
      {
        'title': '05 MAY 2025',
        'date': 'Cuota 08/12',
        'message': 'Plan Identidad 4',
        'tag': 'Plan',
        'amount': '\$20.00',
        'icon': Icons.notifications,
        'unread': true,
      },
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<GenericBloc, GenericState>(
          builder: (context, stateEstado) {
        return FutureBuilder(
          future: DebsService().getDetDebts(idContrato),
          builder: (context, snapshot) {
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
        else{
          if(snapshot.data != null && snapshot.data!.isNotEmpty) {
            List<Quota> lstSubs = snapshot.data as List<Quota>;
            
              return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2EA3F2),        
                //title: Center(child: Text(locGen!.barNavLogInLbl, style: const TextStyle(color: Colors.white),)),
                title: Center(child: Text(locGen!.paymentDetLbl, style: const TextStyle(color: Colors.white),)),
                leading: GestureDetector(
                  onTap: () {
                    context.push(objRutas.rutaPrincipalUser);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios)
                  ),
                ),          
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height:  size.height * 0.02,),
            
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.3,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Contrato',
                              style: const TextStyle(fontSize: 20)),
            
                          Text('Plan terreno',
                              style: const TextStyle(fontSize: 20)),
            
                          Text('01/07/2025',
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
            
                    SizedBox(height:  size.height * 0.02,),
            
                    Expanded(
                  child: ListView.builder(
                    itemCount: lstSubs.length,
                    itemBuilder: (context, index) {
                      final item = lstSubs[index];
                      
                      return Container(
                              width: size.width,
                              color: Colors.grey[100],
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                    
                                
                                  Container(
                                    width: size.width * 0.95,
                                    height: size.height * 0.17,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      width: size.width * 0.85,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            width: size.width * 0.15,
                                            alignment: Alignment.center,
                                            child: Text(item.quotaDueDate,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600, fontSize: 20,), textAlign: TextAlign.center,),
                                          ),
            
                                          Container(
                                            color: Colors.transparent,
                                            width: size.width * 0.3,
                                            child: Text(item.quotaName,
                                                style: const TextStyle(fontSize: 20)),
                                          ),
                        
                                          Container(
                                            color: Colors.transparent,
                                            width: size.width * 0.2,
                                            child: Text('\$${item.quotaResidual}',
                                                style: const TextStyle(fontSize: 20)),
                                          ),
                        
                                          SizedBox(width: size.width * 0.0004),
                                        ],
                                      ),
                                    ),
                                  
                                  ),
                        
                                  SizedBox(height: size.height * 0.18,),
                                
                                ],
                              ),
                            );
                    },
                  ),
                ),
                  ],
                ),
              )
            );
          
          }
        }
            return Container(
              color: Colors.transparent,
              width: size.width,
              height: size.height * 0.78,
              alignment: Alignment.center,
              child: const Text("No hay datos"),
            );
          }
        );
      
      }),
    );
  }
}
