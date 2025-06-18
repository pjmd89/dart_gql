import 'package:http/browser_client.dart';
import 'package:http/http.dart';

bool get isWeb => true;
Client createHttpClientStubWeb({insecure = false}) {
  final client = BrowserClient();
  client.withCredentials = true;
  return client;
}
