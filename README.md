# dart_gql

**dart_gql** is a multiplatform library for Dart and Flutter that simplifies integration with GraphQL servers, supporting HTTP, WebSocket, advanced cookie management, and flexible client configuration.

**[Versión en Español](https://github.com/pjmd89/dart_gql/blob/main/README_es.md)**

## Features

- Compatible with pure Dart and Flutter.
- Queries, mutations, and GraphQL subscriptions.
- Support for WebSocket and HTTP (with `graphql/client.dart`).
- Automatic and custom cookie management (ideal for authentication and session).
- Allows insecure connections (accept invalid certificates) in VM.
- Simple and extensible API.
- Advanced cache and fetch policy configuration.

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
	dart_gql: ^0.1.0
```

Then run:

```bash
dart pub get
```

## Basic Usage

### 1. Import the library

```dart
import 'package:dart_gql/dart_gql.dart';
```

### 2. Initialize the client

```dart
final dartGql = DartGql(
	apiURL: 'https://your-graphql-server.com/graphql',
	wsURL: 'wss://your-graphql-server.com/graphql', // Optional, for subscriptions
	insecure: false, // Optional, to accept invalid certificates in VM
);
```

### 3. Make a query

```dart
import 'package:dart_gql/dart_gql.dart';

final options = QueryOptions(
	document: gql('query { users { id name } }'),
);

final result = await dartGql.query(options);

if (result.hasException) {
	print('Error: ${result.exception}');
} else {
	print('Data: ${result.data}');
}
```

### 4. Cookie management

The client handles cookies automatically. If you need to access or modify cookies manually (e.g., for authentication), you can do so via the `CustomClient` class:

```dart
final client = createHttpClient();
if (client is CustomClient) {
	print('Current cookies: ${client.valueCookie}');
	// You can manually modify the value if needed
	client.valueCookie = 'my_cookie=value';
}
```

### 5. Subscriptions (WebSocket)

If your server supports GraphQL subscriptions, just pass the `wsURL` when initializing the client. Subscriptions are managed automatically using `WebSocketLink`.

## Compatibility

- Dart VM (desktop, mobile, console)
- Flutter (mobile, web, desktop)
- Web (using conditional imports and `BrowserClient`)

## Contributing

Contributions are welcome!  
Open an issue or pull request on [GitHub](https://github.com/pjmd89/dart_gql).

## License

MIT

