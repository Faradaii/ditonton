import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class NetworkHelper {
  static NetworkHelper? _networkHelper;
  late final IOClient _client;

  NetworkHelper._internal() {
    _client = _initializeClient();
    _networkHelper = this;
  }

  factory NetworkHelper() => _networkHelper ?? NetworkHelper._internal();

  IOClient get client => _client;

  IOClient _initializeClient() {
    final securityContext = SecurityContext(withTrustedRoots: false);
    _loadCertificate(securityContext);

    final httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return IOClient(httpClient);
  }

  void _loadCertificate(SecurityContext context) {
    rootBundle.load('assets/certificates/themoviedborg.pem').then((cert) {
      context.setTrustedCertificatesBytes(cert.buffer.asInt8List());
    }).catchError((e) {
      throw Exception("Failed to load certificate: $e");
    });
  }
}
