# dart_gql

**dart_gql** es una librería multiplataforma para Dart y Flutter que facilita la integración con servidores GraphQL, soportando HTTP, WebSocket, manejo avanzado de cookies y configuración flexible del cliente.

**[English version](https://github.com/pjmd89/dart_gql/blob/main/README.md)**

## Características

- Compatible con Dart puro y Flutter.
- Queries, mutaciones y suscripciones GraphQL.
- Soporte para WebSocket y HTTP (con `graphql/client.dart`).
- Manejo automático y personalizado de cookies (ideal para autenticación y sesión).
- Permite conexiones inseguras (aceptar certificados no válidos) en VM.
- API sencilla y extensible.
- Configuración avanzada de políticas de caché y fetch.

## Instalación

Agrega la dependencia en tu `pubspec.yaml`:

```yaml
dependencies:
	dart_gql: ^0.2.0
```

Luego ejecuta:

```bash
dart pub get
```

## Uso básico

### 1. Importa la librería

```dart
import 'package:dart_gql/dart_gql.dart';
```

### 2. Inicializa el cliente

```dart
final dartGql = DartGql(
	apiURL: 'https://tu-servidor-graphql.com/graphql',
	wsURL: 'wss://tu-servidor-graphql.com/graphql', // Opcional, para suscripciones
	insecure: false, // Opcional, para aceptar certificados no válidos en VM
);
```


### 3. Realiza una consulta

```dart
import 'package:dart_gql/dart_gql.dart';

final options = QueryOptions(
	document: gql('query { users { id name } }'),
);

final result = await dartGql.query(options);

if (result.hasException) {
	print('Error: ${result.exception}');
} else {
	print('Datos: ${result.data}');
}
```

### 4. Realiza una mutación

```dart
final mutationOptions = MutationOptions(
	document: gql('mutation { addUser(name: "Juan") { id name } }'),
);

final mutationResult = await dartGql.mutate(mutationOptions);
if (mutationResult.hasException) {
	print('Error en mutación: ${mutationResult.exception}');
} else {
	print('Datos de mutación: ${mutationResult.data}');
}
```

### 5. Suscríbete a actualizaciones en tiempo real

```dart
final subscriptionOptions = SubscriptionOptions(
	document: gql('subscription { mensajeNuevo { id texto } }'),
);

final subscription = dartGql.subscribe(subscriptionOptions).listen((result) {
	if (result.hasException) {
		print('Error en suscripción: ${result.exception}');
	} else {
		print('Datos de suscripción: ${result.data}');
	}
});
```

Para cancelar la suscripción y cerrar la conexión:

```dart
subscription.cancel();
```

> **Nota:** La suscripción permanece activa y recibe datos hasta que llames a `subscription.cancel()` o el servidor cierre la conexión.

### 4. Manejo de cookies

El cliente maneja cookies automáticamente. Si necesitas acceder o modificar las cookies manualmente (por ejemplo, para autenticación), puedes hacerlo a través de la clase `CustomClient`:

```dart
final client = createHttpClient();
if (client is CustomClient) {
	print('Cookies actuales: ${client.valueCookie}');
	// Puedes modificar el valor manualmente si lo necesitas
	client.valueCookie = 'mi_cookie=valor';
}
```

### 5. Suscripciones (WebSocket)

Si tu servidor soporta suscripciones GraphQL, solo debes pasar el `wsURL` al inicializar el cliente. Las suscripciones se gestionan automáticamente usando `WebSocketLink`.

## Compatibilidad

- Dart VM (desktop, móvil, consola)
- Flutter (móvil, web, desktop)
- Web (usando imports condicionales y `BrowserClient`)

## Contribuir

¡Las contribuciones son bienvenidas!  
Abre un issue o un pull request en [GitHub](https://github.com/pjmd89/dart_gql).

## Licencia

MIT

