part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  
  final storage = const FlutterSecureStorage();

  @override
  List<Object> get props => [];
  
  Future<String> readToken() async {
    try {
      String rspFinal = 'home';

      var rspReg = await storage.read(key: 'RespuestaRegistro') ?? '';
      var rspLog = await storage.read(key: 'RespuestaLogin') ?? '';
      await storage.write(key: 'fecMem', value: '');
      await storage.write(key: 'idMem', value: '');

      final prefs = await SharedPreferences.getInstance();
      
      if(prefs.getInt('PorcFontSize') == null){
        prefs.setInt('PorcFontSize', 100);
      }

      displayName = await storage.read(key: 'PartnerDisplayName') ?? '';

      final rspLogin = await storage.read(key: 'DataUser') ?? '';
      var rsp = jsonDecode(rspLogin);
  
      direccionUserPrp = rsp["result"]["street"] ?? '';

      if(rspReg.isEmpty && rspLog.isEmpty){
        rspFinal = '';
      }
      else {
        if(rspLog.isEmpty){
          rspFinal = 'log';
        }        
      }
      
      return rspFinal;
    }
    catch(ex) {
      return '';
    }
    
  }

}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthNoInternet extends AuthState {}

class AuthGpsFake extends AuthState {}

class ValidLicenseKey extends AuthState {}

class InvalidLicenseKey extends AuthState {}

class PinCompleted extends AuthState {}

class PinSubmitted extends AuthState {}

class InvalidPin extends AuthState {}

class ValidPin extends AuthState {}

class AuthRegistered extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}


