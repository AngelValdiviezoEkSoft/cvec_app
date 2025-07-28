
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
//import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cve_app/config/config.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
//import 'generated/l10n.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cve_app/l10n/app_localizations.dart';

class CentroViajesApp extends StatefulWidget {
  
  const CentroViajesApp(Key? key,
  ) : super(key: key);

  @override
  CentroViajesAppState createState() => CentroViajesAppState();
}

class CentroViajesAppState extends State<CentroViajesApp> {
  //final TokenManager tokenManager = TokenManager();
  //final cron = Cron();
  Locale localeGen = const Locale('en');

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

  void onLocaleChange(String languageCode) {
    
    setState(() {
      localeGen = Locale(languageCode);
    });
    
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.loadTheme();
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: 
      Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return 
          
          MaterialApp.router(
              locale: Locale(languageProvider.localeStr),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              title: 'Centro de viajes',
              debugShowCheckedModeBanner: false,        
              routerConfig: appRouter,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeProvider.themeMode,
            );
        },
        
      )
    );
  }
}
