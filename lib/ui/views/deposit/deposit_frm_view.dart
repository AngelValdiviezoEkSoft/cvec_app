import 'dart:io';

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
//import 'package:image_cropper/image_cropper.dart';

  bool showHolder = false;

  String holderName = '';

  List<BankAccount> lstBankAccount = [];
  bool btnGuardar = false;
  bool btnGuardarFoto = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController compController = TextEditingController();
  TextEditingController concController = TextEditingController();
  TextEditingController observationsController = TextEditingController();
  String rutaPagoAdj = '';
  bool validandoFoto = false;
  String selectedValueBanco = 'Produbanco';
  String selectedValueCliente = 'Tito Salazar';

  String fechaHoraEscogida = '';
  String fechaHoraEscogidaMuestra = '';

class DepositFrmView extends StatefulWidget {
  const DepositFrmView(Key? key) : super(key: key);

  @override
  DepositFrmViewState createState() => DepositFrmViewState();
}

class DepositFrmViewState extends State<DepositFrmView> {
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

  @override
  void initState() {
    super.initState();

    btnGuardar = false;

    concController = TextEditingController ();
    compController = TextEditingController ();
    amountController = TextEditingController ();
    observationsController = TextEditingController ();

    fechaHoraEscogida = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    fechaHoraEscogidaMuestra = DateFormat('yyyy-MM-dd').format(DateTime.now());

    rutaPagoAdj = '';

    showHolder = false;

    holderName = '';

    final gnrBloc = Provider.of<GenericBloc>(context, listen: false);
    gnrBloc.setLevantaModal(false);
    gnrBloc.setCargando(false);

    lstBankAccount = [];
  }

