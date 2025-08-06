import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;


  bool btnGuardarDeposit = false;
  bool btnGuardarDepositFoto = false;
  TextEditingController amountDepController = TextEditingController();
  TextEditingController compDepController = TextEditingController();
  TextEditingController concDepController = TextEditingController();
  TextEditingController observationsDepController = TextEditingController();
  String rutaPagoAdjDep = '';
  bool validandoFotoDep = false;

  String fechaHoraEscogidaDep = '';
  String fechaHoraEscogidaDepMuestra = '';
  BuildContext? contextPageDep;

class FrmDepositScreen extends StatefulWidget {
  const FrmDepositScreen(Key? key) : super(key: key);

  @override
  FrmDepositScreenState createState() => FrmDepositScreenState();
}

class FrmDepositScreenState extends State<FrmDepositScreen> {
  final _formKey = GlobalKey<FormState>();

  //String? _fileName;
  var currencyFormatter = CurrencyInputFormatter(
    thousandSeparator: ThousandSeparator.None,
  );

  String extractedText = '';  

  final List<String> cmbBancoCve = [];
  //final List<String> cmbBancoClient = ['Narboni', 'Tito Salazar'];

  File? selectedFile;

  Future<void> pickFile(FilePickerResult? result) async {
    //FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }
/*
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        //_pickedFile = result.files.first;
        //_fileName = _pickedFile!.name;
      });
    }

    pickFile(result);
  }
*/
  @override
  void initState() {
    super.initState();

    btnGuardarDeposit = false;

    concDepController = TextEditingController ();
    compDepController = TextEditingController ();
    amountDepController = TextEditingController ();
    observationsDepController = TextEditingController ();

    fechaHoraEscogidaDep = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    fechaHoraEscogidaDepMuestra = DateFormat('yyyy-MM-dd').format(DateTime.now());

    rutaPagoAdjDep = '';

    final gnrBloc = Provider.of<GenericBloc>(context, listen: false);
    gnrBloc.setLevantaModal(false);
    gnrBloc.setCargando(false);

    contextPageDep = context;
  }

  @override
  Widget build(BuildContext context) {
    final gnrBloc = Provider.of<GenericBloc>(context);
    final size = MediaQuery.of(context).size;
    contextPrincipalGen = context;
    ColorsApp objColorsApp = ColorsApp();

    final parentContext = Navigator.of(context).context;

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF2EA3F2),
              centerTitle: true,
              //title: Text(locGen!.detailLbl, style: const TextStyle(color: Colors.white),),
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                
                      Container(
                        width: size.width * 0.96,
                        height: size.height * 0.028,
                        color: Colors.transparent,
                        child: Text(
                          locGen!.photoPaymentReceiptLbl,
                          style: TextStyle(
                            fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize17)
                          ),
                        ),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.007,
                      ),
            
