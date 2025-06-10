
import 'package:flutter/material.dart';

class OptionsMenuModel {
    OptionsMenuModel({
      required this.icono,
      required this.descMenu,
      required this.onPress
    });

    IconData icono;
    String descMenu;
    @required final VoidCallback? onPress;

}
