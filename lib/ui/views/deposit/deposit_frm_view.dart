import 'package:cve_app/ui/bloc/bloc.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {

    final gnrBloc = Provider.of<GenericBloc>(context);
    final size = MediaQuery.of(context).size;
    contextPrincipalGen = context;

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: const Text('Adjuntar Archivo'),
              ),
              if (_fileName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Archivo seleccionado: $_fileName',
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el título';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _observationsController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Observaciones',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _savePayment,                
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.green
                ),
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    width: size.width,
                    //height: size.height * 0.08,
                    alignment: Alignment.center,
                    //padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.15,
                          //height: size.height * 0.045,
                          child: const Icon(Icons.save, color: Colors.white,)
                        ),
                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.25,
                          //height: size.height * 0.08,
                          child: const Text('Guardar', style: TextStyle(color: Colors.white),)),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.025,
              ),

              ElevatedButton(
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.red
                ),
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    width: size.width,
                    //height: size.height * 0.08,
                    alignment: Alignment.center,
                    //padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.15,
                          //height: size.height * 0.045,
                          child: const Icon(Icons.close, color: Colors.white,)
                        ),
                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.25,
                          //height: size.height * 0.08,
                          child: const Text('Salir', style: TextStyle(color: Colors.white),)),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      );
  }
}
