
//import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';

final objRutas = RoutersApp();

final GoRouter appRouter = GoRouter(
  routes: [//
    GoRoute(
      path: objRutas.rutaAuth,
      builder: (context, state) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return const AuthScreen(null);
          /*
          return FutureBuilder(
            future: state.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if(!snapshot.hasData) {
                return const LoadingScreen(null);
              } else {
                if(snapshot.data != '') {
                    if(snapshot.data == 'log') {
                      return const AuthScreen(null);
                    }
                    
                    if(snapshot.data == 'home') {
                      return const HomeScreen(null);
                    }
                    
                  //}
                }
              }
              return PrincipalScreen();
              //return WelcomeScreen(null);
            }
          );
        */
        },
      ),
    ),
    GoRoute(
      path: objRutas.routPdfView,
      builder: (context, state) => PdfView(
        null,
        'Estados de cuenta',
        'Estados de cuenta',
        'Estados de cuenta',
        'Estados de cuenta',
        true        
      ),
    ),
    GoRoute(
      path: objRutas.rutaDefault,
      builder: (context, state) => PrincipalScreen(),
    ),
    GoRoute(
      path: objRutas.rutaPrincipalUser,
      builder: (context, state) => const PrincipalUserScreen(null),
    ),
    GoRoute(
      path: objRutas.routManualSplashScreen,
      builder: (context, state) => const ManualSplashScreen(),
    ),
  ],
  initialLocation: objRutas.routManualSplashScreen,
);
//