import 'package:http/http.dart';
class CustomClient extends BaseClient {
  final Client _inner;
  String? _valueCookie;
  get valueCookie => _valueCookie;
  CustomClient(this._inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (_valueCookie != null && _valueCookie!.isNotEmpty) {
      request.headers['Cookie'] = _valueCookie!;
    }
    return _inner.send(request).then((response) {
      final cookies = response.headers['set-cookie'] ?? '';
      if (cookies.isNotEmpty) {
        final cookie = cookies.split(';')[0]; 
        _valueCookie = cookie;
      }
      return response;
    });
  }
}