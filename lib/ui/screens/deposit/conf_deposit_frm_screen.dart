import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';


//ignore: must_be_immutable
class ConfirmacionDepositoScreen extends StatefulWidget {  

  const ConfirmacionDepositoScreen(Key? key) : super(key: key);

  @override
  ConfirmacionDepositoScreenState createState() => ConfirmacionDepositoScreenState();
}

class ConfirmacionDepositoScreenState extends State<ConfirmacionDepositoScreen> {

  Timer? _timer;

  var currencyFormatter = CurrencyInputFormatter(
    thousandSeparator: ThousandSeparator.None,
  );

  @override
  void initState() {
    super.initState();

    //if(locGen != null)
    _timer = Timer(
      const Duration(seconds: 2), () {
        final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: locGen!.notUpdtPymntLbl,
          message: locGen!.msmNotUpdtPymntLbl,
          contentType: ContentType.success,          
          titleTextStyle: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),          
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
    
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el timer si el usuario sale antes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ColorsApp objColorsApp = ColorsApp();

    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<GenericBloc, GenericState>(
          builder: (context, stateEstado) {
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
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.pendingReviewLbl, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17),
                            )
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        
                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.photoPaymentReceiptLbl, 
                            style: TextStyle(
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                              color: Colors.grey
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.005,
                        ),
                  
                        Container(
                            width: size.width * 0.96,
                            color: Colors.transparent,
                            alignment: Alignment.centerLeft,
                            child: Container(
                                width: size.width * 0.25,
                                height: size.height * 0.17,
                                decoration: !validandoFoto
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(rutaPagoAdj)),
                                          fit: BoxFit.cover,
                                        ),                              
                                      )
                                    : BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(size.width * 0.2),
                                        border: Border.all(
                                          width: 3,
                                          color: objColorsApp.naranja50PorcTrans,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                child: GestureDetector(
                                  onTap: () async {
                                    
                                  },
                                )),
                          ),
                  
                        SizedBox(
                          height: size.height * 0.025,
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.amountPaymentLbl, 
                            style: TextStyle(
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                              color: Colors.grey
                            ),
                          ),
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            '\$${amountController.text}', 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.025,
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.paymentDateLbl, 
                            style: TextStyle(
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                              color: Colors.grey
                            )
                          ),
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            fechaHoraEscogidaMuestra, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        
                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.conceptLbl, 
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize18),
                            )
                          ),
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            concController.text, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        
                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.notesLbl, 
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            observationsController.text, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),
/*
                        SizedBox(
                          height: size.height * 0.025,
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.bankLbl, 
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            selectedValueBanco, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),


                        SizedBox(
                          height: size.height * 0.025,
                        ),

                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            locGen!.holderLbl, 
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                            )
                          ),
                        ),
                        
                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: Text(
                            holderName,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                              overflow: TextOverflow.ellipsis
                            )
                          ),
                        ),
                        */
                        
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                      ],
                    ),
                  
                  ),
                ),
              ),
            )
          );
      
      }),
    );
  }
}
