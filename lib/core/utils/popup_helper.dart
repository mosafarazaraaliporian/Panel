import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html if (dart.library.html);

void openDevicePopup(String deviceId) {
  if (!kIsWeb) return;
  
  final currentUrl = Uri.base.toString().split('#')[0];
  final deviceUrl = '$currentUrl#/device/$deviceId';
  
  const width = 414;
  const height = 896;
  
  final screenWidth = html.window.screen?.width ?? 1920;
  final screenHeight = html.window.screen?.height ?? 1080;
  
  final left = ((screenWidth - width) / 2).round();
  final top = ((screenHeight - height) / 2).round();
  
  final features = 'width=$width,height=$height,left=$left,top=$top,resizable=yes,scrollbars=yes,toolbar=no,menubar=no';
  
  html.window.open(deviceUrl, '_blank', features);
}
