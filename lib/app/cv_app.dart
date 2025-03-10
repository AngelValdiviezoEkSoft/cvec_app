
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cve_app/config/config.dart';

class CentroViajesApp extends StatefulWidget {
  
  const CentroViajesApp(Key? key,
  ) : super(key: key);

  @override
  CentroViajesAppState createState() => CentroViajesAppState();
}

class CentroViajesAppState extends State<CentroViajesApp> {
  //final TokenManager tokenManager = TokenManager();
  //final cron = Cron();

  @override
  void initState() {
    super.initState();    
  }

  @override
  void dispose() {
    /*
    cron.close();
    tokenManager.stopTokenCheck();
    */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp.router(
        title: 'Centro de viajes',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      );
  }
}
