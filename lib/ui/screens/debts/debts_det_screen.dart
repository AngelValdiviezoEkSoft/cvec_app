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
                AppConfig().rutaGifCarga,
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height:  size.height * 0.02,),
            
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.95,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(nameContrato, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            
                          Text(namePlan, style: const TextStyle(fontSize: 16)),
            
                          Text(fechaInsc, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
            
                    SizedBox(height:  size.height * 0.02,),
            
                    Expanded(
                      child: ListView.builder(
                        itemCount: lstSubs.length,
                        itemBuilder: (context, index) {
                          final item = lstSubs[index];

                          DateTime dateQuote = DateTime.parse(item.quotaDueDate);

                          String formattedDateQuote = DateFormat("dd MMM yy", "en_US").format(dateQuote);
                          //String formatted = DateFormat("dd MMM", "en_US").format(date);
                          
                          return Container(
                            width: size.width,
                            //height: size.height * 0.25,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                  
                              
                                Container(
                                  width: size.width * 0.95,
                                  height: size.height * 0.08,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                    width: size.width * 0.85,
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          width: size.width * 0.1,
                                          alignment: Alignment.center,
                                          child: Text(formattedDateQuote, style: TextStyle(fontSize: 14, color: Colors.blue[600]), textAlign: TextAlign.center,),
                                        ),

                                        SizedBox(width: size.width * 0.02),
          
                                        Container(
                                          color: Colors.transparent,
                                          width: size.width * 0.36,
                                          child: Text(item.quotaName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,)),
                                        ),
                      
                                        Container(
                                          color: Colors.transparent,
                                          width: size.width * 0.25,
                                          alignment: Alignment.centerRight,
                                          //child: Text('\$${item.quotaResidual.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,)),
                                          child: Text('\$${item.quotaAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,)),
                                        ),
                      
                                        SizedBox(width: size.width * 0.0004),
                                      ],
                                    ),
                                  ),
                                
                                ),
                      
                                SizedBox(height: size.height * 0.09,),
                              
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
              body: Center(
                child: Container(
                  color: Colors.transparent,
                  width: size.width,
                  height: size.height * 0.78,
                  alignment: Alignment.center,
                  child: Text(locGen!.noDataLbl, style: TextStyle(fontSize: 30),),
                ),
              ),
            );
          }
        );
      
      }),
    );
  }
}
