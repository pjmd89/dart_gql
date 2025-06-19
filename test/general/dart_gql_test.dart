import 'package:dart_gql/main.dart';
import 'package:test/test.dart';
void main(){

  late DartGql dartGql;

  setUp(() {
    dartGql = DartGql(
      apiURL: 'http://localhost:8081',
      wsURL: 'ws://localhost:8081/ws',
    );
  });

  test('Query cookies returns data or error', () async {
    final result = await dartGql.client.query(
      QueryOptions(
        document: gql('''
          query GetTypeName {
            __typename
          }
        '''),
      ),
    );

    if (result.hasException) {
      expect(result.hasException, isTrue);
    } else {
      expect(result.data, isNotNull);
      expect(result.data!['__typename'], "Query");
    }
  });
}