                      if (rutaPagoAdjDep.isEmpty && !state.levantaModal)
                        Container(
                          width: size.width * 0.96,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: size.width * 0.25,
                            height: size.height * 0.13,
                            decoration: BoxDecoration( 
                              color: Colors.grey[350], // Color de fondo
                              borderRadius: BorderRadius.circular(12), // Bordes redondeados
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  gnrBloc.setLevantaModal(true);
                                  mostrarOpciones(context, size);
                                },
                                child: const Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.white)),
                          ),
                        ),
                
                      if (state.levantaModal)
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
                
                      if (rutaPagoAdjDep.isNotEmpty && !state.levantaModal)
                        Container(
                          width: size.width * 0.96,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: size.width * 0.25,
                              height: size.height * 0.11,
                              decoration: !validandoFotoDep
                                  ? BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(File(rutaPagoAdjDep)),
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
                                  gnrBloc.setLevantaModal(true);
                                  mostrarOpciones(context, size);
                                },
                              )),
                        ),
                
                      SizedBox(
                        height: size.height * 0.025,
                      ),
            
                      TextFormField(
                        controller: amountDepController,
                        inputFormatters: [currencyFormatter],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            //fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                          ),
                          labelText: locGen!.amountLbl,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 3
                            ), // Borde cuando está enfocado
                          ),
                          prefixIcon: const Icon(Icons.monetization_on_outlined),
                          hintText: "0.00",
                          suffixIcon: IconButton(
                            onPressed: () {
                              amountDepController.text = '';
              
                              if(observationsDepController.text.isEmpty || amountDepController.text.isEmpty 
                                || compDepController.text.isEmpty || concDepController.text.isEmpty){
                                setState(() {
                                  btnGuardarDeposit = false;
                                });
                              }
                            },
                            icon: state.cargando 
                            ?
                            LoadingAnimationWidget.fallingDot(
                              color: const Color(0xFF1A1A3F),
                              size: 12,
                            )
                            :
                            const Icon(
                              Icons.cancel,
                              size: 12,
                              //color: Colors.black,
                            ),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return locGen!.msmValidateAmounLbl;//'Por favor ingrese el monto';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if(value.isNotEmpty && compDepController.text.isNotEmpty 
                          && concDepController.text.isNotEmpty && observationsDepController.text.isNotEmpty){
                            setState(() {
                              btnGuardarDeposit = true;
                            });
                          }
                        },
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      
                      TextFormField(
                        controller: compDepController,
                        decoration: InputDecoration(
                            labelText: locGen!.receiptNumberLbl,
                            labelStyle: TextStyle(
                            //fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                          ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2), // Borde cuando no está enfocado
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 3), // Borde cuando está enfocado
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                compDepController.text = '';
                
                                if(observationsDepController.text.isEmpty || amountDepController.text.isEmpty 
                                  || compDepController.text.isEmpty || concDepController.text.isEmpty){
                                  setState(() {
                                    btnGuardarDeposit = false;
                                  });
                                }
                              },
                              icon: state.cargando 
                              ?
                              LoadingAnimationWidget.fallingDot(
                                color: const Color(0xFF1A1A3F),
                                size: 12,
                              )
                              :
                              const Icon(
                                Icons.cancel,
                                size: 12,
                                //color: Colors.black,
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el título';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if(value.isNotEmpty && amountDepController.text.isNotEmpty 
                          && concDepController.text.isNotEmpty && observationsDepController.text.isNotEmpty){
                            setState(() {
                              btnGuardarDeposit = true;
                            });
                          }
                        },
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
              /*        
                      Container(
                        width: size.width * 0.96,
                        height: size.height * 0.028,
                        color: Colors.transparent,
                        child: Text(locGen!.dateLbl),
                      ),
                    
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      
                      GestureDetector(
                        onTap: () {
                          openDatePicker(context);
                        },
                        child: Container(
                          width: size.width * 0.96,
                          height: size.height * 0.028,
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              openDatePicker(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: size.width * 0.008,
                                ),
                                Text(fechaHoraEscogidaDep),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      */
                      
                      TextFormField(
                        controller: concDepController,
                        decoration: InputDecoration(
                            labelText: locGen!.conceptLbl,
                            labelStyle: TextStyle(
                            //fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                          ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2), // Borde cuando no está enfocado
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 3), // Borde cuando está enfocado
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                concDepController.text = '';
                
                                if(observationsDepController.text.isEmpty || amountDepController.text.isEmpty 
                                  || compDepController.text.isEmpty || concDepController.text.isEmpty){
                                  setState(() {
                                    btnGuardarDeposit = false;
                                  });
                                }
                              },
                              icon: state.cargando 
                              ?
                              LoadingAnimationWidget.fallingDot(
                                color: const Color(0xFF1A1A3F),
                                size: 12,
                              )
                              :
                              const Icon(
                                Icons.cancel,
                                size: 12,
                                //color: Colors.black,
                              ),
                            )
                          ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el título';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if(value.isNotEmpty && amountDepController.text.isNotEmpty 
                          && compDepController.text.isNotEmpty && observationsDepController.text.isNotEmpty){
                            setState(() {
                              btnGuardarDeposit = true;
                            });
                          }
                        },
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      
                      TextFormField(
                        controller: observationsDepController,
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelText: locGen!.notesLbl,
                            labelStyle: TextStyle(
                            //fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize15)
                          ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2), // Borde cuando no está enfocado
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 3), // Borde cuando está enfocado
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                observationsDepController.text = '';
                                if(observationsDepController.text.isEmpty || amountDepController.text.isEmpty 
                                  || compDepController.text.isEmpty || concDepController.text.isEmpty){
                                  setState(() {
                                    btnGuardarDeposit = false;
                                  });
                                }
                              },
                              icon: state.cargando 
                              ?
                              LoadingAnimationWidget.fallingDot(
                                color: const Color(0xFF1A1A3F),
                                size: 12,
                              )
                              :
                              const Icon(
                                Icons.cancel,
                                size: 12,
                                //color: Colors.black,
                              ),
                            )),
                        onChanged: (value) {
                          if(value.isNotEmpty && amountDepController.text.isNotEmpty 
                          && compDepController.text.isNotEmpty && concDepController.text.isNotEmpty){
                            setState(() {
                              btnGuardarDeposit = true;
                            });
                          }
                        },
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      
                      Container(
                        width: size.width * 0.96,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: ElevatedButton(                      
                          onPressed:
                          () {
                
                            if(amountDepController.text.isEmpty){
                              btnGuardarDeposit = false;                          
                            }
                
                            if(compDepController.text.isEmpty){
                              btnGuardarDeposit = false;                          
                            }
                
                            if(concDepController.text.isEmpty){
                              btnGuardarDeposit = false;                          
                            }
                
                            if(observationsDepController.text.isEmpty){
                              btnGuardarDeposit = false;                          
                            }
                
                            setState(() {
                              return;
                            });
                
                            if(btnGuardarDeposit){
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Icon(Icons.close)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.009,
                                          ),
                                          Text(
                                            locGen!.confirmInfoDebLbl,
                                            style: TextStyle(
                                                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      content: Container(
                                        width: size.width * 0.96,
                                        height: size.height * 0.21,
                                        color: Colors.transparent,
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${locGen!.amountPaymentLbl}: ${amountDepController.text}',
                                              style: TextStyle(
                                                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),
                                              ),
                                            ),
                                            Text(
                                              '${locGen!.receiptNumberLbl}: ${compDepController.text}',
                                              style: TextStyle(
                                                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),
                                              ),
                                            ),
                                            Text(
                                              '${locGen!.dateLbl}: $fechaHoraEscogidaDepMuestra',
                                              style: TextStyle(
                                                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),
                                              ),
                                            ),
                                            Text(
                                              '${locGen!.conceptLbl}: ${concDepController.text}',
                                              style: TextStyle(
                                                fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            
                                            if (_formKey.currentState!.validate()) {
            
                                              //ignore: use_build_context_synchronously
                                              Navigator.pop(context);
            
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) => SimpleDialog(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SimpleDialogLoad(
                                                      null,
                                                      mensajeMostrar: locGen!.msmSafeLbl,
                                                      mensajeMostrarDialogCargando: locGen!.msmSafePayLbl,
                                                    ),
                                                  ]
                                                ),
                                              );
                
                                              gnrBloc.setShowViewAccountStatementEvent(false);
                                              gnrBloc.setShowViewDebts(false);
                                              gnrBloc.setShowViewPrintRecipts(false);
                                              gnrBloc.setShowViewReservetions(false);
                                              gnrBloc.setShowViewSendDeposits(true);
                                              gnrBloc.setShowViewWebSite(false);
                                              gnrBloc.setShowViewFrmDeposit(false);
                
                                              double idPartner = 0;
                                              int idUser = 0;
            
                                              final bytes = await File(rutaPagoAdjDep).readAsBytes();
                                              String base64 = base64Encode(bytes);
            
                                              var objLog = await storage.read(key: 'RespuestaLogin') ?? '';
                                              var objLogDecode = json.decode(objLog);
            
                                              idPartner = double.parse(objLogDecode['result']['partner_id'].toString());
                                              idUser = int.parse(objLogDecode['result']['user_id'].toString());
            
                                              DepositRequestModel objRqt = DepositRequestModel(
                                                amount: double.parse(amountDepController.text),
                                                customerNotes: observationsDepController.text,
                                                date: DateTime.parse(fechaHoraEscogidaDepMuestra),
                                                idAccountBank: 0,
                                                name: concDepController.text,
                                                receiptNumber: compDepController.text,
                                                receiptFile: base64,
                                                idPartner: idPartner,
                                                idUser: idUser
                                              );
            
                                              String gifRespuesta = '';
                                              String respuestaReg = '';
            
                                              ApiRespuestaResponseModel objRsp = await DepositService().registroDeposito(objRqt);
            
                                              respuestaReg = objRsp.result.mensaje;
            
                                              if(objRsp.result.estado == 200){
                                                gifRespuesta = 'assets/gifs/exito.gif';                                                
                                              } else {
                                                gifRespuesta = 'assets/gifs/gifErrorBlanco.gif';
                                              }
            
                                              //ignore: use_build_context_synchronously
                                              Navigator.pop(parentContext);
            
                                              showDialog(
                                                //ignore:use_build_context_synchronously
                                                context: parentContext,
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
                                                            child: Image.asset(gifRespuesta),
                                                          ),
                              
                                                          Container(
                                                            color: Colors.transparent,
                                                            width: size.width * 0.95,
                                                            height: size.height * 0.08,
                                                            alignment: Alignment.center,
                                                            child: AutoSizeText(
                                                              respuestaReg,
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
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text(locGen!.aceptLbl, style: TextStyle(color: Colors.blue[200]),),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              
                                              //ignore: use_build_context_synchronously
                                              parentContext.push(objRutas.rutaConfDepositScreen);
                /*
                                              setState(() {
                                                //_pickedFile = null;
                                                //_fileName = null;
                                              });
                                              */
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 86, vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: const BorderSide(
                                                  color: Colors.blue, width: 2),
                                            ),
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                          ),
                                          child: const Text(
                                            'Sí, Continuar',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                            }
                            else {
                              //poner alerta para validar que se ingrese la foto
                            }
                          
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 150, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: btnGuardarDeposit && btnGuardarDepositFoto ? Colors.green : Colors.grey, width: 2),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                          child: Text(
                            locGen!.saveLbl,
                            style: TextStyle(
                              color: btnGuardarDeposit && btnGuardarDepositFoto ? Colors.green : Colors.grey, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
            
                      SizedBox(
                        height: size.height * 0.025,
                      ),
            
                      Container(
                        width: size.width * 0.96,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            gnrBloc.setShowViewAccountStatementEvent(false);
                            gnrBloc.setShowViewDebts(false);
                            gnrBloc.setShowViewPrintRecipts(false);
                            gnrBloc.setShowViewReservetions(false);
                            gnrBloc.setShowViewSendDeposits(true);
                            gnrBloc.setShowViewWebSite(false);
                            gnrBloc.setShowViewFrmDeposit(false);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 147, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.red, width: 2),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                          child: Text(
                            locGen!.cancelLbl,
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void openDatePicker(BuildContext context) {
    picker.DatePicker.showDateTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      setState(() {
        fechaHoraEscogidaDep = DateFormat('yyyy-MM-dd HH:mm').format(date);
        fechaHoraEscogidaDepMuestra = DateFormat('yyyy-MM-dd').format(date);
      });
    }, currentTime: DateTime.now());
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
                if(rutaPagoAdjDep.isEmpty)
                Container(
                  width: size.width * 0.27,
                  height: size.height * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_a_photo,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
                if(rutaPagoAdjDep.isNotEmpty)
                Container(
                  width: size.width * 0.68,
                  height: size.height * 0.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(rutaPagoAdjDep)),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      ),
                    ],
                  ),                  
                ),

                const SizedBox(height: 20),
                
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(rutaPagoAdjDep.isNotEmpty)
                      ListTile(
                        leading: const Icon(Icons.delete_outline, color: Colors.white),
                        title: const Text('Eliminar foto', style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          Navigator.pop(context);
                          rutaPagoAdjDep = '';
                        },
                      ),
                      if(rutaPagoAdjDep.isNotEmpty)
                      const Divider(color: Colors.white24, height: 1),
                      ListTile(
                        leading: const Icon(Icons.camera_alt, color: Colors.white),
                        title: const Text('Tomar foto', style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          Navigator.pop(context);
                          
                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

                          gnrBloc.setCargando(true);

                          try {
                            if (pickedFile != null) {
                              File file = File(pickedFile.path);
                              btnGuardarDepositFoto = true;

                              readTextFromImage(file, 'CAMARA');

                              rutaPagoAdjDep = pickedFile.path;

                              //validandoFotoDep = false;
                              gnrBloc.setCargando(false);
                              gnrBloc.setLevantaModal(false);

                              setState(() {});

                              //}
                            }
                          } catch (_) {}
                        },
                      ),
                      const Divider(color: Colors.white24, height: 1),
                      ListTile(
                        leading: const Icon(Icons.photo_library, color: Colors.white),
                        title: const Text('Seleccionar foto', style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          
                          Navigator.pop(context);

                          gnrBloc.setCargando(true);

                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                          try {
                            if (pickedFile != null) {
                              File file = File(pickedFile.path);
                              btnGuardarDepositFoto = true;

                              readTextFromImage(file, 'GALERIA');

                              rutaPagoAdjDep = pickedFile.path;

                              //validandoFotoDep = false;

                              setState(() {});

                              //}
                            }
                          } catch (_) {}
                        },
                      ),
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

  Future<void> readTextFromImage(File image, String tipoCaptura) async {
    final gnrBloc = Provider.of<GenericBloc>(context, listen: false);

    amountDepController.text = '';
    compDepController.text = '';

    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();

    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    List<String> lstDatosFrm = text.split('\n');

    if (tipoCaptura == 'GALERIA') {
      //Map<String, String> datos = extraerDatos(text);
      if (lstDatosFrm.isNotEmpty) {
        try {
          amountDepController.text = lstDatosFrm[3].split('\$')[1];
          compDepController.text = lstDatosFrm[15].split('No.')[1];

          gnrBloc.setCargando(false);
          gnrBloc.setLevantaModal(false);
          textRecognizer.close();
          return;
        } catch (_) {
          try {
            if (lstDatosFrm[4].toUpperCase().contains('\$')) {
              String numComp = lstDatosFrm[8].replaceAll(RegExp(r'[^0-9]'), '');

              amountDepController.text = lstDatosFrm[4].split('\$')[1];
              compDepController.text = numComp;

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
            if (lstDatosFrm[3].toUpperCase().contains('MONTO')) {
              String numComp = lstDatosFrm[1].replaceAll(RegExp(r'[^0-9]'), '');

              amountDepController.text = lstDatosFrm[3].split('\$')[1];
              compDepController.text = numComp;

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;              
            }
            if (lstDatosFrm[3].toUpperCase().contains('TOTAL')) {
              amountDepController.text = lstDatosFrm[4];
              compDepController.text = '${lstDatosFrm[2].split(' ')[0]} ${lstDatosFrm[2].split(' ')[1]} ${lstDatosFrm[2].split(' ')[2]}';

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
            if (lstDatosFrm[12].toUpperCase().contains('USD')) {
              String numComp = lstDatosFrm[6].replaceAll(RegExp(r'[^0-9]'), '');

              amountDepController.text = lstDatosFrm[12].split('USD')[0];
              compDepController.text = numComp;
              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
            if (lstDatosFrm[11].toUpperCase().contains('USD')) {
              var montoStr = lstDatosFrm[11].split('USD')[0];
              double.parse(montoStr);
              amountDepController.text = montoStr.trim();
              compDepController.text = lstDatosFrm[2];

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
          } catch (_) {
            //if(lstDatosFrm.length == 22){
            amountDepController.text = lstDatosFrm[10];
            compDepController.text = lstDatosFrm[9].split('SECU: ')[1];
            gnrBloc.setCargando(false);
            gnrBloc.setLevantaModal(false);
            textRecognizer.close();
            return;
            /*
            }
            
            else{
              

              if(lstDatosFrm[23].toUpperCase().contains('WONTO') || lstDatosFrm[23].toUpperCase().contains('MONTO')){
                amountDepController.text = lstDatosFrm[23].split(' ')[2];
                compDepController.text = lstDatosFrm[41].split('SECU: ')[1];
              }
              if(lstDatosFrm[12].toUpperCase().contains('BAP')){
                amountDepController.text = lstDatosFrm[13];
                compDepController.text = '${lstDatosFrm[12].split(' ')[0]} ${lstDatosFrm[12].split(' ')[1]} ${lstDatosFrm[12].split(' ')[2]}';
              }
              if(lstDatosFrm[13].toUpperCase().contains('BAP')){
                amountDepController.text = lstDatosFrm[14];
                compDepController.text = '${lstDatosFrm[13].split(' ')[0]} ${lstDatosFrm[13].split(' ')[1]} ${lstDatosFrm[13].split(' ')[2]}';
              }
              if(lstDatosFrm[11].toUpperCase().contains('BAP')){
                amountDepController.text = lstDatosFrm[13];
                compDepController.text = '${lstDatosFrm[11].split(' ')[0]} ${lstDatosFrm[11].split(' ')[1]} ${lstDatosFrm[11].split(' ')[2]}';
              }
            }          
            */
          }
        }
      }
    }

    if (tipoCaptura == 'CAMARA') {
      Map<String, String> datos = extraerDatos(text);
      String total = datos["Monto"] ?? '';
      String comp = datos["Recibo"] ?? '';
      String compFin = '${comp.split(' ')[0]} ${comp.split(' ')[1]}';
      amountDepController.text = total;
      compDepController.text = compFin;

      gnrBloc.setCargando(false);
      gnrBloc.setLevantaModal(false);
      //String tst = '';
    }

    setState(() {
      extractedText = text;
    });

    textRecognizer.close();
  }

  Map<String, String> extraerDatos(String texto) {
    //List<String> lstDatosFrm = texto.split('\n');

    Map<String, String> datos = {};

    // Buscar número de cuenta
    final cuentaRegExp = RegExp(r'Cuenta.*?(\d{6,})');
    final cuentaMatch = cuentaRegExp.firstMatch(texto);
    if (cuentaMatch != null) datos['Cuenta'] = cuentaMatch.group(1)!;

    // Buscar nombre
    final nombreRegExp = RegExp(r'CARRASCO.*', caseSensitive: false);
    final nombreMatch = nombreRegExp.firstMatch(texto);
    if (nombreMatch != null) datos['Nombre'] = nombreMatch.group(0)!;

    // Buscar fecha y hora
    final fechaRegExp = RegExp(r'\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}');
    final fechaMatch = fechaRegExp.firstMatch(texto);
    if (fechaMatch != null) datos['Fecha'] = fechaMatch.group(0)!;

    // Buscar monto total
    final totalRegExp = RegExp(r'TOTAL\s+(\d+,\d+|\d+\.\d+|\d+)');
    final totalMatch = totalRegExp.firstMatch(texto);
    if (totalMatch != null) datos['Monto'] = totalMatch.group(1)!;
/*
    // Buscar recibo
    final reciboRegExp = RegExp(r'BAP.*', caseSensitive: false);
    final reciboMatch = reciboRegExp.firstMatch(texto);
    if (reciboMatch != null) datos['Recibo'] = reciboMatch.group(0)!;
    */

    // Buscar la cadena completa: valor antes + BAP1 + fecha
    final bapRegExp =
        RegExp(r'(\S+\s+BAP1\s+\d{4}/\d{2}/\d{2}\s+\d{2}:\d{2}:\d{2})');
    final bapMatch = bapRegExp.firstMatch(texto);

    if (bapMatch != null) {
      datos['Recibo'] = bapMatch.group(1)!;
    }

    return datos;
  }
}
