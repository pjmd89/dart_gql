import 'dart:convert';
import 'package:test/test.dart';
import 'package:dart_gql/dart_gql.dart';
import 'package:http/http.dart' as http;

void main() {
  
  test('El cliente almacena y reenvía cookies usando httpbingo', () async {

    var request = http.Request('GET', Uri.parse('https://httpbingo.org/cookies/set?mycookie=valor'));
    request.followRedirects = false;
    final client = createHttpClient();

    final streamedResponse = await client.send(request);
    
    final response1 = await http.Response.fromStream(streamedResponse);
    expect(response1.statusCode, 302);

    // Segunda petición para verificar que la cookie se reenvía
    final response2 = await client.get(Uri.parse('https://httpbingo.org/cookies'));
    final cookiesJson = jsonDecode(response2.body);
    expect(cookiesJson['mycookie'], equals('valor'));
  });
}
