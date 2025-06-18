import 'src/http_client_stub.dart'
    if (dart.library.html) 'src/http_client_web.dart' as http_client_web;
export 'src/custom_client.dart';

get isWeb => http_client_web.isWeb;
createHttpClient({insecure = false}) {
  return http_client_web.createHttpClientStubWeb(insecure: insecure);
}