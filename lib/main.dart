
import 'package:cve_app/app/app.dart';
import 'package:cve_app/infraestructure/provider/language_provider.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:secure_application/secure_application.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'infraestructure/services/services.dart';
import 'package:provider/src/change_notifier_provider.dart' as np;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  setupServiceLocator();

  await initializeDateFormatting();

  final fontSizeManager = FontSizeManager();
  await fontSizeManager.loadFontSizes();

  runApp(
    MultiProvider(
      providers:[//
        np.ChangeNotifierProvider(create: (_) => FontSizeManager()),
        np.ChangeNotifierProvider(create: (_) => ThemeProvider()),
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(AppStarted())),
        BlocProvider(create: (context) => getIt<GenericBloc>()),
        BlocProvider(create: (context) => getIt<LanguageBloc>()),        
      ],
      child: ProviderScope(
        child: SecureApplication(
          secureApplicationController: SecureApplicationController(
            SecureApplicationState(
              secured: true, 
              locked: true
            )
          ),
          child: np.ChangeNotifierProvider(            
            create: (_) => LanguageProvider(),
            child: const CentroViajesApp(null)
          )
        )
      ),
    )
  );
}
