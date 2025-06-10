import 'package:flutter/services.dart';

class EmojiInputFormatter extends TextInputFormatter {
  
  static final RegExp _emojiRegex = RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String filteredText = newValue.text.replaceAll(_emojiRegex, '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}
