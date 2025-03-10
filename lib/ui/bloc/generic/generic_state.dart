part of 'generic_bloc.dart';

class GenericState extends Equatable {

  final storage = const FlutterSecureStorage();
  final int positionMenu;
  final int positionFormaPago;
  final double coordenadasMapa;
  final double radioMarcacion;
  final String formaPago;
  final String localidadId;
  final String idFormaPago;
  final double heightModalPlanAct;

  const GenericState(
    {
      positionMenu = 0,
      positionFormaPago = 0,
      coordenadasMapa = 0,
      radioMarcacion = 0,
      formaPago = 'C',
      localidadId = '',
      idFormaPago = '',
      heightModalPlanAct = 0.65
    } 
  ) : positionMenu = positionMenu ?? 0,
      positionFormaPago = positionFormaPago ?? 0,
      coordenadasMapa = coordenadasMapa ?? 0,
      radioMarcacion = radioMarcacion ?? 0,
      formaPago = formaPago ?? 'C',
      localidadId = localidadId ?? '',
      idFormaPago = idFormaPago ?? '',
      heightModalPlanAct = heightModalPlanAct ?? 0.65;
  

  GenericState copyWith({
    int? positionMenu,
    int? positionFormaPago,
    double? coordenadasMapa,
    double? radioMarcacion,
    String? formaPago,
    String? localidadId,
    String? idFormaPago,
    double? heightModalPlanAct
  }) 
  => GenericState(
    positionMenu: positionMenu ?? this.positionMenu,
    positionFormaPago: positionFormaPago ?? this.positionFormaPago,
    coordenadasMapa: coordenadasMapa ?? this.coordenadasMapa,
    radioMarcacion: radioMarcacion ?? this.radioMarcacion,
    formaPago: formaPago ?? this.formaPago,
    localidadId: localidadId ?? this.localidadId,
    idFormaPago: idFormaPago ?? this.idFormaPago,
    heightModalPlanAct: heightModalPlanAct ?? this.heightModalPlanAct
  );


  @override
  List<Object> get props => [positionMenu,positionFormaPago,coordenadasMapa,radioMarcacion,formaPago,localidadId,idFormaPago, heightModalPlanAct];

  Future<String> readPrincipalPage() async {

    try{
      //final registraProspecto = await storage.read(key: 'registraProspecto') ?? '';
      
      //var connectivityResult = await ValidationsUtils().validaInternet();

      //String rspRegistro = '';

      final resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);
      final objTmp = data['result'];
      final lstFinal = objTmp['allowed_companies'];
      //final objPermisosTmp = objTmp['done_permissions'];

      Map<String, dynamic> dataTmp = json.decode(json.encode(lstFinal));

      List<String> lstRsp = [];

      dataTmp.forEach((key, value) {
        if(key == objTmp['current_company'].toString()){
          lstRsp.add(value['name']);
        }
      });

      dataTmp.forEach((key, value) {
        if(key != objTmp['current_company'].toString()){                  
          lstRsp.add(value['name']);
        }
      });

      String respCmbLst = '';

      //respCmbLst = '$rspRegistro---${json.encode(lstRsp)}---$jsonString---${objPermisos.mainMenu.cardSales}---${objPermisos.mainMenu.cardCollection}';

      return respCmbLst;
    }
    catch(ex){
      return '';
    }
  }

  Future<String> waitCarga() async {
    
    return await Future.delayed(
      const Duration(milliseconds: 2500), 
        () => 'ok'
      ); 
  }
  
  readCombosGen() async {
    
    String cmbCamp = await storage.read(key: 'cmbCampania') ?? '';
    String cmbOrigen = await storage.read(key: 'cmbOrigen') ?? '';
    String cmbMedia = await storage.read(key: 'cmbMedia') ?? '';
    String cmbAct = await storage.read(key: 'cmbActividades') ?? '';
    String cmbPais = await storage.read(key: 'cmbPaises') ?? '';
    String cmbLstAct = await storage.read(key: 'cmbLstActividades') ?? '';

    return "$cmbCamp---$cmbOrigen---$cmbMedia---$cmbAct---$cmbPais---$cmbLstAct";
  }

  readDatosPerfil() async {    
    String objLogin = await storage.read(key: 'RespuestaLogin') ?? '';

    return objLogin;
  }

  
  Future<String> lstProspectos() async {
    var rsp = await storage.read(key: 'RespuestaProspectos') ?? '';
    //print('Lst Prsp: $rsp');
    return rsp;
  }

  Future<String> lstClientes() async {
    var rsp = await storage.read(key: 'RespuestaClientes') ?? '';    
    return rsp;
  }
/*  
  Map<String, dynamic> serializeItemBotonMenu(ItemBoton item) {
    return {
      'tipoNotificacion': item.tipoNotificacion,
      'idSolicitud': item.idSolicitud,
      'idNotificacionGen': item.idNotificacionGen,
      'ordenNot': item.ordenNot,
      'icon': item.icon.codePoint,
      'mensajeNotificacion': item.mensajeNotificacion,
      'mensaje2': item.mensaje2,
      'fechaNotificacion': item.fechaNotificacion,
      'tiempoDesde': item.tiempoDesde,
      'color1': item.color1.value,
      'color2': item.color2.value,
      'requiereAccion': item.requiereAccion,
      'esRelevante': item.esRelevante,
      'estadoLeido': item.estadoLeido,
      'numIdenti': item.numIdenti,
      'iconoNotificacion': item.iconoNotificacion,
      'rutaImagen': item.rutaImagen,
      'idTransaccion': item.idTransaccion,
      'rutaNavegacion': item.rutaNavegacion,
    };
  }

  String serializeItemBotonMenuList(List<ItemBoton> items) {    
    final serializedList = items.map((item) => serializeItemBotonMenu(item)).toList();

    return jsonEncode(serializedList);
  }

  List<ItemBoton> deserializeItemBotonMenuList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => deserializeItemBotonMenu(json)).toList();
  }

  ItemBoton deserializeItemBotonMenu(Map<String, dynamic> json) {
    IconData iconData;
    
    try{
      iconData = IconData(
        json['icon'],
        fontFamily: 'MaterialIcons',
      );
    }
    catch(_){
      iconData = Icons.abc;
    }
    
    return ItemBoton(
      json['tipoNotificacion'] ?? '',
      json['idSolicitud'] ?? '',
      json['idNotificacionGen'] ?? '',
      json['ordenNot'] ?? 0,
      iconData,
      json['mensajeNotificacion'] ?? '',
      json['mensaje2'] ?? '',
      json['fechaNotificacion'] ?? '',
      json['tiempoDesde'] ?? '',
      Color(json['color1'] ?? 0),
      Color(json['color2'] ?? 0),
      json['requiereAccion'] ?? false,
      json['esRelevante'] ?? false,
      json['estadoLeido'] ?? '',
      json['numIdenti'] ?? '',
      json['iconoNotificacion'] ?? '',
      json['rutaImagen'] ?? '',
      json['idTransaccion'] ?? '',
      json['rutaNavegacion'] ?? '',
      () {},
    );
  
  }
*/
}

