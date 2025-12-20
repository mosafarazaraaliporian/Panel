import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

Future<bool> copyToClipboard(String text) async {
  try {
    if (kIsWeb) {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } else {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    }
  } catch (e) {
    return false;
  }
}

