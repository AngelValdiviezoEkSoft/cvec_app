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

  final bool viewAccountStatement;
  final bool viewViewDebts;
  final bool viewSendDeposits;
  final bool viewFrmDeposits;
  final bool viewWebSite;
  final bool viewPrintReceipts;
  final bool viewViewReservations;
  final bool cargando;
  final bool levantaModal;

  const GenericState(
    {
      positionMenu = 0,
      positionFormaPago = 0,
      coordenadasMapa = 0,
      radioMarcacion = 0,
      formaPago = 'C',
      localidadId = '',
      idFormaPago = '',
      heightModalPlanAct = 0.65,
      viewAccountStatement = false,
      viewViewDebts = false,
      viewSendDeposits = false,
      viewWebSite = false,
      viewPrintReceipts = false,
      viewViewReservations = false,
      viewFrmDeposits = false,
      cargando = false,
      levantaModal = false
    } 
  ) : positionMenu = positionMenu ?? 0,
      positionFormaPago = positionFormaPago ?? 0,
      coordenadasMapa = coordenadasMapa ?? 0,
      radioMarcacion = radioMarcacion ?? 0,
      formaPago = formaPago ?? 'C',
      localidadId = localidadId ?? '',
      idFormaPago = idFormaPago ?? '',
      heightModalPlanAct = heightModalPlanAct ?? 0.65,
      viewAccountStatement = viewAccountStatement ?? false,
      viewViewDebts = viewViewDebts ?? false,
      viewSendDeposits = viewSendDeposits ?? false,
      viewWebSite = viewWebSite ?? false,
      viewPrintReceipts = viewPrintReceipts ?? false,
      viewViewReservations = viewViewReservations ?? false,
      viewFrmDeposits = viewFrmDeposits ?? false,
      cargando = cargando ?? false,
      levantaModal = levantaModal ?? false;
  

  GenericState copyWith({
    int? positionMenu,
    int? positionFormaPago,
    double? coordenadasMapa,
    double? radioMarcacion,
    String? formaPago,
    String? localidadId,
    String? idFormaPago,
    double? heightModalPlanAct,
    bool? viewAccountStatement,
    bool? viewViewDebts,
    bool? viewSendDeposits,
    bool? viewPrintReceipts,
    bool? viewViewReservations,
    bool? viewWebSite,
    bool? viewFrmDeposits,
    bool? cargando,
    bool? levantaModal
  }) 
  => GenericState(
    viewViewReservations: viewViewReservations ?? this.viewViewReservations,
    viewPrintReceipts: viewPrintReceipts ?? this.viewPrintReceipts,
    viewSendDeposits: viewSendDeposits ?? this.viewSendDeposits,
    viewWebSite: viewWebSite ?? this.viewWebSite,
    viewViewDebts: viewViewDebts ?? this.viewViewDebts,
    viewAccountStatement: viewAccountStatement ?? this.viewAccountStatement,
    positionMenu: positionMenu ?? this.positionMenu,
    positionFormaPago: positionFormaPago ?? this.positionFormaPago,
    coordenadasMapa: coordenadasMapa ?? this.coordenadasMapa,
    radioMarcacion: radioMarcacion ?? this.radioMarcacion,
    formaPago: formaPago ?? this.formaPago,
    localidadId: localidadId ?? this.localidadId,
    idFormaPago: idFormaPago ?? this.idFormaPago,
    heightModalPlanAct: heightModalPlanAct ?? this.heightModalPlanAct,
    viewFrmDeposits: viewFrmDeposits ?? this.viewFrmDeposits,
    cargando: cargando ?? this.cargando,
    levantaModal: levantaModal ?? this.levantaModal
  );


  @override
  List<Object> get props => [viewAccountStatement,viewViewDebts,viewSendDeposits, viewWebSite,viewPrintReceipts,viewViewReservations,positionMenu,positionFormaPago,coordenadasMapa,radioMarcacion,formaPago,localidadId,idFormaPago, heightModalPlanAct,viewFrmDeposits,cargando,levantaModal];

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

  Future<String> getEstadoCuentas() async {

    try{
      
      final items = <ItemBoton>[
        //if(objPermisos.mainMenu.itemListLeads)
        ItemBoton('','','',1, Icons.group_add, 'Contrato', 'Cliente 1','','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
          RoutersApp().routPdfView, 
          () {
            
          }
        ),
        
        ItemBoton('','','',2, Icons.groups, 'Contrato', 'Cliente 2','','', Colors.white, Colors.white,false,false,'','','icTramApr.png','icTramAprTrans.png','',
          RoutersApp().routPdfView, 
          () {
            
          }
        ),
        
        ItemBoton('','','',3, Icons.calendar_month, 'Contrato', 'Cliente 3','','', Colors.white, Colors.white,false,false,'','','icTramProc.png','icTramProcTrans.png','',
          RoutersApp().routPdfView, 
          () {}
        ),        
      ]; 

      final jsonString = serializeItemBotonMenuList(items);

      return jsonString;
    }
    catch(ex){
      return '';
    }
  }

  Future<String> getDebitos() async {

    try{
      
      final items = <ItemBoton>[
        //if(objPermisos.mainMenu.itemListLeads)
        ItemBoton('Contrato A','Plan Identidad','',1, Icons.group_add, 'Cuota 06/12', 'Cliente 1','05 Jun 2025','\$31.00', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
          RoutersApp().routPdfView, 
          () {
            
          }
        ),
        
        ItemBoton('Contrato B','Plan Contrato','',2, Icons.groups, 'Cuota 01/03', 'Cliente 2','08 Ago 2024','\$50.00', Colors.white, Colors.white,false,false,'','','icTramApr.png','icTramAprTrans.png','',
          RoutersApp().routPdfView, 
          () {
            
          }
        ),
        
        ItemBoton('Contrato C','Plan terreno','',3, Icons.calendar_month, 'Cuota 02/09', 'Cliente 3','20 Abr 2020','\$259.00', Colors.white, Colors.white,false,false,'','','icTramProc.png','icTramProcTrans.png','',
          RoutersApp().routPdfView, 
          () {}
        ),        
      ]; 

      final jsonString = serializeItemBotonMenuList(items);

      return jsonString;
    }
    catch(ex){
      return '';
    }
  }

  Future<String> getRecibos() async {

    try{
      /*
      final resp = await storage.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);
      */

      //Map<String, dynamic> dataTmp = json.decode(json.encode(lstFinal));

      final items = <ItemBoton>[
        //if(objPermisos.mainMenu.itemListLeads)
        ItemBoton('','','',1, Icons.group_add, 'Recibo 1', 'Detalle del Recibo 1','','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
          RoutersApp().routPrintReceiptView,
          () {
            
          }
        ),
        
        ItemBoton('','','',2, Icons.groups, 'Recibo 2', 'Detalle del Recibo 2','','', Colors.white, Colors.white,false,false,'','','icTramApr.png','icTramAprTrans.png','',
          RoutersApp().routPrintReceiptView, 
          () {
            
          }
        ),
        
        ItemBoton('','','',3, Icons.calendar_month, 'Recibo 3', 'Detalle del Recibo 3','','', Colors.white, Colors.white,false,false,'','','icTramProc.png','icTramProcTrans.png','',
          RoutersApp().routPrintReceiptView, 
          () {}
        ),        
      ]; 

      final jsonString = serializeItemBotonMenuList(items);

      return jsonString;
    }
    catch(ex){
      return '';
    }
  }

  Future<String> getReservation() async {

    try{
      List<Booking>? rsp = await ReservationsService().getReservations();

      final items = <ItemBoton>[];

      if(rsp != null && rsp.isNotEmpty){
        for(int i = 0; i < rsp.length; i++){
          items.add(
            ItemBoton('','','',rsp[i].id, Icons.group_add, rsp[i].name, rsp[i].tradeNameHotel, rsp[i].roomInclude,'', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
              RoutersApp().routReservationView,
              () {
                
              }
            ),
          );
        }
      }

/*
      final items = <ItemBoton>[
        //if(objPermisos.mainMenu.itemListLeads)
        ItemBoton('','','',1, Icons.group_add, 'Reservación 1', 'Detalle de la Reservación 1','','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
          RoutersApp().routReservationView,
          () {
            
          }
        ),
        
        ItemBoton('','','',2, Icons.groups, 'Reservación 2', 'Detalle de la Reservación 2','','', Colors.white, Colors.white,false,false,'','','icTramApr.png','icTramAprTrans.png','',
          RoutersApp().routReservationView,
          () {
            
          }
        ),
        
        ItemBoton('','','',3, Icons.calendar_month, 'Reservación 3', 'Detalle de la Reservación 3','','', Colors.white, Colors.white,false,false,'','','icTramProc.png','icTramProcTrans.png','',
          RoutersApp().routReservationView, 
          () {}
        ),        
      ]; 
      */

      final jsonString = serializeItemBotonMenuList(items);

      return jsonString;
    }
    catch(ex){
      return '';
    }
  }

  Future<String> getReceipts() async {

    try{
      List<Payment>? rsp = await ReceiptsService().getReceipts();

      final items = <ItemBoton>[];

      if(rsp != null && rsp.isNotEmpty){
        for(int i = 0; i < rsp.length; i++){
          items.add(
            //ItemBoton('','','',rsp[i].paymentId, Icons.group_add, 'Recibo #${rsp[i].paymentName}', 'Fecha de pago ${rsp[i].paymentDate}', '\$${rsp[i].paymentAmount.toStringAsFixed(2)}','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
            ItemBoton('','','',rsp[i].paymentId, Icons.group_add, 'Recibo #${rsp[i].paymentName}', rsp[i].paymentDate, '\$${rsp[i].paymentAmount.toStringAsFixed(2)}','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
              RoutersApp().routPrintReceiptView,
              () {
                
              }
            ),
          );
        }
      }

      final jsonString = serializeItemBotonMenuList(items);

      return jsonString;
    }
    catch(ex){
      return '';
    }
  }

  Future<String> getRptAccountStatement(List<int> contractIds) async {

    try{
      //List<Payment>? rsp = await ReceiptsService().getReceipts();
      List<CustomerStatementItem>? rsp = await AccountStatementService().getRptAccountStatement(contractIds);

      final items = <ItemBoton>[];

      if(rsp.isNotEmpty){
        for(int i = 0; i < rsp.length; i++){
          items.add(
            //ItemBoton('','','',rsp[i].paymentId, Icons.group_add, 'Recibo #${rsp[i].paymentName}', rsp[i].paymentDate, '\$${rsp[i].paymentAmount.toStringAsFixed(2)}','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
            ItemBoton('','','',rsp[i].partnerId, Icons.group_add, rsp[i].planName, rsp[i].paymentDate, '\$${rsp[i].paymentAmount?.toStringAsFixed(2)}','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
              RoutersApp().routPrintReceiptView,
              () {
                
              }
            ),
          );
        }
      }

      final jsonString = serializeItemBotonMenuList(items);

      return jsonString;
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

  String serializeItemBotonMenuList(List<ItemBoton> items) {    
    final serializedList = items.map((item) => serializeItemBotonMenu(item)).toList();

    return jsonEncode(serializedList);
  }

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


}

