import 'package:cached_network_image/cached_network_image.dart';
import 'package:cve_app/auth_services.dart';
import 'package:cve_app/config/config.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuLateralWidget extends StatelessWidget {
  final Size size;
  final dynamic gnrBloc;
  final dynamic locGen;
  final dynamic objRutas;
  final dynamic fontSizeManager;
  final GenericState stateGen;

  const MenuLateralWidget({
    super.key,
    required this.size,
    required this.gnrBloc,
    required this.locGen,
    required this.objRutas,
    required this.fontSizeManager,
    required this.stateGen
  });

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    Color colorLblEstadoCuenta = themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? Colors.black : Colors.white;
    Color colorLblDeuda = themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? Colors.black : Colors.white;
    Color colorLblDepositos = themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? Colors.black : Colors.white;
    Color colorLblRecibos = themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? Colors.black : Colors.white;
    Color colorLblReservaciones = themeProvider.themeMode.index == 0 || themeProvider.themeMode.index == 1 ? Colors.black : Colors.white;              

    if(stateGen.viewAccountStatement){
      colorLblEstadoCuenta = Colors.grey;
    }

    if(stateGen.viewViewDebts){
      colorLblDeuda = Colors.grey;
    }

    if(stateGen.viewSendDeposits){
      colorLblDepositos = Colors.grey;
    }

    if(stateGen.viewPrintReceipts){
      colorLblRecibos = Colors.grey;
    }

    if(stateGen.viewViewReservations){
      colorLblReservaciones = Colors.grey;
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: size.height * 0.075),

          GestureDetector(
            onTap: () {
              context.push(objRutas.rutaPerfilScreen);
            },
            child: _buildProfileCard(context, size),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              locGen!.menuHomeLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
              ),
            ),
            onTap: () {
              gnrBloc.setShowViewAccountStatementEvent(false);
              gnrBloc.setShowViewDebts(false);
              gnrBloc.setShowViewPrintRecipts(false);
              gnrBloc.setShowViewReservetions(false);
              gnrBloc.setShowViewSendDeposits(false);
              gnrBloc.setShowViewFrmDeposit(false);

              context.pop();

            },
          ),


          ListTile(
            leading: Icon(Icons.document_scanner, color: colorLblEstadoCuenta),
            title: Text(
              locGen!.menuAccountStatementLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
                color: colorLblEstadoCuenta,
              ),
            ),
            onTap: () {
              gnrBloc.setShowViewAccountStatementEvent(true);
              gnrBloc.setShowViewDebts(false);
              gnrBloc.setShowViewPrintRecipts(false);
              gnrBloc.setShowViewReservetions(false);
              gnrBloc.setShowViewSendDeposits(false);
              gnrBloc.setShowViewWebSite(false);
              gnrBloc.setShowViewFrmDeposit(false);

              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.home, color: colorLblDeuda),
            title: Text(
              locGen!.menuDebtsLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
                color: colorLblDeuda,
              ),
            ),
            onTap: () {
              
              gnrBloc.setShowViewAccountStatementEvent(false);
              gnrBloc.setShowViewDebts(true);
              gnrBloc.setShowViewPrintRecipts(false);
              gnrBloc.setShowViewReservetions(false);
              gnrBloc.setShowViewSendDeposits(false);
              gnrBloc.setShowViewWebSite(false);
              gnrBloc.setShowViewFrmDeposit(false);

              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.send, color: colorLblDepositos),
            title: Text(
              locGen!.menuSendDepositsLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
                color: colorLblDepositos,
              ),
            ),
            onTap: () {
              gnrBloc.setShowViewAccountStatementEvent(false);
              gnrBloc.setShowViewDebts(false);
              gnrBloc.setShowViewPrintRecipts(false);
              gnrBloc.setShowViewReservetions(false);
              gnrBloc.setShowViewSendDeposits(true);
              gnrBloc.setShowViewWebSite(false);
              gnrBloc.setShowViewFrmDeposit(false);

              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.print, color: colorLblRecibos),
            title: Text(
              locGen!.menuPrintReceiptsLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
                color: colorLblRecibos,
              ),
            ),
            onTap: () {
              gnrBloc.setShowViewAccountStatementEvent(false);
              gnrBloc.setShowViewDebts(false);
              gnrBloc.setShowViewPrintRecipts(true);
              gnrBloc.setShowViewReservetions(false);
              gnrBloc.setShowViewSendDeposits(false);
              gnrBloc.setShowViewWebSite(false);
              gnrBloc.setShowViewFrmDeposit(false);

              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.visibility, color: colorLblReservaciones),
            title: Text(
              locGen!.menuSeeReservationsLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
                color: colorLblReservaciones,
              ),
            ),
            onTap: () {
              gnrBloc.setShowViewAccountStatementEvent(false);
              gnrBloc.setShowViewDebts(false);
              gnrBloc.setShowViewPrintRecipts(false);
              gnrBloc.setShowViewReservetions(true);
              gnrBloc.setShowViewSendDeposits(false);
              gnrBloc.setShowViewWebSite(false);
              gnrBloc.setShowViewFrmDeposit(false);

              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.web_rounded),
            title: Text(
              locGen!.menuWebSiteLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
              ),
            ),
            onTap: () {
              gnrBloc.setShowViewAccountStatementEvent(false);
              gnrBloc.setShowViewDebts(false);
              gnrBloc.setShowViewPrintRecipts(false);
              gnrBloc.setShowViewReservetions(false);
              gnrBloc.setShowViewSendDeposits(false);
              gnrBloc.setShowViewFrmDeposit(false);

              context.pop();
              context.push(objRutas.rutaDefault);
            },
          ),

          SizedBox(height: size.height * 0.29),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              locGen!.menuLogOutLbl,
              style: TextStyle(
                fontSize: fontSizeManager.get(FontSizesConfig().fontSize16),
              ),
            ),
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(locGen!.logoutMsmLbl),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          gnrBloc.setShowViewAccountStatementEvent(false);
                          gnrBloc.setShowViewDebts(false);
                          gnrBloc.setShowViewPrintRecipts(false);
                          gnrBloc.setShowViewReservetions(false);
                          gnrBloc.setShowViewSendDeposits(false);
                          gnrBloc.setShowViewWebSite(false);
                          gnrBloc.setShowViewFrmDeposit(false);

                          await AuthService().logOut();
                          // ignore: use_build_context_synchronously
                          context.push(objRutas.rutaAuth);

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();

                        },
                        child: Text(
                          locGen!.confirmOnlyLbl,
                          style: TextStyle(color: Colors.blue[200]),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

/*
// ⚠️ Debes implementar este método real según tu código original
Widget _buildProfileCard(BuildContext context, Size size) {
  return Container(
    height: size.height * 0.15,
    color: Colors.grey[200],
    child: const Center(
      child: Text("Profile Card Placeholder"),
    ),
  );
}
*/

  Widget _buildProfileCard(BuildContext context, Size size) {

    final fontSizeManager = Provider.of<FontSizeManager>(context);    

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (fotoUserPrp.isEmpty)
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),

          if (fotoUserPrp.isNotEmpty)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(fotoUserPrp)
          ),

          SizedBox(width: size.width * 0.02),
          
          Container(
            color: Colors.transparent,
            width: size.width * 0.46,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeManager.get(FontSizesConfig().fontSize16)),
                ),
                SizedBox(height: size.height * 0.002),
                Text(
                  direccionUserPrp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeManager.get(FontSizesConfig().fontSize14)),
                ),
                SizedBox(height: size.height * 0.002),
                /*
                Text(
                  'Propietario',
                  style: TextStyle(color: Colors.black, fontSize: fontSizeManager.get(FontSizesConfig().fontSize14)),
                ),
                */
              ],
            ),
          ),

          //SizedBox(width: 10),
          SizedBox(width: size.width * 0.0005),

          const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ],
      ),
    );
  }

