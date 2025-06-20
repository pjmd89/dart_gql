import 'package:dart_gql/dart_gql.dart';
import 'package:http/http.dart';
import 'package:graphql/client.dart';
export 'package:graphql/client.dart'
  show 
    GraphQLClient,
    GraphQLCache,
    HttpLink,
    WebSocketLink,
    Link,
    DefaultPolicies,
    Policies,
    FetchPolicy,
    CacheRereadPolicy,
    GraphQLProtocol,
    QueryOptions,
    SocketClientConfig;
class DartGql {
  static const String version = '0.1.0';
  static const String name = 'dart_gql';
  static const String description = 'A Dart library for GraphQL operations.';
  static const String author = 'Pablo Munoz<pjmd89@gmail.com>';

  late String _apiURL;
  String? _wsURL;
  late WebSocketLink _wsLink;
  late Client _client;
  late Link _link;
  late GraphQLClient _gqlClient;
  final Policies _policies = Policies(
    fetch: FetchPolicy.noCache,
    cacheReread: CacheRereadPolicy.ignoreAll,
  );

  GraphQLClient get client => _gqlClient;

  DartGql({required String apiURL, String? wsURL, bool insecure = false}) {
    _apiURL = apiURL;
    _wsURL = wsURL;
    _client = createHttpClient(insecure: insecure);
    _link = HttpLink(_apiURL, httpClient:_client);

    if (_wsURL != null && _wsURL!.trim().isEmpty == false ) {
      _wsLink = WebSocketLink(
        _wsURL!,
        subProtocol: GraphQLProtocol.graphqlTransportWs,
      );
      if (_client is CustomClient) {
        
        _wsLink = WebSocketLink(
          _wsURL!,
          subProtocol: GraphQLProtocol.graphqlTransportWs,
          config: SocketClientConfig(
            headers: {
              "Cookie": (_client as CustomClient).valueCookie,
            },
          ),
        );
      }
      _link = Link.split((request) => request.isSubscription, _wsLink, _link);
    }
    _gqlClient = GraphQLClient(
      link: _link,
      queryRequestTimeout: Duration(seconds: 10),
      defaultPolicies: DefaultPolicies(
        watchQuery: _policies,
        query: _policies,
        mutate: _policies,
        watchMutation: _policies,
        subscribe: _policies,
      ),
      cache: GraphQLCache(),
    );
  }
}