// Conditional import: this file exists for non-web platforms
// For web, use dns_lookup_stub.dart instead

import 'dart:async';
import 'dart:io';

Future<bool> performDnsLookup(String host) async {
  try {
    final result = await InternetAddress.lookup(host)
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () => throw TimeoutException('Connection timeout'),
        );
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (e) {
    return false;
  }
}

