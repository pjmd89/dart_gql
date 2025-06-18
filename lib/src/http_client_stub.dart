import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:dart_gql/src/custom_client.dart';

bool get isWeb => false;
Client createHttpClientStubWeb({bool insecure = false}) {
  var client = HttpClient();
  if (insecure) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
  var customClient = IOClient(client);

  return CustomClient(customClient);
}