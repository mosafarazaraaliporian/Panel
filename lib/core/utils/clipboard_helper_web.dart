import 'dart:html' as html;
import 'package:flutter/services.dart';

Future<bool> copyToClipboardWeb(String text) async {
  try {
    final textArea = html.TextAreaElement();
    textArea.value = text;
    textArea.style.position = 'fixed';
    textArea.style.top = '-9999px';
    textArea.style.left = '-9999px';
    html.document.body!.append(textArea);
    textArea.select();
    final success = html.document.execCommand('copy');
    textArea.remove();
    if (success) {
      return true;
    }
    try {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } catch (_) {
      return false;
    }
  } catch (e) {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } catch (_) {
      return false;
    }
  }
}

