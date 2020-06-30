import 'dart:convert';
import 'package:http/http.dart' as http;

class tipogasto_service {
  dynamic id;
  dynamic nome;

  tipogasto_service({this.id, this.nome});

  factory tipogasto_service.fromJson(Map<String, dynamic> json) {
    return tipogasto_service(
      id: json['id'] as int,
      nome: json['nome'] as String,
    );
  }

  static const baseUrl = "http://10.0.2.2:8090";

  static Future<List<tipogasto_service>> getExpenses() async {
    try {
      var url = baseUrl + "/tipogasto";
      final response =
      await http.get(url, headers: {"Content-Type": "application/json"});
      if (200 == response.statusCode) {
        List<tipogasto_service> list = parseResponse(response.body);
        return list;
      } else {
        return List<tipogasto_service>();
      }
    } catch (e) {
      return List<tipogasto_service>();
    }
  }

  static List<tipogasto_service> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<tipogasto_service>((json) => tipogasto_service.fromJson(json))
        .toList();
  }

}
