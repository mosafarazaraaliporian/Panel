import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;

void openDevicePopup(String deviceId) {
  if (!kIsWeb) return;
  
  final currentUrl = Uri.base.toString().split('#')[0];
  final deviceUrl = '$currentUrl#/device/$deviceId';
  
  final width = 414;
  final height = 896;
  
  final screenWidth = js.context['window']['screen']['width'] as int? ?? 1920;
  final screenHeight = js.context['window']['screen']['height'] as int? ?? 1080;
  
  final left = ((screenWidth - width) / 2).round();
  final top = ((screenHeight - height) / 2).round();
  
  final features = 'width=$width,height=$height,left=$left,top=$top,resizable=yes,scrollbars=yes,toolbar=no,menubar=no';
  
  js.context.callMethod('open', [deviceUrl, '_blank', features]);
}
