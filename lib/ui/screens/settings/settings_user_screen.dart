import 'package:cve_app/config/config.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

double _fontSize = 0;

class SettingsUserScreen extends StatefulWidget {
  const SettingsUserScreen({super.key});

  @override
  State<SettingsUserScreen> createState() => _SettingsUserScreenState();
}

class _SettingsUserScreenState extends State<SettingsUserScreen> {
  String selectedLanguage = 'Español';
  String selectedMode = 'Claro';

  @override
  void initState() {
    super.initState();
    _fontSize = 0;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final languageProvider = Provider.of<LanguageProvider>(context);    
    final fontSizeManager = Provider.of<FontSizeManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locGen!.settingLbl),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: GenericService().settingsLoad(),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            var fontSize = snapshot.data as String;
            _fontSize = double.parse(fontSize);
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Container(
                  width: size.width,
                  height: size.height * 0.08,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.45,
                        height: size.height * 0.08,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: Text(locGen!.languageLbl, style: TextStyle(fontSize: fontSizeManager.get(FontSizesConfig().fontSize18), fontWeight: FontWeight.bold))//fontSize: 16
                      ),
          
                      Container(
                        width: size.width * 0.32,
                        height: size.height * 0.08,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: DropdownButtonFormField<String>(
                          //dropdownColor: const Color(0xFF53C9EC),
                          decoration: InputDecoration(
                            labelText: '',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0), // Bordes redondos
                            ),
                          ),
                          value: languageProvider.locale.languageCode,
                          items: const [
                            DropdownMenuItem(value: 'en', child: Text('English', style: TextStyle(color: Colors.black,  ),)),
                            DropdownMenuItem(value: 'es', child: Text('Español', style: TextStyle(color: Colors.black, ))),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              languageProvider.changeLocale(value);
                            }
                          },
                        ),
                      ),
                      
                    ],
                  ),
                ),
          
                SizedBox(height: size.height * 0.035),
          
                Text(locGen!.brightnessLbl, style: TextStyle(fontSize: fontSizeManager.get(FontSizesConfig().fontSize18), fontWeight: FontWeight.bold)),//fontize: 16
                
                SizedBox(height: size.height * 0.025),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    brightnessOption(locGen!.lghtModeLbl, locGen!.lghtModeLbl, size, 'assets/images/modo_claro.png'),
                    brightnessOption(locGen!.drkModeLbl, locGen!.drkModeLbl, size, 'assets/images/modo_oscuro.png'),
                    brightnessOption(locGen!.automaticLbl, locGen!.automaticLbl, size, 'assets/images/modo_automatico.png'),
                  ],
                ),
          
                SizedBox(height: size.height * 0.045),
          
                Container(
                  height: size.height * 0.22,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(locGen!.fontSizeLbl, style: TextStyle(fontSize: fontSizeManager.get(FontSizesConfig().fontSize20), fontWeight: FontWeight.bold, color: Colors.white)),
                      
                      Text('${_fontSize.toStringAsFixed(0)}%', style: TextStyle(fontSize: fontSizeManager.get(FontSizesConfig().fontSize20), fontWeight: FontWeight.bold, color: Colors.white)),
          
                      Slider(
                        min: 0.0,
                        max: 150.0,
                        divisions: 15,
                        value: _fontSize,
                        label: '${_fontSize.toStringAsFixed(1)}%',
                        onChanged: (newValue) async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setInt('PorcFontSize', newValue.toInt());
                          await fontSizeManager.loadFontSizes();
                          
                          setState(() {
                            _fontSize = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 30),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget brightnessOption(String label, String mode, Size size, String image) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    bool isSelected = selectedMode == mode;

    return GestureDetector(
      onTap: () {
        if(locGen != null){
          ThemeMode objThemeMode = ThemeMode.system;

          if (mode == locGen!.lghtModeLbl) {
            objThemeMode = ThemeMode.light;
          } else if (mode == locGen!.drkModeLbl) {
            objThemeMode = ThemeMode.dark;
          } else {
            objThemeMode = ThemeMode.system;
          }

          themeProvider.setTheme(objThemeMode);

          setState(() {
            selectedMode = mode;
          });
        }
      },
      child: Column(
        children: [
          Container(
            width: size.width * 0.25,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: isSelected ? Colors.blue : Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              height: size.height * 0.13,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),                
                image: DecorationImage(
                  image: AssetImage(image), // Imagen local
                  fit: BoxFit.fill, // Ajusta la imagen al contenedor
                ),
              ),
              alignment: Alignment.center,
            ),
          ),

          SizedBox(height: size.height * 0.02),

          Text(label, style: TextStyle(color: isSelected ? Colors.blue : Colors.grey[400])),
        ],
      ),
    );
  }
}