  @override
  Widget build(BuildContext context) {
    final gnrBloc = Provider.of<GenericBloc>(context);
    final size = MediaQuery.of(context).size;
    contextPrincipalGen = context;
    ColorsApp objColorsApp = ColorsApp();

    return BlocBuilder<GenericBloc, GenericState>(
      builder: (context, state) {

        return FutureBuilder(
          future: BankAccountService().getBankAccounts(),
          builder: (context, snapshot) {
        
            if(snapshot.hasData){
              lstBankAccount = snapshot.data as List<BankAccount>;

              if(lstBankAccount.isNotEmpty){

                for(int i = 0; i < lstBankAccount.length; i++){
                  cmbBancoCve.add(lstBankAccount[i].bankName);
                }

                selectedValueBanco = lstBankAccount[0].bankName;
                holderName = lstBankAccount[0].bankAccountHolder;
              }
              
            }

            return Padding(
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
                        child: Text(locGen!.photoPaymentReceiptLbl),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      if (rutaPagoAdj.isEmpty && !state.levantaModal)
                        Container(
                          width: size.width * 0.96,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: size.width * 0.25,
                            height: size.height * 0.11,
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
        
                      if (rutaPagoAdj.isNotEmpty && !state.levantaModal)
                        Container(
                          width: size.width * 0.96,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: size.width * 0.25,
                              height: size.height * 0.11,
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
                                  gnrBloc.setLevantaModal(true);
                                  mostrarOpciones(context, size);
                                },
                              )),
                        ),
        
                      SizedBox(
                        height: size.height * 0.025,
                      ),

                      TextFormField(
                        controller: amountController,
                        inputFormatters: [currencyFormatter],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            labelText: locGen!.amountLbl,
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
                            prefixIcon: const Icon(Icons.monetization_on_outlined),
                            hintText: "0.00",
                            suffixIcon: IconButton(
                              onPressed: () {
                                amountController.text = '';
        
                                if(observationsController.text.isEmpty || amountController.text.isEmpty 
                                  || compController.text.isEmpty || concController.text.isEmpty){
                                  setState(() {
                                    btnGuardar = false;
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
                                color: Colors.black,
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
                          if(value.isNotEmpty && compController.text.isNotEmpty 
                          && concController.text.isNotEmpty && observationsController.text.isNotEmpty){
                            setState(() {
                              btnGuardar = true;
                            });
                          }
                        },
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      
                      TextFormField(
                        controller: compController,
                        decoration: InputDecoration(
                            labelText: locGen!.receiptNumberLbl,
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
                                compController.text = '';
        
                                if(observationsController.text.isEmpty || amountController.text.isEmpty 
                                  || compController.text.isEmpty || concController.text.isEmpty){
                                  setState(() {
                                    btnGuardar = false;
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
                                color: Colors.black,
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el título';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if(value.isNotEmpty && amountController.text.isNotEmpty 
                          && concController.text.isNotEmpty && observationsController.text.isNotEmpty){
                            setState(() {
                              btnGuardar = true;
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
                                Text(fechaHoraEscogida),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      
                      TextFormField(
                        controller: concController,
                        decoration: InputDecoration(
                            labelText: locGen!.conceptLbl,
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
                                concController.text = '';
        
                                if(observationsController.text.isEmpty || amountController.text.isEmpty 
                                  || compController.text.isEmpty || concController.text.isEmpty){
                                  setState(() {
                                    btnGuardar = false;
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
                                color: Colors.black,
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
                          if(value.isNotEmpty && amountController.text.isNotEmpty 
                          && compController.text.isNotEmpty && observationsController.text.isNotEmpty){
                            setState(() {
                              btnGuardar = true;
                            });
                          }
                        },
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      
                      TextFormField(
                        controller: observationsController,
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelText: locGen!.notesLbl,
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
                                observationsController.text = '';
                                if(observationsController.text.isEmpty || amountController.text.isEmpty 
                                  || compController.text.isEmpty || concController.text.isEmpty){
                                  setState(() {
                                    btnGuardar = false;
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
                                color: Colors.black,
                              ),
                            )),
                        onChanged: (value) {
                          if(value.isNotEmpty && amountController.text.isNotEmpty 
                          && compController.text.isNotEmpty && concController.text.isNotEmpty){
                            setState(() {
                              btnGuardar = true;
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
                        height: size.height * 0.028,
                        color: Colors.transparent,
                        child: Text(locGen!.paymentLbl),
                      ),
                      
                      Container(
                        width: size.width * 0.96,
                        height: size.height * 0.07,
                        alignment: Alignment.center,
                        //color: Colors.transparent,
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Color de fondo (opcional)
                          border: Border.all(
                            color: Colors.black54, // Color del borde
                            width: 0.5, // Grosor del borde
                          ),
                          borderRadius: BorderRadius.circular(8), // Bordes redondeados (opcional)
                        ),
                        child: DropdownButton<String>(
                          value: selectedValueBanco,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValueBanco = newValue!;

                              showHolder = true;

                              for(int i = 0; i < lstBankAccount.length; i++){
                                if(lstBankAccount[i].bankName == selectedValueBanco){
                                  holderName = lstBankAccount[i].bankAccountHolder;
                                }
                              }

                            });
                          },
                          items: cmbBancoCve.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(fontSize: 11),),
                            );
                          }).toList(),
                        ),
                      ),
                      
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      
                      if(showHolder)
                      Container(
                        width: size.width * 0.96,
                        height: size.height * 0.028,
                        color: Colors.transparent,
                        child: Text(locGen!.holderLbl),
                      ),

                      if(showHolder)
                      Container(
                        width: size.width * 0.96,
                        height: size.height * 0.028,
                        color: Colors.transparent,
                        child: Text(holderName),
                      ),

                      /*
                      Container(
                        width: size.width * 0.96,
                        height: size.height * 0.07,
                        alignment: Alignment.center,
                        //color: Colors.transparent,
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Color de fondo (opcional)
                          border: Border.all(
                            color: Colors.black54, // Color del borde
                            width: 0.5, // Grosor del borde
                          ),
                          borderRadius: BorderRadius.circular(
                              8), // Bordes redondeados (opcional)
                        ),
                        child: DropdownButton<String>(
                          value: selectedValueCliente,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValueCliente = newValue!;
                            });
                          },
                          items: cmbBancoClient.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      */
                      
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
        
                            if(amountController.text.isEmpty){
                              btnGuardar = false;                          
                            }
        
                            if(compController.text.isEmpty){
                              btnGuardar = false;                          
                            }
        
                            if(concController.text.isEmpty){
                              btnGuardar = false;                          
                            }
        
                            if(observationsController.text.isEmpty){
                              btnGuardar = false;                          
                            }
        
                            setState(() {
                              return;
                            });
        
                            if(btnGuardar){
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
                                          const Text(
                                            '¿Confirmas que todos los datos ingresados son correctos?',
                                            style: TextStyle(
                                                fontSize: 16,
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
                                            Text('Valor del pago: ${amountController.text}'),
                                            Text('Número de comprobante: ${compController.text}'),
                                            Text('Fecha: $fechaHoraEscogidaMuestra'),
                                            Text('Concepto: ${concController.text}'),
                                            Text('He realizado el pago en: $selectedValueBanco'),
                                            Text('Titular: $selectedValueCliente'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              /*
                                              // Aquí podrías enviar la información al backend o procesarla.
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: const Text(
                                                        'Pago guardado exitosamente')),
                                              );
                                              */
        
                                              gnrBloc.setShowViewAccountStatementEvent(false);
                                              gnrBloc.setShowViewDebts(false);
                                              gnrBloc.setShowViewPrintRecipts(false);
                                              gnrBloc.setShowViewReservetions(false);
                                              gnrBloc.setShowViewSendDeposits(true);
                                              gnrBloc.setShowViewWebSite(false);
                                              gnrBloc.setShowViewFrmDeposit(false);
        
                                              // Limpiar formulario (opcional)
                                              /*
                                              amountController.clear();
                                              compController.clear();
                                              observationsController.clear();
                                              */
        
                                              Navigator.of(context).pop();
        
                                              context.push(objRutas.rutaConfDepositScreen);
        
                                              setState(() {
                                                //_pickedFile = null;
                                                //_fileName = null;
                                              });
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
                              side: BorderSide(color: btnGuardar && btnGuardarFoto ? Colors.green : Colors.grey, width: 2),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                          child: Text(
                            locGen!.saveLbl,
                            style: TextStyle( color: btnGuardar && btnGuardarFoto ? Colors.green : Colors.grey, fontWeight: FontWeight.bold),
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
            );
          },
        );
      }
    );
  }

  void openDatePicker(BuildContext context) {
    picker.DatePicker.showDateTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      setState(() {
        fechaHoraEscogida = DateFormat('yyyy-MM-dd HH:mm').format(date);
        fechaHoraEscogidaMuestra = DateFormat('yyyy-MM-dd').format(date);
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
                if(rutaPagoAdj.isEmpty)
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
                if(rutaPagoAdj.isNotEmpty)
                Container(
                  width: size.width * 0.68,
                  height: size.height * 0.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(rutaPagoAdj)),
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
                  //child: File(rutaPagoAdj)
                ),
                /*
                BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(rutaPagoAdj)),
                                    fit: BoxFit.cover,
                                  ),                              
                                )
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
                      ListTile(
                        leading: const Icon(Icons.delete_outline, color: Colors.white),
                        title: const Text('Eliminar foto', style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          Navigator.pop(context);
                          rutaPagoAdj = '';
                        },
                      ),
                      if(rutaPagoAdj.isNotEmpty)
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
                              btnGuardarFoto = true;

                              readTextFromImage(file, 'CAMARA');

                              rutaPagoAdj = pickedFile.path;

                              //validandoFoto = false;
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
                              btnGuardarFoto = true;

                              readTextFromImage(file, 'GALERIA');

                              rutaPagoAdj = pickedFile.path;

                              //validandoFoto = false;

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

    amountController.text = '';
    compController.text = '';

    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();

    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    List<String> lstDatosFrm = text.split('\n');

    if (tipoCaptura == 'GALERIA') {
      //Map<String, String> datos = extraerDatos(text);
      if (lstDatosFrm.isNotEmpty) {
        try {
          amountController.text = lstDatosFrm[3].split('\$')[1];
          compController.text = lstDatosFrm[15].split('No.')[1];

          gnrBloc.setCargando(false);
          gnrBloc.setLevantaModal(false);
          textRecognizer.close();
          return;
        } catch (_) {
          try {
            if (lstDatosFrm[4].toUpperCase().contains('\$')) {
              String numComp = lstDatosFrm[8].replaceAll(RegExp(r'[^0-9]'), '');

              amountController.text = lstDatosFrm[4].split('\$')[1];
              compController.text = numComp;

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
            if (lstDatosFrm[3].toUpperCase().contains('MONTO')) {
              String numComp = lstDatosFrm[1].replaceAll(RegExp(r'[^0-9]'), '');

              amountController.text = lstDatosFrm[3].split('\$')[1];
              compController.text = numComp;

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;              
            }
            if (lstDatosFrm[3].toUpperCase().contains('TOTAL')) {
              amountController.text = lstDatosFrm[4];
              compController.text = '${lstDatosFrm[2].split(' ')[0]} ${lstDatosFrm[2].split(' ')[1]} ${lstDatosFrm[2].split(' ')[2]}';

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
            if (lstDatosFrm[12].toUpperCase().contains('USD')) {
              String numComp = lstDatosFrm[6].replaceAll(RegExp(r'[^0-9]'), '');

              amountController.text = lstDatosFrm[12].split('USD')[0];
              compController.text = numComp;
              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
            if (lstDatosFrm[11].toUpperCase().contains('USD')) {
              var montoStr = lstDatosFrm[11].split('USD')[0];
              double.parse(montoStr);
              amountController.text = montoStr.trim();
              compController.text = lstDatosFrm[2];

              gnrBloc.setCargando(false);
              gnrBloc.setLevantaModal(false);
              textRecognizer.close();
              return;
            }
          } catch (_) {
            //if(lstDatosFrm.length == 22){
            amountController.text = lstDatosFrm[10];
            compController.text = lstDatosFrm[9].split('SECU: ')[1];
            gnrBloc.setCargando(false);
            gnrBloc.setLevantaModal(false);
            textRecognizer.close();
            return;
            /*
            }
            
            else{
              

              if(lstDatosFrm[23].toUpperCase().contains('WONTO') || lstDatosFrm[23].toUpperCase().contains('MONTO')){
                amountController.text = lstDatosFrm[23].split(' ')[2];
                compController.text = lstDatosFrm[41].split('SECU: ')[1];
              }
              if(lstDatosFrm[12].toUpperCase().contains('BAP')){
                amountController.text = lstDatosFrm[13];
                compController.text = '${lstDatosFrm[12].split(' ')[0]} ${lstDatosFrm[12].split(' ')[1]} ${lstDatosFrm[12].split(' ')[2]}';
              }
              if(lstDatosFrm[13].toUpperCase().contains('BAP')){
                amountController.text = lstDatosFrm[14];
                compController.text = '${lstDatosFrm[13].split(' ')[0]} ${lstDatosFrm[13].split(' ')[1]} ${lstDatosFrm[13].split(' ')[2]}';
              }
              if(lstDatosFrm[11].toUpperCase().contains('BAP')){
                amountController.text = lstDatosFrm[13];
                compController.text = '${lstDatosFrm[11].split(' ')[0]} ${lstDatosFrm[11].split(' ')[1]} ${lstDatosFrm[11].split(' ')[2]}';
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
      amountController.text = total;
      compController.text = compFin;

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
