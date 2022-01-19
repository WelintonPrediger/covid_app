import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Network {

  static final Network _instance = Network.internal();

  Network.internal();
  factory Network() => _instance;

  final JsonDecoder _decoder = const JsonDecoder();

  Future<dynamic> get({required String url, body, Map<String, String>? headers, encoding}) =>
      http.get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 240))
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        log("url: $url");
        log("status: $statusCode");
        log("response body: ${response.body}");

        if (statusCode < 200 || statusCode > 400) {
          throw Exception("Error while fetching data");
        } else {
          final String responseBody = response.body;
          return _decoder.convert(responseBody);
        }
      });

}