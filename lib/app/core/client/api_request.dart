import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ApiRequest {
  static Future<Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return http.get(Uri.parse(url), headers: headers);
  }

  static Future<Response> post(
    Uri url, {
    Map? body,
    Map<String, String>? headers,
  }) async {
    return http.post(
      url,
      headers: headers,
      body: body,
    );
  }
}
