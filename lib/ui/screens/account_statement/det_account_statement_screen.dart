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
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:path_provider/path_provider.dart';

List<PaymentLineData> lstPaymentLineData = [];
int idDet = 0;

class PaymentItem {
  final String date;
  final String dueDate;
  final String amount;

  PaymentItem({
    required this.date,
    required this.dueDate,
    required this.amount,
  });
}

List<PaymentItem> payments = [];

//ignore: must_be_immutable
class DetAccountStatementScreen extends StatefulWidget {  

  const DetAccountStatementScreen(Key? key) : super(key: key);

  @override
  DetAccountStatementScreenState createState() => DetAccountStatementScreenState();
}

class DetAccountStatementScreenState extends State<DetAccountStatementScreen> {

  //late Future<List<PaymentLineData>> _futureDetAccount;
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
    payments = [];
    lstPaymentLineData = [];   
    //_futureDetAccount = getDetAccountStatements(idDet); 
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

  static Widget _paymentItem(PaymentLineData item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.paymentSequence, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 2),              
              Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(item.paymentDate)), style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ),
        Text('\$${item.paymentAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<GenericBloc, GenericState>(
        builder: (context, stateEstado) {
        return FutureBuilder(
          future: AccountStatementService().getDetAccountStatement(idContratoAccountStatement),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Scaffold(
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
                List<AccountStatementDet> lstSubs = snapshot.data as List<AccountStatementDet>;
                
                return Scaffold(
                  appBar: AppBar(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF2EA3F2),        
                    //title: Center(child: Text(locGen!.barNavLogInLbl, style: const TextStyle(color: Colors.white),)),
                    title: Center(child: Text(locGen!.detailLbl, style: const TextStyle(color: Colors.white),)),
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
                              Text(
                                nameContratoAccountStatement, 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize18),//18, 
                                  fontWeight: FontWeight.bold
                                )
                              ),
                
                              Text(
                                namePlanAccountStatement, 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),//16
                                )
                              ),
                
                              Text(
                                fechaInscAccountStatement, 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),//14
                                )
                              ),
                            ],
                          ),
                        ),
                
                        SizedBox(height:  size.height * 0.02,),
                
                        Expanded(
                          child: ListView.builder(
                            itemCount: lstSubs.length,
                            itemBuilder: (context, index) {
                              final item = lstSubs[index];

                              String estadoDetAccount = '';

                              DateTime dateQuote = DateTime.parse(item.quotaDueDate);

                              String formattedDateQuote = DateFormat("dd MMM yy", "en_US").format(dateQuote);
                              
                              switch (item.quotaState.toLowerCase()) {
                                case Constants.stateAnulled:
                                  estadoDetAccount = locGen!.stateAnullLbl;
                                  break;
                                case Constants.statePaid:
                                  estadoDetAccount = locGen!.statePaidLbl;
                                  break;
                                case Constants.stateOpen:
                                  estadoDetAccount = locGen!.stateOpenLbl;
                                  break;
                                default:
                                  estadoDetAccount = ''; // o algún valor por defecto apropiado
                              }
                              
                              return GestureDetector(
                                onTap: () async {

                                  lstPaymentLineData = [];
                                  lstPaymentLineData = await AccountStatementService().getDetCuotasAccountStatement(item.quotaId);

                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              item.quotaName,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                            ),
                                            
                                            const SizedBox(height: 8),

                                            Text(
                                              "\$${item.quotaPaidAmount.toStringAsFixed(2)}",
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                            ),

                                            const Divider(height: 30),

                                            lstPaymentLineData.isNotEmpty && lstPaymentLineData.first.contractName != 'VACIO' ?
                                              Container(
                                                color: Colors.transparent,
                                                height: size.height * 0.2,
                                                child: LiquidPullToRefresh(
                                                  onRefresh: () => refreshDetAccountStatements(item.quotaId),
                                                  color: Colors.blue[300],
                                                  child: SingleChildScrollView(
                                                    physics: const ScrollPhysics(),                                              
                                                    child: Column(
                                                      children: lstPaymentLineData
                                                          .map((p) => Padding(
                                                            padding: const EdgeInsets.only(bottom: 2),
                                                            child: _paymentItem(p),
                                                          )).toList(),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              :
                                              Container(
                                                color: Colors.transparent,
                                                width: size.width,
                                                height: size.height * 0.4,
                                                alignment: Alignment.center,
                                                child: Text(locGen!.noDataLbl, style: TextStyle(fontSize: 30),),
                                              ),                                                

                                            /*
                                            ...payments.map((p) => Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: _paymentItem(p),
                                                )),
                                                */
                                                
                                            const Divider(height: 30),

                                            const SizedBox(height: 10),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text(
                                                "Close",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );

                                },
                                child: Container(
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
                                        decoration: const BoxDecoration(
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
                                                child: Text(
                                                  formattedDateQuote, 
                                                  style: TextStyle(
                                                    fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),//14, 
                                                    color: Colors.blue[600]
                                                  ), 
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                          
                                              SizedBox(width: size.width * 0.02),
                                          
                                              Container(
                                                color: Colors.transparent,
                                                width: size.width * 0.22,
                                                child: Text(
                                                  item.quotaName, 
                                                  style: TextStyle(
                                                    fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),//14, 
                                                    fontWeight: FontWeight.w600,
                                                  )
                                                ),
                                              ),
                            
                                              Container(
                                                color: Colors.transparent,
                                                width: size.width * 0.3,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '\$${item.quotaPaidAmount.toStringAsFixed(2)} / \$${item.quotaAmount.toStringAsFixed(2)}', 
                                                  style: TextStyle(
                                                    fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),//14, 
                                                    fontWeight: FontWeight.w600,
                                                  )
                                                ),
                                              ),
                            
                                              SizedBox(width: size.width * 0.0004),
                          
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFE3F0FF),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(estadoDetAccount,style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                                              ),
                            
                                              SizedBox(width: size.width * 0.0004),
                                                    
                                            ],
                                          ),
                                        ),
                                      
                                      ),
                            
                                      SizedBox(height: size.height * 0.09,),
                                    
                                    ],
                                  ),
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
                /*
                actions: [
                  Container(
                    color: Colors.red,

                    child: GestureDetector(
                      onTap: () {
                        context.push(objRutas.rutaPrincipalUser);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios)
                      ),
                    ),
                  ),          
                  Text(locGen!.detailLbl, style: const TextStyle(color: Colors.white),),
                ],
                */
                title: Text(locGen!.detailLbl, style: const TextStyle(color: Colors.white),),
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

  Future<List<PaymentLineData>> getDetAccountStatements(quotaId) async {
    lstPaymentLineData = [];
    lstPaymentLineData = await AccountStatementService().getDetCuotasAccountStatement(quotaId);
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> refreshDetAccountStatements(quotaId) async {
    lstPaymentLineData = [];
    lstPaymentLineData = await AccountStatementService().getDetCuotasAccountStatement(quotaId);
    return Future.delayed(const Duration(seconds: 1));
  }
}
