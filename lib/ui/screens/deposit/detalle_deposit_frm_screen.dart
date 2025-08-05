import 'dart:async';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

//ignore: must_be_immutable
class DetalleDepositFrmScreen extends StatefulWidget {  

  const DetalleDepositFrmScreen(Key? key) : super(key: key);

  @override
  DetalleDepositFrmScreenState createState() => DetalleDepositFrmScreenState();
}

class DetalleDepositFrmScreenState extends State<DetalleDepositFrmScreen> {

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
    //convertBase64();    

    if(objReciboDet!.receiptState.toLowerCase() == 'draft'){
      state = locGen!.pendingReviewLbl;
      colorTextoEstado = Colors.black;
    }

    if(objReciboDet!.receiptState.toLowerCase() == 'rejected'){
      state = locGen!.rejectedReviewLbl;
      colorTextoEstado = Colors.red;
    }

    if(objReciboDet!.receiptState.toLowerCase() == 'approved'){
      state = locGen!.approveReviewLbl;
      colorTextoEstado = Colors.green;
    }

  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el timer si el usuario sale antes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gnrBloc = Provider.of<GenericBloc>(context);

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
              centerTitle: true,
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
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                  
                            if(state.isNotEmpty)
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                state, 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize18),
                                  fontWeight: FontWeight.bold,                                 
                                  color: colorTextoEstado,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
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
                                  color: Colors.grey,
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),

                            SizedBox(
                              height: size.height * 0.005,
                            ),

                            if(objReciboDet!.receiptFile.isNotEmpty && !stateEstado.levantaModal)
                            Container(
                              width: size.width * 0.96,
                              color: Colors.transparent,
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: size.width * 0.25,
                                height: size.height * 0.17,
                                decoration: !validandoFoto
                                ? BoxDecoration(
                                    image: 
                                    DecorationImage(
                                      image: CachedNetworkImageProvider(objReciboDet!.receiptFile),
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(size.width * 0.2),
                                    border: Border.all(
                                      width: 3,
                                      color: objColorsApp.naranja50PorcTrans,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                child: GestureDetector(
                                  onTap: () {
                                    gnrBloc.setLevantaModal(true);
                                    mostrarOpciones(context, size);
                                  },
                                ),
                              ),
                            ),

                            if (stateEstado.levantaModal)
                            Container(
                              width: size.width * 0.96,
                              color: Colors.transparent,
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: size.width * 0.25,
                                height: size.height * 0.11,
                                color: Colors.transparent,
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
                                locGen!.amountPaymentLbl, 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15),
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                  
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                '\$${objReciboDet!.receiptAmount.toStringAsFixed(2)}', 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  //color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
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
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                  
                            if(objReciboDet!.receiptDate.isNotEmpty)
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                DateFormat('dd/MM/yyyy hh:MM').format(DateTime.parse(objReciboDet!.receiptDate)), 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  //color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
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
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                  
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                objReciboDet!.receiptConcept, 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  //color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
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
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                  
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                objReciboDet!.receiptNotes ?? '', 
                                style: TextStyle(
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  //color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                  
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                  /*
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                locGen!.bankLbl, 
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  color: Colors.grey
                                ),
                                maxLines: 1,
                              ),
                            ),
                  
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                objReciboDet!.receiptBankName, 
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  //color: Colors.black
                                ),
                                maxLines: 1,
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
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  color: Colors.grey
                                ),
                                maxLines: 1,
                              ),
                            ),
                            
                            Container(
                              width: size.width * 0.96,
                              height: size.height * 0.028,
                              color: Colors.transparent,
                              child: Text(
                                objReciboDet!.receiptBankAccountHolder, 
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                  //color: Colors.black,                                
                                ),
                                maxLines: 1,
                              ),
                            ),
                            
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            */
                          ],
                        ),
                      
                      ),
                    ),
                  ),

                  if(objReciboDet!.receiptComment.isNotEmpty)
                  SizedBox(height: size.height * 0.009,),
                  
                  if(objReciboDet!.receiptComment.isNotEmpty)
                  Container(
                    width: size.width * 0.88,
                    height: size.height * 0.03,
                    color: Colors.transparent,
                    child: Text(locGen!.commentsLbl)
                  ),

                  if(objReciboDet!.receiptComment.isNotEmpty)
                  Container(
                    width: size.width * 0.88,
                    height: size.height * 0.15,
                    color: Colors.transparent,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(objReciboDet!.receiptComment)
                      ),                  
                    ),
                  ),
                ],
              ),
            )
          );
        }
      ),
    );
  }

  void mostrarOpciones(BuildContext context, Size size) {
    final gnrBloc = Provider.of<GenericBloc>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: true,      
      builder: (BuildContext context) {
        return Center(
          child: Dialog(        
            backgroundColor: Colors.transparent,    
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size.width * 0.68,
                  height: size.height * 0.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: 
                    DecorationImage(
                      image: CachedNetworkImageProvider(objReciboDet!.receiptFile),
                      fit: BoxFit.fill,
                    ),
                  )
                ),
                /* 
                decoration: !validandoFoto
                              ? BoxDecoration(
                                  image: 
                                  DecorationImage(
                                    image: CachedNetworkImageProvider(objReciboDet!.receiptFile),
                                    fit: BoxFit.fill,
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
                              
                */
                const SizedBox(height: 20),
                Container(
                  //width: size.width * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     
                      if(rutaPagoAdj.isNotEmpty)
                      const Divider(color: Colors.white24, height: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((result){
      gnrBloc.setCargando(false);
      gnrBloc.setLevantaModal(false);
    });

  }

}
