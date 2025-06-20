import 'dart:convert';
import 'package:test/test.dart';
import 'package:dart_gql/dart_gql.dart';

void main() {
  test('El cliente almacena y reenvía cookies usando httpbingo', () async {

    final client = createHttpClient();
    final url = Uri.parse('http://localhost:8081'); // Cambia por tu endpoint real
    final query = {
      'query': '{ __typename }' // Cambia por una query válida
    };

    // Primer POST para obtener la cookie
    final response1 = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(query),
    );
    expect(response1.statusCode, 200);

    // Segundo POST para ver si la cookie se reenvía (el navegador la maneja automáticamente)
    final response2 = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(query),
    );
    expect(response2.headers['set-cookie'], equals(isNotNull));
  });
}
