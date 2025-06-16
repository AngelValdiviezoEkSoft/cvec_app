import 'dart:io';

import 'package:cve_app/ui/ui.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
//import 'package:image_cropper/image_cropper.dart';

class DepositFrmView extends StatefulWidget {

  const DepositFrmView(Key? key) : super (key: key);

  @override
  DepositFrmViewState createState() => DepositFrmViewState();
}

class DepositFrmViewState extends State<DepositFrmView> {
  final _formKey = GlobalKey<FormState>();  

  String? _fileName;
  PlatformFile? _pickedFile;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  String rutaPagoAdj = '';

  String fechaHoraEscogida = '';

  String selectedValueBanco = 'Produbanco';
  String selectedValueCliente = 'Tito Salazar';

  final List<String> cmbBancoCve = ['Produbanco', 'Banco de Guayaquil'];
  final List<String> cmbBancoClient = ['Narboni', 'Tito Salazar'];

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
        _pickedFile = result.files.first;
        _fileName = _pickedFile!.name;
      });
    }

    pickFile(result);
  }

  void _savePayment() {
    if (_formKey.currentState!.validate()) {
      // Aquí podrías enviar la información al backend o procesarla.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pago guardado exitosamente')),
      );
      final gnrBloc = Provider.of<GenericBloc>(contextPrincipalGen!);

      gnrBloc.setShowViewAccountStatementEvent(false);
      gnrBloc.setShowViewDebts(false);
      gnrBloc.setShowViewPrintRecipts(false);
      gnrBloc.setShowViewReservetions(false);
      gnrBloc.setShowViewSendDeposits(false);
      gnrBloc.setShowViewWebSite(false);
      gnrBloc.setShowViewFrmDeposit(true);

      // Limpiar formulario (opcional)
      _amountController.clear();
      _titleController.clear();
      _observationsController.clear();
      setState(() {
        _pickedFile = null;
        _fileName = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fechaHoraEscogida = '${DateTime.now()} ${DateTime.now().hour}';
    rutaPagoAdj = '';
  }

  @override
  Widget build(BuildContext context) {

    final gnrBloc = Provider.of<GenericBloc>(context);
    final size = MediaQuery.of(context).size;
    contextPrincipalGen = context;

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /*
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Adjuntar Archivo'),
                ),
                */

                Container(
                  width: size.width * 0.96,
                  height: size.height * 0.028,
                  color: Colors.transparent,
                  child: const Text('Foto recibo de pago: '),
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
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                        color: Colors.grey[400], // Color de fondo
                        borderRadius: BorderRadius.circular(12), // Bordes redondeados
                      ),
                      child: GestureDetector(
                        onTap: () {
                          mostrarOpciones(context);
                        },
                        child: const Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.white)
                    ),
                  ),
                ),
            
                if (_fileName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Archivo seleccionado: $_fileName',
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ),
                
                if (_fileName != null && selectedFile != null)
                  FileViewer(file: selectedFile!),
            
                SizedBox(
                  height: size.height * 0.025,
                ),
            
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Monto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.monetization_on_outlined)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el monto';
                    }
                    return null;
                  },
                ),
            
                SizedBox(
                  height: size.height * 0.025,
                ),

                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Número de comprobante:',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el título';
                    }
                    return null;
                  },
                ),
                
                
                SizedBox(
                  height: size.height * 0.025,
                ),
              
                Container(
                  width: size.width * 0.96,
                  height: size.height * 0.028,
                  color: Colors.transparent,
                  child: const Text('Fecha: '),
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
                          const Icon(Icons.calendar_month_outlined, color: Colors.blue,),
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
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Concepto',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el título';
                    }
                    return null;
                  },
                ),
                
                SizedBox(
                  height: size.height * 0.025,
                ),
            
                TextFormField(
                  controller: _observationsController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Notas',
                    border: OutlineInputBorder(),
                  ),
                ),
                
                SizedBox(
                  height: size.height * 0.025,
                ),
            
                Container(
                  width: size.width * 0.96,
                  height: size.height * 0.028,
                  color: Colors.transparent,
                  child: const Text('He realizado el pago en: '),
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
                      width: 0.5,         // Grosor del borde
                    ),
                    borderRadius: BorderRadius.circular(8), // Bordes redondeados (opcional)
                  ),
                  child: DropdownButton<String>(
                    //hint: const Text('He realizado el pago en'),
                    value: selectedValueBanco,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValueBanco = newValue!;
                      });
                    },
                    items: cmbBancoCve.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
            
                SizedBox(
                  height: size.height * 0.025,
                ),
            
                Container(
                  width: size.width * 0.96,
                  height: size.height * 0.028,
                  color: Colors.transparent,
                  child: const Text('Titular: '),
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
                      width: 0.5,         // Grosor del borde
                    ),
                    borderRadius: BorderRadius.circular(8), // Bordes redondeados (opcional)
                  ),
                  child: DropdownButton<String>(
                    //hint: const Text('He realizado el pago en'),
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
            
                SizedBox(
                  height: size.height * 0.025,
                ),
            
                Container(
                  width: size.width * 0.96,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _savePayment,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.green, width: 2),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.symmetric(horizontal: 147, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.red, width: 2),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            
              ],
            ),
          ),
        ),
      );
  }

  
  void openDatePicker(BuildContext context) {
  picker.DatePicker.showDateTimePicker(
    context,
    showTitleActions: true, 
    onChanged: (date) {
      setState(() {
        fechaHoraEscogida = '$date';
      });
    },
    currentTime: DateTime.now()
  );
}

  void mostrarOpciones(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Tomar foto'),
              onTap: () async {
                Navigator.pop(context);
                
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                                        
                try {
                  if (pickedFile != null) {
                    /*
                    final croppedFile = await ImageCropper().cropImage(
                      sourcePath: pickedFile.path,
                      compressFormat: ImageCompressFormat.png,
                      compressQuality: 100,                                        
                    );
                    */
                    //if (pickedFile != null) {                                        
      
                      rutaPagoAdj = pickedFile.path;
                      
                      //validandoFoto = false;
                      
                      setState(() {});
                    
                    //}
                  }
                } catch(_) {
                  
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Seleccionar foto'),
              onTap: () async {
                Navigator.pop(context);
                
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        
                try {
                  if (pickedFile != null) {
                    /*
                    final croppedFile = await ImageCropper().cropImage(
                      sourcePath: pickedFile.path,
                      compressFormat: ImageCompressFormat.png,
                      compressQuality: 100,                                        
                    );
                    if (croppedFile != null) {    
                      */                                    
      
                      rutaPagoAdj = pickedFile.path;
                      
                      //validandoFoto = false;
                      
                      setState(() {});
                    
                    //}
                  }
                } catch(_) {
                  
                }
              },
            ),
          ],
        );
      },
    );
  }
}
