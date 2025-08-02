import 'package:cve_app/infraestructure/services/services.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

String direccionUser = '';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(locGen!.myProfileLbl),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: AuthServices().getDatosPerfil(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileCard(context, size),
                const SizedBox(height: 20),
                _buildOptionCard(context),
                const SizedBox(height: 20),
                Text(locGen!.moreLbl, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildAdditionalOptions(context),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, Size size) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.grey),
          ),
          SizedBox(width: size.width * 0.035),//16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize16)
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  direccionUser,
                  style: TextStyle(
                    color: Colors.white70, 
                    fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize13)
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.push(objRutas.rutaFrmProfileScrn);
            },
            child: const Icon(Icons.edit, color: Colors.white)
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? 
          Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        children: [
          _buildListTile(context, Icons.lock, locGen!.chngPasswLbl),//'Cambiar contraseña'),
          const Divider(height: 1),
          _buildListTile(context, Icons.settings, locGen!.settingLbl),//'Configuración'),
        ],
      ),
    );
  }

  Widget _buildAdditionalOptions(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? 
          Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        children: [
          _buildListTile(context, Icons.privacy_tip, locGen!.privPolLbl),//'Política de privacidad'),
          const Divider(height: 1),
          _buildListTile(context, Icons.description, locGen!.termCondLbl),//'Términos y condiciones'),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontSize: fontSizeManagerGen.get(FontSizesConfig().fontSize13)),),
      trailing: Icon(
        Icons.arrow_forward_ios,
      ),
      onTap: () {
        
        if(title == locGen!.chngPasswLbl){
          context.push(objRutas.rutaContrasenaScreen);
        }

        if(title == locGen!.settingLbl){
          context.push(objRutas.rutaSettingUserScrn);
        }

        if(title == locGen!.privPolLbl){
          //context.push(objRutas.rutaSettingUserScrn);
        }

        if(title == locGen!.termCondLbl){
          //context.push(objRutas.rutaSettingUserScrn);
        }

      },
    );
  }
}
